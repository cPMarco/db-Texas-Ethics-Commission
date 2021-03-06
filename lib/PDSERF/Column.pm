# Schema generation for the Texas Ethics Commission
# Copyright (C) 2018  Evan Carroll
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
# 
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

package PDSERF::Column;

use strict;
use feature ':5.26';
use autodie;

use Moose;
use PDSERF::Table;

has 'table'  => ( isa => 'PDSERF::Table', is => 'ro', required => 1 );
has [qw/name type description/] => ( isa => 'Str', is => 'ro', required => 1 );
has 'length' => ( isa => 'Int', is => 'ro', required => 1 );
has 'mask'   => ( isa => 'Str', is => 'ro', required => 1 );
has 'order'  => ( isa => 'Int', is => 'ro' );

sub pg_ddl {
	my $self = shift;
	sprintf(
		"\t%-40s%-20s%-30s",
		$self->name,
		$self->pg_type,
		$self->_column_attributes
	);
}

sub pg_type {
	my $self = shift;
	
	state $types = {
		BigDecimal => 'numeric(10,2)',
		String     => 'text',
		Long       => 'bigint'
	};

	my $coltype;
	if ( $self->name =~ /Ident$/ ) {
		$coltype = 'int';
	}
	elsif ( $self->name =~ /Flag$/ and $self->type ) {
		## XXX: No idea wtf
		## SELECT * FROM candidatedata WHERE capitallivingexpflag = ',';
		if ( $self->name eq 'capitalLivingexpFlag' ) {
			$coltype = 'char(1)';
		}
		else { $coltype = 'bool'; }
	}
	elsif ( defined $types->{$self->type} ) {
		$coltype = $types->{$self->type};
	}
	else {
		$coltype = lc($self->type);
	}
	$coltype;
}


sub pg_comment {
	my $self = shift;
	sprintf(
		"\nCOMMENT ON COLUMN %s IS \$\$%s\$\$;",
		$self->fully_qualified_identifier,
		$self->description
	);
}

sub fully_qualified_identifier {
	my $self = shift;
	my $fqn =  sprintf(
		"%s.%s.%s",
		main::INSTALL_SCHEMA,
		$self->table->name,
		$self->name
	);
	lc($fqn);
}

sub _column_attributes {
	my $self  = shift;
	my $table = $self->table->name;
	my $a = '';

	## Turns out these are all unique and the tables are partitions on recordType
	## ## Handle ReportInfo PRIMARY/FOREIGN KEY
	## if ( $c->{'Field Name'} eq 'reportInfoIdent' ) {
	## 	if ( $t->{'recname'} ne 'FinalData' ) {
	## 		$a = sprintf(
	## 			'REFERENCES %s',
	## 			fully_qualified_identifier(undef, undef, 'FinalData')
	## 		);
	## 	}
	## 	else {
	## 		$a = 'PRIMARY KEY'
	## 	}
	## }
	if (
		$self->name =~ /(.*)InfoId$/                  && $table eq (ucfirst($1)."Data")
		## XXX has ','
		or $self->name eq 'expendCategoryCodeValue'   && $table eq 'ExpendCategory'
	) {
		$a = 'PRIMARY KEY';
	}
	elsif ( $self->name eq 'expendCatCd' ) {
		## XXX  Can't use this because some expenses have `UNKNOWN`
		## $a = 'REFERENCES tecnew.ExpendCategory';
	}
	$a;
};

1;
