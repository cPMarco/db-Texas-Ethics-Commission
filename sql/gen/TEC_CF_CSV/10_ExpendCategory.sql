-- Schema generation for the Texas Ethics Commission
-- Copyright (C) 2018  Evan Carroll
-- 
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU Affero General Public License as
-- published by the Free Software Foundation, either version 3 of the
-- License, or (at your option) any later version.
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Affero General Public License for more details.
-- 
-- You should have received a copy of the GNU Affero General Public License
-- along with this program.  If not, see <https://www.gnu.org/licenses/>.

\echo LOADING ExpendCategory



CREATE TABLE tec.expendcategory (
	recordType                              text,
	expendCategoryCodeValue                 text                PRIMARY KEY,
	expendCategoryCodeLabel                 text
);

COMMENT ON TABLE tec.expendcategory IS $$Expenditure category codes. File: expn_catg.csv$$;
COMMENT ON COLUMN tec.expendcategory.recordtype IS $$Record type code - always EXCAT$$;
COMMENT ON COLUMN tec.expendcategory.expendcategorycodevalue IS $$Expenditure category code$$;
COMMENT ON COLUMN tec.expendcategory.expendcategorycodelabel IS $$Expenditure category description$$;
\COPY tec.expendcategory FROM 'data/TEC_CF_CSV/expn_catg.csv' WITH ( FORMAT CSV , HEADER true )