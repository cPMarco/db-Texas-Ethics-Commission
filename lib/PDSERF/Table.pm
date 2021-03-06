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

package PDSERF::Table;

use strict;
use feature ':5.26';
use autodie;

use PDSERF::Column;

use Moose;
use Moose::Util::TypeConstraints;

subtype 'ArrayOfColumns', as 'ArrayRef[PDSERF::Column]';

coerce 'PDSERF::Column'
	=> from 'HashRef'
	=> via { PDSERF::Column->new($_) };

coerce 'ArrayOfColumns',
	from 'HashRef',
	via { [map PDSERF::Column->new($_), @$_] };

has 'columns' => (
	isa     => 'ArrayOfColumns',
	traits  => ['Array'],
	is      => 'ro',
	default => sub { [] },
	coerce  => 1,
	handles => {
		push_column => 'push'
	}
);
has [qw/description name/] => ( isa => 'Str', is => 'ro', required => 1 );
has order => ( isa => 'Int', is => 'ro', required => 1 );

sub pg_ddl {
	my $self = shift;

	my @body = (map $_->pg_ddl, @{$self->columns}), $self->_pg_table_attributes;
	s/\s+$// for @body;
	
	my $ddl = sprintf (
		"\n\n\nCREATE TABLE %s (\n%s\n);\n",
		$self->fully_qualified_identifier,
		join(",\n", @body)
	);
	$ddl .= $self->pg_comment;
	$ddl .= $_->pg_comment for @{$self->columns};

	$ddl;
}

sub _pg_table_attributes {
	my $self = shift;
	my $a = '';
	## Handles linking and composite key for Filer
	if (
		$self->col_by_name('filerTypeCd')
		and $self->col_by_name('filerIdent')
	) {
		if ( $self->name eq 'FilerData' ) {
			$a = "\tPRIMARY KEY (filerIdent, filerTypeCd)"
		}
		else {
			$a = sprintf(
				"\tFOREIGN KEY (filerIdent, filerTypeCd) REFERENCES %s",
				sprintf("%s.%s", main::INSTALL_SCHEMA, "FilerData" )
			);
		}
	}
	$a;
}

sub fully_qualified_identifier {
	my $self = shift;
	lc(sprintf( "%s.%s", main::INSTALL_SCHEMA, $self->name));
}

sub pg_comment {
	my $self = shift;
	sprintf(
		"\nCOMMENT ON TABLE %s IS \$\$%s\$\$;",
		$self->fully_qualified_identifier,
		$self->description
	);
}

sub psql_copy {
	my ( $self, $dir ) = @_;

	my @loads;
	my $desc = $self->description;
	while ( $desc =~ m/(\S+.csv)/g ) {
		my $file = $1;
		next if $file =~ /_#/;

		## XXX typo!
		$file = 'finals.csv' if $file eq 'final.csv';
		
		push @loads, sprintf(
			"\n\\COPY %s FROM '%s' WITH ( FORMAT CSV , HEADER true )",
			$self->fully_qualified_identifier,
			File::Spec->catfile($dir, $file)
 		);
	}

	return join "\n", @loads;

}

sub col_by_name {
	my ( $self, $colname ) = @_;
	return grep $_->name eq $colname, @{$self->columns}
}

1;
