\echo Schema generation for the Texas Ethics Commission
\echo Copyright (C) 2018  Evan Carroll
\echo 
\echo This program is free software: you can redistribute it and/or modify
\echo it under the terms of the GNU Affero General Public License as
\echo published by the Free Software Foundation, either version 3 of the
\echo License, or (at your option) any later version.
\echo 
\echo This program is distributed in the hope that it will be useful,
\echo but WITHOUT ANY WARRANTY; without even the implied warranty of
\echo MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
\echo GNU Affero General Public License for more details.
\echo 
\echo You should have received a copy of the GNU Affero General Public License
\echo along with this program.  If not, see <https://www.gnu.org/licenses/>.

\prompt agree_eula Do you agree to those terms? [Yes] or [No]

DROP SCHEMA IF EXISTS tec CASCADE;
CREATE SCHEMA tec;
COMMENT ON SCHEMA tec IS $$Texas Ethics Comission dataset$$;

\echo LOADING FORM 1295 [1295Certificates.csv]
\i sql/form1295.sql

\echo LOADING CAMPAIGN FINANCE REPORTS [TEC_CF_CSV.zip]
\i sql/gen/TEC_CF_CSV/10_ExpendCategory.sql
\i sql/gen/TEC_CF_CSV/11_FilerData.sql
\i sql/gen/TEC_CF_CSV/12_FinalData.sql
\i sql/gen/TEC_CF_CSV/13_LoanData.sql
\i sql/gen/TEC_CF_CSV/14_PledgeData.sql
\i sql/gen/TEC_CF_CSV/15_SpacData.sql
\i sql/gen/TEC_CF_CSV/16_TravelData.sql
\i sql/gen/TEC_CF_CSV/01_AssetData.sql
\i sql/gen/TEC_CF_CSV/02_CandidateData.sql
\i sql/gen/TEC_CF_CSV/03_ContributionData.sql
\i sql/gen/TEC_CF_CSV/04_CoverSheet1Data.sql
\i sql/gen/TEC_CF_CSV/05_CoverSheet2Data.sql
\i sql/gen/TEC_CF_CSV/06_CoverSheet3Data.sql
\i sql/gen/TEC_CF_CSV/07_CreditData.sql
\i sql/gen/TEC_CF_CSV/08_DebtData.sql
\i sql/gen/TEC_CF_CSV/09_ExpendData.sql

\echo LOADING LOBY REPORTS [TEC_LA_CSV.zip]
\i sql/gen/TEC_LA_CSV/01_CoverSheetLaData.sql
\i sql/gen/TEC_LA_CSV/02_IndividualReportingData.sql
\i sql/gen/TEC_LA_CSV/03_SubjectMatterData.sql
\i sql/gen/TEC_LA_CSV/04_DocketData.sql
\i sql/gen/TEC_LA_CSV/05_TransportationData.sql
\i sql/gen/TEC_LA_CSV/06_FoodBeverageData.sql
\i sql/gen/TEC_LA_CSV/07_EntertainmentData.sql
\i sql/gen/TEC_LA_CSV/08_GiftData.sql
\i sql/gen/TEC_LA_CSV/09_AwardMementoData.sql
\i sql/gen/TEC_LA_CSV/10_EventData.sql

\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_01.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_02.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_03.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_04.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_05.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_06.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_07.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_08.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_09.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_10.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_11.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_12.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_13.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_14.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_15.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_16.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_17.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_18.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_19.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_20.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_21.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_22.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_23.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_24.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_25.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_26.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_27.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_28.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_29.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_30.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_31.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_32.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_33.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_34.csv' WITH ( FORMAT CSV , HEADER true )
\COPY tec.ContributionData FROM './data/TEC_CF_CSV/contribs_35.csv' WITH ( FORMAT CSV , HEADER true )

\COPY tec.ExpendData FROM './data/TEC_CF_CSV/expend_01.csv' WITH ( FORMAT CSV, HEADER true )
\COPY tec.ExpendData FROM './data/TEC_CF_CSV/expend_02.csv' WITH ( FORMAT CSV, HEADER true )
\COPY tec.ExpendData FROM './data/TEC_CF_CSV/expend_03.csv' WITH ( FORMAT CSV, HEADER true )
\COPY tec.ExpendData FROM './data/TEC_CF_CSV/expend_04.csv' WITH ( FORMAT CSV, HEADER true )
\COPY tec.ExpendData FROM './data/TEC_CF_CSV/expend_05.csv' WITH ( FORMAT CSV, HEADER true )
\COPY tec.ExpendData FROM './data/TEC_CF_CSV/expend_06.csv' WITH ( FORMAT CSV, HEADER true )
\COPY tec.ExpendData FROM './data/TEC_CF_CSV/expend_07.csv' WITH ( FORMAT CSV, HEADER true )

UPDATE tec.CandidateData
	SET expendCatCd = NULL
	WHERE expendCatCd IN ('', 'UNKNOWN');

ALTER TABLE tec.CandidateData
	ADD FOREIGN KEY ( expendCatCd )
	REFERENCES tec.ExpendCategory;
