-- *********************************************************************
-- Update Database Script
-- *********************************************************************
-- Change Log: mimic.yml
-- Ran at: 22/03/17 15:53
-- Against: null@offline:postgresql
-- Liquibase version: 3.5.3
-- *********************************************************************

-- Changeset mimic.yml::1::lcp
CREATE TABLE mimiciii.ADMISSIONS (ROW_ID INT NOT NULL, SUBJECT_ID INT NOT NULL, HADM_ID INT NOT NULL, ADMITTIME TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, DISCHTIME TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, DEATHTIME TIMESTAMP(0) WITHOUT TIME ZONE, ADMISSION_TYPE VARCHAR(50) NOT NULL, ADMISSION_LOCATION VARCHAR(50) NOT NULL, DISCHARGE_LOCATION VARCHAR(50) NOT NULL, INSURANCE VARCHAR(255) NOT NULL, LANGUAGE VARCHAR(10), RELIGION VARCHAR(50), MARITAL_STATUS VARCHAR(50), ETHNICITY VARCHAR(200) NOT NULL, EDREGTIME TIMESTAMP(0) WITHOUT TIME ZONE, EDOUTTIME TIMESTAMP(0) WITHOUT TIME ZONE, DIAGNOSIS VARCHAR(255), HOSPITAL_EXPIRE_FLAG SMALLINT, HAS_CHARTEVENTS_DATA SMALLINT NOT NULL);

COMMENT ON TABLE mimiciii.ADMISSIONS IS 'Hospital admissions associated with an ICU stay.';

COMMENT ON COLUMN mimiciii.ADMISSIONS.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.ADMISSIONS.SUBJECT_ID IS 'Foreign key. Identifies the patient.';

COMMENT ON COLUMN mimiciii.ADMISSIONS.HADM_ID IS 'Primary key. Identifies the hospital stay.';

COMMENT ON COLUMN mimiciii.ADMISSIONS.ADMITTIME IS 'Time of admission to the hospital.';

COMMENT ON COLUMN mimiciii.ADMISSIONS.DISCHTIME IS 'Time of discharge from the hospital.';

COMMENT ON COLUMN mimiciii.ADMISSIONS.DEATHTIME IS 'Time of death.';

COMMENT ON COLUMN mimiciii.ADMISSIONS.ADMISSION_TYPE IS 'Type of admission, for example emergency or elective.';

COMMENT ON COLUMN mimiciii.ADMISSIONS.ADMISSION_LOCATION IS 'Admission location.';

COMMENT ON COLUMN mimiciii.ADMISSIONS.DISCHARGE_LOCATION IS 'Discharge location';

COMMENT ON COLUMN mimiciii.ADMISSIONS.INSURANCE IS 'Insurance type.';

COMMENT ON COLUMN mimiciii.ADMISSIONS.LANGUAGE IS 'Language.';

COMMENT ON COLUMN mimiciii.ADMISSIONS.RELIGION IS 'Religon.';

COMMENT ON COLUMN mimiciii.ADMISSIONS.MARITAL_STATUS IS 'Marital status.';

COMMENT ON COLUMN mimiciii.ADMISSIONS.ETHNICITY IS 'Ethnicity.';

COMMENT ON COLUMN mimiciii.ADMISSIONS.EDREGTIME IS 'Time that the patient was registered from the emergency department.';

COMMENT ON COLUMN mimiciii.ADMISSIONS.EDOUTTIME IS 'Time that the patient was discharge from the emergency department.';

COMMENT ON COLUMN mimiciii.ADMISSIONS.DIAGNOSIS IS 'Diagnosis.';

COMMENT ON COLUMN mimiciii.ADMISSIONS.HOSPITAL_EXPIRE_FLAG IS 'Flag indicating that the patient has died.';

COMMENT ON COLUMN mimiciii.ADMISSIONS.HAS_CHARTEVENTS_DATA IS 'Hospital admission has at least one observation in the CHARTEVENTS table.';

-- Changeset mimic.yml::2::lcp
CREATE TABLE mimiciii.CALLOUT (ROW_ID INT NOT NULL, SUBJECT_ID INT NOT NULL, HADM_ID INT NOT NULL, SUBMIT_WARDID INT, SUBMIT_CAREUNIT VARCHAR(15), CURR_WARDID INT, CURR_CAREUNIT VARCHAR(15), CALLOUT_WARDID INT, CALLOUT_SERVICE VARCHAR(10) NOT NULL, REQUEST_TELE SMALLINT NOT NULL, REQUEST_RESP SMALLINT NOT NULL, REQUEST_CDIFF SMALLINT NOT NULL, REQUEST_MRSA SMALLINT NOT NULL, REQUEST_VRE SMALLINT NOT NULL, CALLOUT_STATUS VARCHAR(20) NOT NULL, CALLOUT_OUTCOME VARCHAR(20) NOT NULL, DISCHARGE_WARDID INT, ACKNOWLEDGE_STATUS VARCHAR(20) NOT NULL, CREATETIME TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, UPDATETIME TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, ACKNOWLEDGETIME TIMESTAMP(0) WITHOUT TIME ZONE, OUTCOMETIME TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, FIRSTRESERVATIONTIME TIMESTAMP(0) WITHOUT TIME ZONE, CURRENTRESERVATIONTIME TIMESTAMP(0) WITHOUT TIME ZONE);

COMMENT ON TABLE mimiciii.CALLOUT IS 'Record of when patients were ready for discharge (called out), and the actual time of their discharge (or more generally, their outcome).';

COMMENT ON COLUMN mimiciii.CALLOUT.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.CALLOUT.SUBJECT_ID IS 'Foreign key. Identifies the patient.';

COMMENT ON COLUMN mimiciii.CALLOUT.HADM_ID IS 'Foreign key. Identifies the hospital stay.';

COMMENT ON COLUMN mimiciii.CALLOUT.SUBMIT_WARDID IS 'Identifies the ward where the call out request was submitted.';

COMMENT ON COLUMN mimiciii.CALLOUT.SUBMIT_CAREUNIT IS 'If the ward where the call was submitted was an ICU, the ICU type is listed here.';

COMMENT ON COLUMN mimiciii.CALLOUT.CURR_WARDID IS 'Identifies the ward where the patient is currently residing.';

COMMENT ON COLUMN mimiciii.CALLOUT.CURR_CAREUNIT IS 'If the ward where the patient is currently residing is an ICU, the ICU type is listed here.';

COMMENT ON COLUMN mimiciii.CALLOUT.CALLOUT_WARDID IS 'Identifies the ward where the patient is to be discharged to. A value of 1 indicates the first available ward. A value of 0 indicates home.';

COMMENT ON COLUMN mimiciii.CALLOUT.CALLOUT_SERVICE IS 'Identifies the service that the patient is called out to.';

COMMENT ON COLUMN mimiciii.CALLOUT.REQUEST_TELE IS 'Indicates if special precautions are required.';

COMMENT ON COLUMN mimiciii.CALLOUT.REQUEST_RESP IS 'Indicates if special precautions are required.';

COMMENT ON COLUMN mimiciii.CALLOUT.REQUEST_CDIFF IS 'Indicates if special precautions are required.';

COMMENT ON COLUMN mimiciii.CALLOUT.REQUEST_MRSA IS 'Indicates if special precautions are required.';

COMMENT ON COLUMN mimiciii.CALLOUT.REQUEST_VRE IS 'Indicates if special precautions are required.';

COMMENT ON COLUMN mimiciii.CALLOUT.CALLOUT_STATUS IS 'Current status of the call out request.';

COMMENT ON COLUMN mimiciii.CALLOUT.CALLOUT_OUTCOME IS 'The result of the call out request; either a cancellation or a discharge.';

COMMENT ON COLUMN mimiciii.CALLOUT.DISCHARGE_WARDID IS 'The ward to which the patient was discharged.';

COMMENT ON COLUMN mimiciii.CALLOUT.ACKNOWLEDGE_STATUS IS 'The status of the response to the call out request.';

COMMENT ON COLUMN mimiciii.CALLOUT.CREATETIME IS 'Time at which the call out request was created.';

COMMENT ON COLUMN mimiciii.CALLOUT.UPDATETIME IS 'Last time at which the call out request was updated.';

COMMENT ON COLUMN mimiciii.CALLOUT.ACKNOWLEDGETIME IS 'Time at which the call out request was acknowledged.';

COMMENT ON COLUMN mimiciii.CALLOUT.OUTCOMETIME IS 'Time at which the outcome (cancelled or discharged) occurred.';

COMMENT ON COLUMN mimiciii.CALLOUT.FIRSTRESERVATIONTIME IS 'First time at which a ward was reserved for the call out request.';

COMMENT ON COLUMN mimiciii.CALLOUT.CURRENTRESERVATIONTIME IS 'Latest time at which a ward was reserved for the call out request.';

-- Changeset mimic.yml::3::lcp
CREATE TABLE mimiciii.CAREGIVERS (ROW_ID INT NOT NULL, CGID INT NOT NULL, LABEL VARCHAR(15), DESCRIPTION VARCHAR(30));

COMMENT ON TABLE mimiciii.CAREGIVERS IS 'List of caregivers associated with an ICU stay.';

COMMENT ON COLUMN mimiciii.CAREGIVERS.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.CAREGIVERS.CGID IS 'Unique caregiver identifier.';

COMMENT ON COLUMN mimiciii.CAREGIVERS.LABEL IS 'Title of the caregiver, for example MD or RN.';

COMMENT ON COLUMN mimiciii.CAREGIVERS.DESCRIPTION IS 'More detailed description of the caregiver, if available.';

-- Changeset mimic.yml::4::lcp
CREATE TABLE mimiciii.CHARTEVENTS (ROW_ID INT NOT NULL, SUBJECT_ID INT NOT NULL, HADM_ID INT, ICUSTAY_ID INT, ITEMID INT, CHARTTIME TIMESTAMP(0) WITHOUT TIME ZONE, STORETIME TIMESTAMP(0) WITHOUT TIME ZONE, CGID INT, VALUE VARCHAR(255), VALUENUM DOUBLE PRECISION, VALUEUOM VARCHAR(50), WARNING INT, ERROR INT, RESULTSTATUS VARCHAR(50), STOPPED VARCHAR(50));

COMMENT ON TABLE mimiciii.CHARTEVENTS IS 'Events occuring on a patient chart.';

COMMENT ON COLUMN mimiciii.CHARTEVENTS.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.CHARTEVENTS.SUBJECT_ID IS 'Foreign key. Identifies the patient.';

COMMENT ON COLUMN mimiciii.CHARTEVENTS.HADM_ID IS 'Foreign key. Identifies the hospital stay.';

COMMENT ON COLUMN mimiciii.CHARTEVENTS.ICUSTAY_ID IS 'Foreign key. Identifies the ICU stay.';

COMMENT ON COLUMN mimiciii.CHARTEVENTS.ITEMID IS 'Foreign key. Identifies the charted item.';

COMMENT ON COLUMN mimiciii.CHARTEVENTS.CHARTTIME IS 'Time when the event occured.';

COMMENT ON COLUMN mimiciii.CHARTEVENTS.STORETIME IS 'Time when the event was recorded in the system.';

COMMENT ON COLUMN mimiciii.CHARTEVENTS.CGID IS 'Foreign key. Identifies the caregiver.';

COMMENT ON COLUMN mimiciii.CHARTEVENTS.VALUE IS 'Value of the event as a text string.';

COMMENT ON COLUMN mimiciii.CHARTEVENTS.VALUENUM IS 'Value of the event as a number.';

COMMENT ON COLUMN mimiciii.CHARTEVENTS.VALUEUOM IS 'Unit of measurement.';

COMMENT ON COLUMN mimiciii.CHARTEVENTS.WARNING IS 'Flag to highlight that the value has triggered a warning.';

COMMENT ON COLUMN mimiciii.CHARTEVENTS.ERROR IS 'Flag to highlight an error with the event.';

COMMENT ON COLUMN mimiciii.CHARTEVENTS.RESULTSTATUS IS 'Result status of lab data.';

COMMENT ON COLUMN mimiciii.CHARTEVENTS.STOPPED IS 'Text string indicating the stopped status of an event (i.e. stopped, not stopped).';

-- Changeset mimic.yml::5::lcp
CREATE TABLE mimiciii.CPTEVENTS (ROW_ID INT NOT NULL, SUBJECT_ID INT NOT NULL, HADM_ID INT NOT NULL, COSTCENTER VARCHAR(10) NOT NULL, CHARTDATE TIMESTAMP(0) WITHOUT TIME ZONE, CPT_CD VARCHAR(10) NOT NULL, CPT_NUMBER INT, CPT_SUFFIX VARCHAR(5), TICKET_ID_SEQ INT, SECTIONHEADER VARCHAR(50), SUBSECTIONHEADER VARCHAR(255), DESCRIPTION VARCHAR(200));

COMMENT ON TABLE mimiciii.CPTEVENTS IS 'Events recorded in Current Procedural Terminology.';

COMMENT ON COLUMN mimiciii.CPTEVENTS.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.CPTEVENTS.SUBJECT_ID IS 'Foreign key. Identifies the patient.';

COMMENT ON COLUMN mimiciii.CPTEVENTS.HADM_ID IS 'Foreign key. Identifies the hospital stay.';

COMMENT ON COLUMN mimiciii.CPTEVENTS.COSTCENTER IS 'Center recording the code, for example the ICU or the respiratory unit.';

COMMENT ON COLUMN mimiciii.CPTEVENTS.CHARTDATE IS 'Date when the event occured, if available.';

COMMENT ON COLUMN mimiciii.CPTEVENTS.CPT_CD IS 'Current Procedural Terminology code.';

COMMENT ON COLUMN mimiciii.CPTEVENTS.CPT_NUMBER IS 'Numerical element of the Current Procedural Terminology code.';

COMMENT ON COLUMN mimiciii.CPTEVENTS.CPT_SUFFIX IS 'Text element of the Current Procedural Terminology, if any. Indicates code category.';

COMMENT ON COLUMN mimiciii.CPTEVENTS.TICKET_ID_SEQ IS 'Sequence number of the event, derived from the ticket ID.';

COMMENT ON COLUMN mimiciii.CPTEVENTS.SECTIONHEADER IS 'High-level section of the Current Procedural Terminology code.';

COMMENT ON COLUMN mimiciii.CPTEVENTS.SUBSECTIONHEADER IS 'Subsection of the Current Procedural Terminology code.';

COMMENT ON COLUMN mimiciii.CPTEVENTS.DESCRIPTION IS 'Description of the Current Procedural Terminology, if available.';

-- Changeset mimic.yml::6::lcp
CREATE TABLE mimiciii.DATETIMEEVENTS (ROW_ID INT NOT NULL, SUBJECT_ID INT NOT NULL, HADM_ID INT, ICUSTAY_ID INT, ITEMID INT NOT NULL, CHARTTIME TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, STORETIME TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, CGID INT NOT NULL, VALUE TIMESTAMP(0) WITHOUT TIME ZONE, VALUEUOM VARCHAR(50) NOT NULL, WARNING SMALLINT, ERROR SMALLINT, RESULTSTATUS VARCHAR(50), STOPPED VARCHAR(50));

COMMENT ON TABLE mimiciii.DATETIMEEVENTS IS 'Events relating to a datetime.';

COMMENT ON COLUMN mimiciii.DATETIMEEVENTS.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.DATETIMEEVENTS.SUBJECT_ID IS 'Foreign key. Identifies the patient.';

COMMENT ON COLUMN mimiciii.DATETIMEEVENTS.HADM_ID IS 'Foreign key. Identifies the hospital stay.';

COMMENT ON COLUMN mimiciii.DATETIMEEVENTS.ICUSTAY_ID IS 'Foreign key. Identifies the ICU stay.';

COMMENT ON COLUMN mimiciii.DATETIMEEVENTS.ITEMID IS 'Foreign key. Identifies the charted item.';

COMMENT ON COLUMN mimiciii.DATETIMEEVENTS.CHARTTIME IS 'Time when the event occured.';

COMMENT ON COLUMN mimiciii.DATETIMEEVENTS.STORETIME IS 'Time when the event was recorded in the system.';

COMMENT ON COLUMN mimiciii.DATETIMEEVENTS.CGID IS 'Foreign key. Identifies the caregiver.';

COMMENT ON COLUMN mimiciii.DATETIMEEVENTS.VALUE IS 'Value of the event as a text string.';

COMMENT ON COLUMN mimiciii.DATETIMEEVENTS.VALUEUOM IS 'Unit of measurement.';

COMMENT ON COLUMN mimiciii.DATETIMEEVENTS.WARNING IS 'Flag to highlight that the value has triggered a warning.';

COMMENT ON COLUMN mimiciii.DATETIMEEVENTS.ERROR IS 'Flag to highlight an error with the event.';

COMMENT ON COLUMN mimiciii.DATETIMEEVENTS.RESULTSTATUS IS 'Result status of lab data.';

COMMENT ON COLUMN mimiciii.DATETIMEEVENTS.STOPPED IS 'Event was explicitly marked as stopped. Infrequently used by caregivers.';

-- Changeset mimic.yml::7::lcp
CREATE TABLE mimiciii.DIAGNOSES_ICD (ROW_ID INT NOT NULL, SUBJECT_ID INT NOT NULL, HADM_ID INT NOT NULL, SEQ_NUM INT, ICD9_CODE VARCHAR(20));

COMMENT ON TABLE mimiciii.DIAGNOSES_ICD IS 'Diagnoses relating to a hospital admission coded using the ICD9 system.';

COMMENT ON COLUMN mimiciii.DIAGNOSES_ICD.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.DIAGNOSES_ICD.SUBJECT_ID IS 'Foreign key. Identifies the patient.';

COMMENT ON COLUMN mimiciii.DIAGNOSES_ICD.HADM_ID IS 'Foreign key. Identifies the hospital stay.';

COMMENT ON COLUMN mimiciii.DIAGNOSES_ICD.SEQ_NUM IS 'Priority of the code. Sequence 1 is the primary code.';

COMMENT ON COLUMN mimiciii.DIAGNOSES_ICD.ICD9_CODE IS 'ICD9 code for the diagnosis.';

-- Changeset mimic.yml::8::lcp
CREATE TABLE mimiciii.DRGCODES (ROW_ID INT NOT NULL, SUBJECT_ID INT NOT NULL, HADM_ID INT NOT NULL, DRG_TYPE VARCHAR(20) NOT NULL, DRG_CODE VARCHAR(20) NOT NULL, DESCRIPTION VARCHAR(255), DRG_SEVERITY SMALLINT, DRG_MORTALITY SMALLINT);

COMMENT ON TABLE mimiciii.DRGCODES IS 'Hospital stays classified using the Diagnosis-Related Group system.';

COMMENT ON COLUMN mimiciii.DRGCODES.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.DRGCODES.SUBJECT_ID IS 'Foreign key. Identifies the patient.';

COMMENT ON COLUMN mimiciii.DRGCODES.HADM_ID IS 'Foreign key. Identifies the hospital stay.';

COMMENT ON COLUMN mimiciii.DRGCODES.DRG_TYPE IS 'Type of Diagnosis-Related Group, for example APR is All Patient Refined';

COMMENT ON COLUMN mimiciii.DRGCODES.DRG_CODE IS 'Diagnosis-Related Group code';

COMMENT ON COLUMN mimiciii.DRGCODES.DESCRIPTION IS 'Description of the Diagnosis-Related Group';

COMMENT ON COLUMN mimiciii.DRGCODES.DRG_SEVERITY IS 'Relative severity, available for type APR only.';

COMMENT ON COLUMN mimiciii.DRGCODES.DRG_MORTALITY IS 'Relative mortality, available for type APR only.';

-- Changeset mimic.yml::9::lcp
CREATE TABLE mimiciii.D_CPT (ROW_ID INT NOT NULL, CATEGORY SMALLINT NOT NULL, SECTIONRANGE VARCHAR(100) NOT NULL, SECTIONHEADER VARCHAR(50) NOT NULL, SUBSECTIONRANGE VARCHAR(100) NOT NULL, SUBSECTIONHEADER VARCHAR(255) NOT NULL, CODESUFFIX VARCHAR(5), MINCODEINSUBSECTION INT NOT NULL, MAXCODEINSUBSECTION INT NOT NULL);

COMMENT ON TABLE mimiciii.D_CPT IS 'High-level dictionary of the Current Procedural Terminology.';

COMMENT ON COLUMN mimiciii.D_CPT.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.D_CPT.CATEGORY IS 'Code category.';

COMMENT ON COLUMN mimiciii.D_CPT.SECTIONRANGE IS 'Range of codes within the high-level section.';

COMMENT ON COLUMN mimiciii.D_CPT.SECTIONHEADER IS 'Section header.';

COMMENT ON COLUMN mimiciii.D_CPT.SUBSECTIONRANGE IS 'Range of codes within the subsection.';

COMMENT ON COLUMN mimiciii.D_CPT.SUBSECTIONHEADER IS 'Subsection header.';

COMMENT ON COLUMN mimiciii.D_CPT.CODESUFFIX IS 'Text element of the Current Procedural Terminology, if any.';

COMMENT ON COLUMN mimiciii.D_CPT.MINCODEINSUBSECTION IS 'Minimum code within the subsection.';

COMMENT ON COLUMN mimiciii.D_CPT.MAXCODEINSUBSECTION IS 'Maximum code within the subsection.';

-- Changeset mimic.yml::10::lcp
CREATE TABLE mimiciii.D_ICD_DIAGNOSES (ROW_ID INT NOT NULL, ICD9_CODE VARCHAR(10) NOT NULL, SHORT_TITLE VARCHAR(50) NOT NULL, LONG_TITLE VARCHAR(255) NOT NULL);

COMMENT ON TABLE mimiciii.D_ICD_DIAGNOSES IS 'Dictionary of the International Classification of Diseases, 9th Revision (Diagnoses).';

COMMENT ON COLUMN mimiciii.D_ICD_DIAGNOSES.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.D_ICD_DIAGNOSES.ICD9_CODE IS 'ICD9 code - note that this is a fixed length character field, as whitespaces are important in uniquely identifying ICD-9 codes.';

COMMENT ON COLUMN mimiciii.D_ICD_DIAGNOSES.SHORT_TITLE IS 'Short title associated with the code.';

COMMENT ON COLUMN mimiciii.D_ICD_DIAGNOSES.LONG_TITLE IS 'Long title associated with the code.';

-- Changeset mimic.yml::11::lcp
CREATE TABLE mimiciii.D_ICD_PROCEDURES (ROW_ID INT NOT NULL, ICD9_CODE VARCHAR(10) NOT NULL, SHORT_TITLE VARCHAR(50) NOT NULL, LONG_TITLE VARCHAR(255) NOT NULL);

COMMENT ON TABLE mimiciii.D_ICD_PROCEDURES IS 'Dictionary of the International Classification of Diseases, 9th Revision (Procedures).';

COMMENT ON COLUMN mimiciii.D_ICD_PROCEDURES.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.D_ICD_PROCEDURES.ICD9_CODE IS 'ICD9 code - note that this is a fixed length character field, as whitespaces are important in uniquely identifying ICD-9 codes.';

COMMENT ON COLUMN mimiciii.D_ICD_PROCEDURES.SHORT_TITLE IS 'Short title associated with the code.';

COMMENT ON COLUMN mimiciii.D_ICD_PROCEDURES.LONG_TITLE IS 'Long title associated with the code.';

-- Changeset mimic.yml::12::lcp
CREATE TABLE mimiciii.D_ITEMS (ROW_ID INT NOT NULL, ITEMID INT NOT NULL, LABEL VARCHAR(200), ABBREVIATION VARCHAR(100), DBSOURCE VARCHAR(20), LINKSTO VARCHAR(50), CATEGORY VARCHAR(100), UNITNAME VARCHAR(100), PARAM_TYPE VARCHAR(30), CONCEPTID INT);

COMMENT ON TABLE mimiciii.D_ITEMS IS 'Dictionary of non-laboratory-related charted items.';

COMMENT ON COLUMN mimiciii.D_ITEMS.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.D_ITEMS.ITEMID IS 'Primary key. Identifies the charted item.';

COMMENT ON COLUMN mimiciii.D_ITEMS.LABEL IS 'Label identifying the item.';

COMMENT ON COLUMN mimiciii.D_ITEMS.ABBREVIATION IS 'Abbreviation associated with the item.';

COMMENT ON COLUMN mimiciii.D_ITEMS.DBSOURCE IS 'Source database of the item.';

COMMENT ON COLUMN mimiciii.D_ITEMS.LINKSTO IS 'Table which contains data for the given ITEMID.';

COMMENT ON COLUMN mimiciii.D_ITEMS.CATEGORY IS 'Category of data which the concept falls under.';

COMMENT ON COLUMN mimiciii.D_ITEMS.UNITNAME IS 'Unit associated with the item.';

COMMENT ON COLUMN mimiciii.D_ITEMS.PARAM_TYPE IS 'Type of item, for example solution or ingredient.';

COMMENT ON COLUMN mimiciii.D_ITEMS.CONCEPTID IS 'Identifier used to harmonize concepts identified by multiple ITEMIDs. CONCEPTIDs are planned but not yet implemented (all values are NULL).';

-- Changeset mimic.yml::13::lcp
CREATE TABLE mimiciii.D_LABITEMS (ROW_ID INT NOT NULL, ITEMID INT NOT NULL, LABEL VARCHAR(100) NOT NULL, FLUID VARCHAR(100) NOT NULL, CATEGORY VARCHAR(100) NOT NULL, LOINC_CODE VARCHAR(100));

COMMENT ON TABLE mimiciii.D_LABITEMS IS 'Dictionary of laboratory-related items.';

COMMENT ON COLUMN mimiciii.D_LABITEMS.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.D_LABITEMS.ITEMID IS 'Foreign key. Identifies the charted item.';

COMMENT ON COLUMN mimiciii.D_LABITEMS.LABEL IS 'Label identifying the item.';

COMMENT ON COLUMN mimiciii.D_LABITEMS.FLUID IS 'Fluid associated with the item, for example blood or urine.';

COMMENT ON COLUMN mimiciii.D_LABITEMS.CATEGORY IS 'Category of item, for example chemistry or hematology.';

COMMENT ON COLUMN mimiciii.D_LABITEMS.LOINC_CODE IS 'Logical Observation Identifiers Names and Codes (LOINC) mapped to the item, if available.';

-- Changeset mimic.yml::14::lcp
CREATE TABLE mimiciii.ICUSTAYS (ROW_ID INT NOT NULL, SUBJECT_ID INT NOT NULL, HADM_ID INT NOT NULL, ICUSTAY_ID INT NOT NULL, DBSOURCE VARCHAR(20) NOT NULL, FIRST_CAREUNIT VARCHAR(20) NOT NULL, LAST_CAREUNIT VARCHAR(20) NOT NULL, FIRST_WARDID SMALLINT NOT NULL, LAST_WARDID SMALLINT NOT NULL, INTIME TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, OUTTIME TIMESTAMP(0) WITHOUT TIME ZONE, LOS DOUBLE PRECISION);

COMMENT ON TABLE mimiciii.ICUSTAYS IS 'List of ICU admissions.';

COMMENT ON COLUMN mimiciii.ICUSTAYS.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.ICUSTAYS.SUBJECT_ID IS 'Foreign key. Identifies the patient.';

COMMENT ON COLUMN mimiciii.ICUSTAYS.HADM_ID IS 'Foreign key. Identifies the hospital stay.';

COMMENT ON COLUMN mimiciii.ICUSTAYS.ICUSTAY_ID IS 'Primary key. Identifies the ICU stay.';

COMMENT ON COLUMN mimiciii.ICUSTAYS.DBSOURCE IS 'Source database of the item.';

COMMENT ON COLUMN mimiciii.ICUSTAYS.FIRST_CAREUNIT IS 'First careunit associated with the ICU stay.';

COMMENT ON COLUMN mimiciii.ICUSTAYS.LAST_CAREUNIT IS 'Last careunit associated with the ICU stay.';

COMMENT ON COLUMN mimiciii.ICUSTAYS.FIRST_WARDID IS 'Identifier for the first ward the patient was located in.';

COMMENT ON COLUMN mimiciii.ICUSTAYS.LAST_WARDID IS 'Identifier for the last ward the patient is located in.';

COMMENT ON COLUMN mimiciii.ICUSTAYS.INTIME IS 'Time of admission to the ICU.';

COMMENT ON COLUMN mimiciii.ICUSTAYS.OUTTIME IS 'Time of discharge from the ICU.';

COMMENT ON COLUMN mimiciii.ICUSTAYS.LOS IS 'Length of stay in the ICU in minutes.';

-- Changeset mimic.yml::15::lcp
CREATE TABLE mimiciii.INPUTEVENTS_CV (ROW_ID INT NOT NULL, SUBJECT_ID INT NOT NULL, HADM_ID INT, ICUSTAY_ID INT, CHARTTIME TIMESTAMP(0) WITHOUT TIME ZONE, ITEMID INT, AMOUNT DOUBLE PRECISION, AMOUNTUOM VARCHAR(30), RATE DOUBLE PRECISION, RATEUOM VARCHAR(30), STORETIME TIMESTAMP(0) WITHOUT TIME ZONE, CGID INT, ORDERID INT, LINKORDERID INT, STOPPED VARCHAR(30), NEWBOTTLE INT, ORIGINALAMOUNT DOUBLE PRECISION, ORIGINALAMOUNTUOM VARCHAR(30), ORIGINALROUTE VARCHAR(30), ORIGINALRATE DOUBLE PRECISION, ORIGINALRATEUOM VARCHAR(30), ORIGINALSITE VARCHAR(30));

COMMENT ON TABLE mimiciii.INPUTEVENTS_CV IS 'Events relating to fluid input for patients whose data was originally stored in the CareVue database.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.SUBJECT_ID IS 'Foreign key. Identifies the patient.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.HADM_ID IS 'Foreign key. Identifies the hospital stay.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.ICUSTAY_ID IS 'Foreign key. Identifies the ICU stay.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.CHARTTIME IS 'Time of that the input was started or received.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.ITEMID IS 'Foreign key. Identifies the charted item.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.AMOUNT IS 'Amount of the item administered to the patient.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.AMOUNTUOM IS 'Unit of measurement for the amount.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.RATE IS 'Rate at which the item is being administered to the patient.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.RATEUOM IS 'Unit of measurement for the rate.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.STORETIME IS 'Time when the event was recorded in the system.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.CGID IS 'Foreign key. Identifies the caregiver.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.ORDERID IS 'Identifier linking items which are grouped in a solution.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.LINKORDERID IS 'Identifier linking orders across multiple administrations. LINKORDERID is always equal to the first occuring ORDERID of the series.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.STOPPED IS 'Event was explicitly marked as stopped. Infrequently used by caregivers.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.NEWBOTTLE IS 'Indicates when a new bottle of the solution was hung at the bedside.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.ORIGINALAMOUNT IS 'Amount of the item which was originally charted.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.ORIGINALAMOUNTUOM IS 'Unit of measurement for the original amount.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.ORIGINALROUTE IS 'Route of administration originally chosen for the item.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.ORIGINALRATE IS 'Rate of administration originally chosen for the item.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.ORIGINALRATEUOM IS 'Unit of measurement for the rate originally chosen.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_CV.ORIGINALSITE IS 'Anatomical site for the original administration of the item.';

-- Changeset mimic.yml::16::lcp
CREATE TABLE mimiciii.INPUTEVENTS_MV (ROW_ID INT NOT NULL, SUBJECT_ID INT NOT NULL, HADM_ID INT, ICUSTAY_ID INT, STARTTIME TIMESTAMP(0) WITHOUT TIME ZONE, ENDTIME TIMESTAMP(0) WITHOUT TIME ZONE, ITEMID INT, AMOUNT DOUBLE PRECISION, AMOUNTUOM VARCHAR(30), RATE DOUBLE PRECISION, RATEUOM VARCHAR(30), STORETIME TIMESTAMP(0) WITHOUT TIME ZONE, CGID INT, ORDERID INT, LINKORDERID INT, ORDERCATEGORYNAME VARCHAR(100), SECONDARYORDERCATEGORYNAME VARCHAR(100), ORDERCOMPONENTTYPEDESCRIPTION VARCHAR(200), ORDERCATEGORYDESCRIPTION VARCHAR(50), PATIENTWEIGHT DOUBLE PRECISION, TOTALAMOUNT DOUBLE PRECISION, TOTALAMOUNTUOM VARCHAR(50), ISOPENBAG SMALLINT, CONTINUEINNEXTDEPT SMALLINT, CANCELREASON SMALLINT, STATUSDESCRIPTION VARCHAR(30), COMMENTS_EDITEDBY VARCHAR(30), COMMENTS_CANCELEDBY VARCHAR(40), COMMENTS_DATE TIMESTAMP(0) WITHOUT TIME ZONE, ORIGINALAMOUNT DOUBLE PRECISION, ORIGINALRATE DOUBLE PRECISION);

COMMENT ON TABLE mimiciii.INPUTEVENTS_MV IS 'Events relating to fluid input for patients whose data was originally stored in the MetaVision database.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.SUBJECT_ID IS 'Foreign key. Identifies the patient.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.HADM_ID IS 'Foreign key. Identifies the hospital stay.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.ICUSTAY_ID IS 'Foreign key. Identifies the ICU stay.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.STARTTIME IS 'Time when the event started.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.ENDTIME IS 'Time when the event ended.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.ITEMID IS 'Foreign key. Identifies the charted item.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.AMOUNT IS 'Amount of the item administered to the patient.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.AMOUNTUOM IS 'Unit of measurement for the amount.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.RATE IS 'Rate at which the item is being administered to the patient.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.RATEUOM IS 'Unit of measurement for the rate.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.STORETIME IS 'Time when the event was recorded in the system.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.CGID IS 'Foreign key. Identifies the caregiver.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.ORDERID IS 'Identifier linking items which are grouped in a solution.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.LINKORDERID IS 'Identifier linking orders across multiple administrations. LINKORDERID is always equal to the first occuring ORDERID of the series.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.ORDERCATEGORYNAME IS 'A group which the item corresponds to.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.SECONDARYORDERCATEGORYNAME IS 'A secondary group for those items with more than one grouping possible.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.ORDERCOMPONENTTYPEDESCRIPTION IS 'The role of the item administered in the order.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.ORDERCATEGORYDESCRIPTION IS 'The type of item administered.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.PATIENTWEIGHT IS 'For drugs dosed by weight, the value of the weight used in the calculation.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.TOTALAMOUNT IS 'The total amount in the solution for the given item.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.TOTALAMOUNTUOM IS 'Unit of measurement for the total amount in the solution.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.ISOPENBAG IS 'Indicates whether the bag containing the solution is open.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.CONTINUEINNEXTDEPT IS 'Indicates whether the item will be continued in the next department where the patient is transferred to.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.CANCELREASON IS 'Reason for cancellation, if cancelled.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.STATUSDESCRIPTION IS 'The current status of the order: stopped, rewritten, running or cancelled.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.COMMENTS_EDITEDBY IS 'The title of the caregiver who edited the order.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.COMMENTS_CANCELEDBY IS 'The title of the caregiver who canceled the order.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.COMMENTS_DATE IS 'Time at which the caregiver edited or cancelled the order.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.ORIGINALAMOUNT IS 'Amount of the item which was originally charted.';

COMMENT ON COLUMN mimiciii.INPUTEVENTS_MV.ORIGINALRATE IS 'Rate of administration originally chosen for the item.';

-- Changeset mimic.yml::17::lcp
CREATE TABLE mimiciii.LABEVENTS (ROW_ID INT NOT NULL, SUBJECT_ID INT NOT NULL, HADM_ID INT, ITEMID INT NOT NULL, CHARTTIME TIMESTAMP(0) WITHOUT TIME ZONE, VALUE VARCHAR(200), VALUENUM DOUBLE PRECISION, VALUEUOM VARCHAR(20), FLAG VARCHAR(20));

COMMENT ON TABLE mimiciii.LABEVENTS IS 'Events relating to laboratory tests.';

COMMENT ON COLUMN mimiciii.LABEVENTS.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.LABEVENTS.SUBJECT_ID IS 'Foreign key. Identifies the patient.';

COMMENT ON COLUMN mimiciii.LABEVENTS.HADM_ID IS 'Foreign key. Identifies the hospital stay.';

COMMENT ON COLUMN mimiciii.LABEVENTS.ITEMID IS 'Foreign key. Identifies the charted item.';

COMMENT ON COLUMN mimiciii.LABEVENTS.CHARTTIME IS 'Time when the event occured.';

COMMENT ON COLUMN mimiciii.LABEVENTS.VALUE IS 'Value of the event as a text string.';

COMMENT ON COLUMN mimiciii.LABEVENTS.VALUENUM IS 'Value of the event as a number.';

COMMENT ON COLUMN mimiciii.LABEVENTS.VALUEUOM IS 'Unit of measurement.';

COMMENT ON COLUMN mimiciii.LABEVENTS.FLAG IS 'Flag indicating whether the lab test value is considered abnormal (null if the test was normal).';

-- Changeset mimic.yml::18::lcp
CREATE TABLE mimiciii.MICROBIOLOGYEVENTS (ROW_ID INT NOT NULL, SUBJECT_ID INT NOT NULL, HADM_ID INT, CHARTDATE TIMESTAMP(0) WITHOUT TIME ZONE, CHARTTIME TIMESTAMP(0) WITHOUT TIME ZONE, SPEC_ITEMID INT, SPEC_TYPE_DESC VARCHAR(100), ORG_ITEMID INT, ORG_NAME VARCHAR(100), ISOLATE_NUM SMALLINT, AB_ITEMID INT, AB_NAME VARCHAR(30), DILUTION_TEXT VARCHAR(10), DILUTION_COMPARISON VARCHAR(20), DILUTION_VALUE DOUBLE PRECISION, INTERPRETATION VARCHAR(5));

COMMENT ON TABLE mimiciii.MICROBIOLOGYEVENTS IS 'Events relating to microbiology tests.';

COMMENT ON COLUMN mimiciii.MICROBIOLOGYEVENTS.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.MICROBIOLOGYEVENTS.SUBJECT_ID IS 'Foreign key. Identifies the patient.';

COMMENT ON COLUMN mimiciii.MICROBIOLOGYEVENTS.HADM_ID IS 'Foreign key. Identifies the hospital stay.';

COMMENT ON COLUMN mimiciii.MICROBIOLOGYEVENTS.CHARTDATE IS 'Date when the event occured.';

COMMENT ON COLUMN mimiciii.MICROBIOLOGYEVENTS.CHARTTIME IS 'Time when the event occured, if available.';

COMMENT ON COLUMN mimiciii.MICROBIOLOGYEVENTS.SPEC_ITEMID IS 'Foreign key. Identifies the specimen.';

COMMENT ON COLUMN mimiciii.MICROBIOLOGYEVENTS.SPEC_TYPE_DESC IS 'Description of the specimen.';

COMMENT ON COLUMN mimiciii.MICROBIOLOGYEVENTS.ORG_ITEMID IS 'Foreign key. Identifies the organism.';

COMMENT ON COLUMN mimiciii.MICROBIOLOGYEVENTS.ORG_NAME IS 'Name of the organism.';

COMMENT ON COLUMN mimiciii.MICROBIOLOGYEVENTS.ISOLATE_NUM IS 'Isolate number associated with the test.';

COMMENT ON COLUMN mimiciii.MICROBIOLOGYEVENTS.AB_ITEMID IS 'Foreign key. Identifies the antibody.';

COMMENT ON COLUMN mimiciii.MICROBIOLOGYEVENTS.AB_NAME IS 'Name of the antibody used.';

COMMENT ON COLUMN mimiciii.MICROBIOLOGYEVENTS.DILUTION_TEXT IS 'The dilution amount tested for and the comparison which was made against it (e.g. <=4).';

COMMENT ON COLUMN mimiciii.MICROBIOLOGYEVENTS.DILUTION_COMPARISON IS 'The comparison component of DILUTION_TEXT: either <= (less than or equal), = (equal), or >= (greater than or equal), or null when not available.';

COMMENT ON COLUMN mimiciii.MICROBIOLOGYEVENTS.DILUTION_VALUE IS 'The value component of DILUTION_TEXT: must be a floating point number.';

COMMENT ON COLUMN mimiciii.MICROBIOLOGYEVENTS.INTERPRETATION IS 'Interpretation of the test.';

-- Changeset mimic.yml::19::lcp
CREATE TABLE mimiciii.NOTEEVENTS (ROW_ID INT NOT NULL, SUBJECT_ID INT NOT NULL, HADM_ID INT, CHARTDATE TIMESTAMP(0) WITHOUT TIME ZONE, CHARTTIME TIMESTAMP(0) WITHOUT TIME ZONE, STORETIME TIMESTAMP(0) WITHOUT TIME ZONE, CATEGORY VARCHAR(50), DESCRIPTION VARCHAR(255), CGID INT, ISERROR CHAR(1), TEXT TEXT);

COMMENT ON TABLE mimiciii.NOTEEVENTS IS 'Notes associated with hospital stays.';

COMMENT ON COLUMN mimiciii.NOTEEVENTS.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.NOTEEVENTS.SUBJECT_ID IS 'Foreign key. Identifies the patient.';

COMMENT ON COLUMN mimiciii.NOTEEVENTS.HADM_ID IS 'Foreign key. Identifies the hospital stay.';

COMMENT ON COLUMN mimiciii.NOTEEVENTS.CHARTDATE IS 'Date when the note was charted.';

COMMENT ON COLUMN mimiciii.NOTEEVENTS.CHARTTIME IS 'Date and time when the note was charted. Note that some notes (e.g. discharge summaries) do not have a time associated with them: these notes have NULL in this column.';

COMMENT ON COLUMN mimiciii.NOTEEVENTS.STORETIME IS 'Time when the event was recorded in the system.';

COMMENT ON COLUMN mimiciii.NOTEEVENTS.CATEGORY IS 'Category of the note, e.g. Discharge summary.';

COMMENT ON COLUMN mimiciii.NOTEEVENTS.DESCRIPTION IS 'A more detailed categorization for the note, sometimes entered by free-text.';

COMMENT ON COLUMN mimiciii.NOTEEVENTS.CGID IS 'Foreign key. Identifies the caregiver.';

COMMENT ON COLUMN mimiciii.NOTEEVENTS.ISERROR IS 'Flag to highlight an error with the note.';

COMMENT ON COLUMN mimiciii.NOTEEVENTS.TEXT IS 'Content of the note.';

-- Changeset mimic.yml::20::lcp
CREATE TABLE mimiciii.OUTPUTEVENTS (ROW_ID INT NOT NULL, SUBJECT_ID INT NOT NULL, HADM_ID INT, ICUSTAY_ID INT, CHARTTIME TIMESTAMP(0) WITHOUT TIME ZONE, ITEMID INT, VALUE DOUBLE PRECISION, VALUEUOM VARCHAR(30), STORETIME TIMESTAMP(0) WITHOUT TIME ZONE, CGID INT, STOPPED VARCHAR(30), NEWBOTTLE CHAR(1), ISERROR INT);

COMMENT ON TABLE mimiciii.OUTPUTEVENTS IS 'Events relating to substance output for patients.';

COMMENT ON COLUMN mimiciii.OUTPUTEVENTS.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.OUTPUTEVENTS.SUBJECT_ID IS 'Primary key. Identifies the patient.';

COMMENT ON COLUMN mimiciii.OUTPUTEVENTS.HADM_ID IS 'Foreign key. Identifies the hospital stay.';

COMMENT ON COLUMN mimiciii.OUTPUTEVENTS.ICUSTAY_ID IS 'Foreign key. Identifies the ICU stay.';

COMMENT ON COLUMN mimiciii.OUTPUTEVENTS.CHARTTIME IS 'Time when the event occured.';

COMMENT ON COLUMN mimiciii.OUTPUTEVENTS.ITEMID IS 'Foreign key. Identifies the charted item.';

COMMENT ON COLUMN mimiciii.OUTPUTEVENTS.VALUE IS 'Value of the event as a number.';

COMMENT ON COLUMN mimiciii.OUTPUTEVENTS.VALUEUOM IS 'Unit of measurement.';

COMMENT ON COLUMN mimiciii.OUTPUTEVENTS.STORETIME IS 'Time when the event was recorded in the system.';

COMMENT ON COLUMN mimiciii.OUTPUTEVENTS.CGID IS 'Unique caregiver identifier.';

COMMENT ON COLUMN mimiciii.OUTPUTEVENTS.STOPPED IS 'Event was explicitly marked as stopped. Infrequently used by caregivers.';

COMMENT ON COLUMN mimiciii.OUTPUTEVENTS.NEWBOTTLE IS 'Indicates when a new bottle of the solution was hung at the bedside.';

COMMENT ON COLUMN mimiciii.OUTPUTEVENTS.ISERROR IS 'Indicates when a caregiver observed an error with this event.';

-- Changeset mimic.yml::21::lcp
CREATE TABLE mimiciii.PATIENTS (ROW_ID INT NOT NULL, SUBJECT_ID INT NOT NULL, GENDER VARCHAR(5) NOT NULL, DOB TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, DOD TIMESTAMP(0) WITHOUT TIME ZONE, DOD_HOSP TIMESTAMP(0) WITHOUT TIME ZONE, DOD_SSN TIMESTAMP(0) WITHOUT TIME ZONE, EXPIRE_FLAG INT NOT NULL);

COMMENT ON TABLE mimiciii.PATIENTS IS 'Patients associated with an admission to the ICU.';

COMMENT ON COLUMN mimiciii.PATIENTS.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.PATIENTS.SUBJECT_ID IS 'Primary key. Identifies the patient.';

COMMENT ON COLUMN mimiciii.PATIENTS.GENDER IS 'Gender.';

COMMENT ON COLUMN mimiciii.PATIENTS.DOB IS 'Date of birth.';

COMMENT ON COLUMN mimiciii.PATIENTS.DOD IS 'Date of death. Null if the patient was alive at least 90 days post hospital discharge.';

COMMENT ON COLUMN mimiciii.PATIENTS.DOD_HOSP IS 'Date of death recorded in the hospital records.';

COMMENT ON COLUMN mimiciii.PATIENTS.DOD_SSN IS 'Date of death recorded in the social security records.';

COMMENT ON COLUMN mimiciii.PATIENTS.EXPIRE_FLAG IS 'Flag indicating that the patient has died.';

-- Changeset mimic.yml::22::lcp
CREATE TABLE mimiciii.PRESCRIPTIONS (ROW_ID INT NOT NULL, SUBJECT_ID INT NOT NULL, HADM_ID INT NOT NULL, ICUSTAY_ID INT, STARTDATE TIMESTAMP(0) WITHOUT TIME ZONE, ENDDATE TIMESTAMP(0) WITHOUT TIME ZONE, DRUG_TYPE VARCHAR(100) NOT NULL, DRUG VARCHAR(100) NOT NULL, DRUG_NAME_POE VARCHAR(100), DRUG_NAME_GENERIC VARCHAR(100), FORMULARY_DRUG_CD VARCHAR(120), GSN VARCHAR(200), NDC VARCHAR(120), PROD_STRENGTH VARCHAR(120), DOSE_VAL_RX VARCHAR(120), DOSE_UNIT_RX VARCHAR(120), FORM_VAL_DISP VARCHAR(120), FORM_UNIT_DISP VARCHAR(120), ROUTE VARCHAR(120));

COMMENT ON TABLE mimiciii.PRESCRIPTIONS IS 'Medicines prescribed.';

COMMENT ON COLUMN mimiciii.PRESCRIPTIONS.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.PRESCRIPTIONS.SUBJECT_ID IS 'Foreign key. Identifies the patient.';

COMMENT ON COLUMN mimiciii.PRESCRIPTIONS.HADM_ID IS 'Foreign key. Identifies the hospital stay.';

COMMENT ON COLUMN mimiciii.PRESCRIPTIONS.ICUSTAY_ID IS 'Foreign key. Identifies the ICU stay.';

COMMENT ON COLUMN mimiciii.PRESCRIPTIONS.STARTDATE IS 'Date when the prescription started.';

COMMENT ON COLUMN mimiciii.PRESCRIPTIONS.ENDDATE IS 'Date when the prescription ended.';

COMMENT ON COLUMN mimiciii.PRESCRIPTIONS.DRUG_TYPE IS 'Type of drug.';

COMMENT ON COLUMN mimiciii.PRESCRIPTIONS.DRUG IS 'Name of the drug.';

COMMENT ON COLUMN mimiciii.PRESCRIPTIONS.DRUG_NAME_POE IS 'Name of the drug on the Provider Order Entry interface.';

COMMENT ON COLUMN mimiciii.PRESCRIPTIONS.DRUG_NAME_GENERIC IS 'Generic drug name.';

COMMENT ON COLUMN mimiciii.PRESCRIPTIONS.FORMULARY_DRUG_CD IS 'Formulary drug code.';

COMMENT ON COLUMN mimiciii.PRESCRIPTIONS.GSN IS 'Generic Sequence Number.';

COMMENT ON COLUMN mimiciii.PRESCRIPTIONS.NDC IS 'National Drug Code.';

COMMENT ON COLUMN mimiciii.PRESCRIPTIONS.PROD_STRENGTH IS 'Strength of the drug (product).';

COMMENT ON COLUMN mimiciii.PRESCRIPTIONS.DOSE_VAL_RX IS 'Dose of the drug prescribed.';

COMMENT ON COLUMN mimiciii.PRESCRIPTIONS.DOSE_UNIT_RX IS 'Unit of measurement associated with the dose.';

COMMENT ON COLUMN mimiciii.PRESCRIPTIONS.FORM_VAL_DISP IS 'Amount of the formulation dispensed.';

COMMENT ON COLUMN mimiciii.PRESCRIPTIONS.FORM_UNIT_DISP IS 'Unit of measurement associated with the formulation.';

COMMENT ON COLUMN mimiciii.PRESCRIPTIONS.ROUTE IS 'Route of administration, for example intravenous or oral.';

-- Changeset mimic.yml::23::lcp
CREATE TABLE mimiciii.PROCEDUREEVENTS_MV (ROW_ID INT NOT NULL, SUBJECT_ID INT NOT NULL, HADM_ID INT NOT NULL, ICUSTAY_ID INT, STARTTIME TIMESTAMP(0) WITHOUT TIME ZONE, ENDTIME TIMESTAMP(0) WITHOUT TIME ZONE, ITEMID INT, VALUE DOUBLE PRECISION, VALUEUOM VARCHAR(30), LOCATION VARCHAR(30), LOCATIONCATEGORY VARCHAR(30), STORETIME TIMESTAMP(0) WITHOUT TIME ZONE, CGID INT, ORDERID INT, LINKORDERID INT, ORDERCATEGORYNAME VARCHAR(100), SECONDARYORDERCATEGORYNAME VARCHAR(100), ORDERCATEGORYDESCRIPTION VARCHAR(50), ISOPENBAG SMALLINT, CONTINUEINNEXTDEPT SMALLINT, CANCELREASON SMALLINT, STATUSDESCRIPTION VARCHAR(30), COMMENTS_EDITEDBY VARCHAR(30), COMMENTS_CANCELEDBY VARCHAR(30), COMMENTS_DATE TIMESTAMP(0) WITHOUT TIME ZONE);

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.SUBJECT_ID IS 'Foreign key. Identifies the patient.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.HADM_ID IS 'Foreign key. Identifies the hospital stay.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.ICUSTAY_ID IS 'Foreign key. Identifies the ICU stay.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.STARTTIME IS 'Date when the procedure started.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.ENDTIME IS 'Date when the procedure ended.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.ITEMID IS 'Foreign key. Identifies the charted item.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.VALUE IS 'Value of the event as a number.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.VALUEUOM IS 'Unit of measurement.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.STORETIME IS 'Time when the event was recorded in the system.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.CGID IS 'Unique caregiver identifier.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.ORDERID IS 'Identifier linking items which are grouped in a solution.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.LINKORDERID IS 'Identifier linking orders across multiple administrations. LINKORDERID is always equal to the first occuring ORDERID of the series.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.ORDERCATEGORYNAME IS 'A group which the item corresponds to.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.SECONDARYORDERCATEGORYNAME IS 'A secondary group for those items with more than one grouping possible.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.ORDERCATEGORYDESCRIPTION IS 'The type of item administered.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.ISOPENBAG IS 'Indicates whether the bag containing the solution is open.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.CONTINUEINNEXTDEPT IS 'Indicates whether the item will be continued in the next department where the patient is transferred to.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.CANCELREASON IS 'Reason for cancellation, if cancelled.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.STATUSDESCRIPTION IS 'The current status of the order: stopped, rewritten, running or cancelled.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.COMMENTS_EDITEDBY IS 'The title of the caregiver who edited the order.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.COMMENTS_CANCELEDBY IS 'The title of the caregiver who canceled the order.';

COMMENT ON COLUMN mimiciii.PROCEDUREEVENTS_MV.COMMENTS_DATE IS 'Time at which the caregiver edited or cancelled the order.';

-- Changeset mimic.yml::24::lcp
CREATE TABLE mimiciii.PROCEDURES_ICD (ROW_ID INT NOT NULL, SUBJECT_ID INT NOT NULL, HADM_ID INT NOT NULL, SEQ_NUM INT NOT NULL, ICD9_CODE VARCHAR(20) NOT NULL);

COMMENT ON TABLE mimiciii.PROCEDURES_ICD IS 'Procedures relating to a hospital admission coded using the ICD9 system.';

COMMENT ON COLUMN mimiciii.PROCEDURES_ICD.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.PROCEDURES_ICD.SUBJECT_ID IS 'Foreign key. Identifies the patient.';

COMMENT ON COLUMN mimiciii.PROCEDURES_ICD.HADM_ID IS 'Foreign key. Identifies the hospital stay.';

COMMENT ON COLUMN mimiciii.PROCEDURES_ICD.SEQ_NUM IS 'Lower procedure numbers occurred earlier.';

COMMENT ON COLUMN mimiciii.PROCEDURES_ICD.ICD9_CODE IS 'ICD9 code associated with the procedure.';

-- Changeset mimic.yml::25::lcp
CREATE TABLE mimiciii.SERVICES (ROW_ID INT NOT NULL, SUBJECT_ID INT NOT NULL, HADM_ID INT NOT NULL, TRANSFERTIME TIMESTAMP(0) WITHOUT TIME ZONE NOT NULL, PREV_SERVICE VARCHAR(20), CURR_SERVICE VARCHAR(20));

COMMENT ON TABLE mimiciii.SERVICES IS 'Hospital services that patients were under during their hospital stay.';

COMMENT ON COLUMN mimiciii.SERVICES.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.SERVICES.SUBJECT_ID IS 'Foreign key. Identifies the patient.';

COMMENT ON COLUMN mimiciii.SERVICES.HADM_ID IS 'Foreign key. Identifies the hospital stay.';

COMMENT ON COLUMN mimiciii.SERVICES.TRANSFERTIME IS 'Time when the transfer occured.';

COMMENT ON COLUMN mimiciii.SERVICES.PREV_SERVICE IS 'Previous service type.';

COMMENT ON COLUMN mimiciii.SERVICES.CURR_SERVICE IS 'Current service type.';

-- Changeset mimic.yml::26::lcp
CREATE TABLE mimiciii.TRANSFERS (ROW_ID INT NOT NULL, SUBJECT_ID INT NOT NULL, HADM_ID INT NOT NULL, ICUSTAY_ID INT, DBSOURCE VARCHAR(20), EVENTTYPE VARCHAR(20), PREV_CAREUNIT VARCHAR(20), CURR_CAREUNIT VARCHAR(20), PREV_WARDID SMALLINT, CURR_WARDID SMALLINT, INTIME TIMESTAMP(0) WITHOUT TIME ZONE, OUTTIME TIMESTAMP(0) WITHOUT TIME ZONE, LOS DOUBLE PRECISION);

COMMENT ON TABLE mimiciii.TRANSFERS IS 'Location of patients during their hospital stay.';

COMMENT ON COLUMN mimiciii.TRANSFERS.ROW_ID IS 'Unique row identifier.';

COMMENT ON COLUMN mimiciii.TRANSFERS.SUBJECT_ID IS 'Foreign key. Identifies the patient.';

COMMENT ON COLUMN mimiciii.TRANSFERS.HADM_ID IS 'Foreign key. Identifies the hospital stay.';

COMMENT ON COLUMN mimiciii.TRANSFERS.ICUSTAY_ID IS 'Foreign key. Identifies the ICU stay.';

COMMENT ON COLUMN mimiciii.TRANSFERS.DBSOURCE IS 'Source database of the item.';

COMMENT ON COLUMN mimiciii.TRANSFERS.EVENTTYPE IS 'Type of event, for example admission or transfer.';

COMMENT ON COLUMN mimiciii.TRANSFERS.PREV_CAREUNIT IS 'Previous careunit.';

COMMENT ON COLUMN mimiciii.TRANSFERS.CURR_CAREUNIT IS 'Current careunit.';

COMMENT ON COLUMN mimiciii.TRANSFERS.PREV_WARDID IS 'Identifier for the previous ward the patient was located in.';

COMMENT ON COLUMN mimiciii.TRANSFERS.CURR_WARDID IS 'Identifier for the current ward the patient is located in.';

COMMENT ON COLUMN mimiciii.TRANSFERS.INTIME IS 'Time when the patient was transferred into the unit.';

COMMENT ON COLUMN mimiciii.TRANSFERS.OUTTIME IS 'Time when the patient was transferred out of the unit.';

COMMENT ON COLUMN mimiciii.TRANSFERS.LOS IS 'Length of stay in the unit in minutes.';

-- Changeset mimic.yml::add-admissions-constraints::lcp
ALTER TABLE mimiciii.admissions ADD CONSTRAINT adm_rowid_pk PRIMARY KEY (ROW_ID);

ALTER TABLE mimiciii.admissions ADD CONSTRAINT adm_hadm_unique UNIQUE (HADM_ID);

-- Changeset mimic.yml::add-callout-constraints::lcp
ALTER TABLE mimiciii.callout ADD CONSTRAINT callout_rowid_pk PRIMARY KEY (ROW_ID);

-- Changeset mimic.yml::add-caregivers-constraints::lcp
ALTER TABLE mimiciii.caregivers ADD CONSTRAINT cg_rowid_pk PRIMARY KEY (ROW_ID);

ALTER TABLE mimiciii.caregivers ADD CONSTRAINT cg_cgid_unique UNIQUE (CGID);

-- Changeset mimic.yml::add-chartevents-constraints::lcp
ALTER TABLE mimiciii.chartevents ADD CONSTRAINT chartevents_rowid_pk PRIMARY KEY (ROW_ID);

-- Changeset mimic.yml::add-cptevents-constraints::lcp
ALTER TABLE mimiciii.cptevents ADD CONSTRAINT cpt_rowid_pk PRIMARY KEY (ROW_ID);

-- Changeset mimic.yml::add-datetimeevents-constraints::lcp
ALTER TABLE mimiciii.datetimeevents ADD CONSTRAINT datetime_rowid_pk PRIMARY KEY (ROW_ID);

-- Changeset mimic.yml::add-diagnoses_icd-constraints::lcp
ALTER TABLE mimiciii.diagnoses_icd ADD CONSTRAINT diagnosesicd_rowid_pk PRIMARY KEY (ROW_ID);

-- Changeset mimic.yml::add-drgcodes-constraints::lcp
ALTER TABLE mimiciii.drgcodes ADD CONSTRAINT drg_rowid_pk PRIMARY KEY (ROW_ID);

-- Changeset mimic.yml::add-d_cpt-constraints::lcp
ALTER TABLE mimiciii.d_cpt ADD CONSTRAINT dcpt_rowid_pk PRIMARY KEY (ROW_ID);

ALTER TABLE mimiciii.d_cpt ADD CONSTRAINT dcpt_ssrange_unique UNIQUE (SUBSECTIONRANGE);

-- Changeset mimic.yml::add-d_icd_diagnoses-constraints::lcp
ALTER TABLE mimiciii.d_icd_diagnoses ADD CONSTRAINT d_icd_diag_rowid_pk PRIMARY KEY (ROW_ID);

ALTER TABLE mimiciii.d_icd_diagnoses ADD CONSTRAINT d_icd_diag_code_unique UNIQUE (ICD9_CODE);

-- Changeset mimic.yml::add-d_icd_procedures-constraints::lcp
ALTER TABLE mimiciii.d_icd_procedures ADD CONSTRAINT d_icd_proc_rowid_pk PRIMARY KEY (ROW_ID);

ALTER TABLE mimiciii.d_icd_procedures ADD CONSTRAINT d_icd_proc_code_unique UNIQUE (ICD9_CODE);

-- Changeset mimic.yml::add-d_items-constraints::lcp
ALTER TABLE mimiciii.d_items ADD CONSTRAINT ditems_rowid_pk PRIMARY KEY (ROW_ID);

ALTER TABLE mimiciii.d_items ADD CONSTRAINT ditems_itemid_unique UNIQUE (ITEMID);

-- Changeset mimic.yml::add-d_labitems-constraints::lcp
ALTER TABLE mimiciii.d_labitems ADD CONSTRAINT dlabitems_rowid_pk PRIMARY KEY (ROW_ID);

ALTER TABLE mimiciii.d_labitems ADD CONSTRAINT dlabitems_itemid_unique UNIQUE (ITEMID);

-- Changeset mimic.yml::add-icustays-constraints::lcp
ALTER TABLE mimiciii.icustays ADD CONSTRAINT icustay_rowid_pk PRIMARY KEY (ROW_ID);

ALTER TABLE mimiciii.icustays ADD CONSTRAINT icustay_icustayid_unique UNIQUE (ICUSTAY_ID);

-- Changeset mimic.yml::add-inputevents_cv-constraints::lcp
ALTER TABLE mimiciii.inputevents_cv ADD CONSTRAINT inputevents_cv_rowid_pk PRIMARY KEY (ROW_ID);

-- Changeset mimic.yml::add-inputevents_mv-constraints::lcp
ALTER TABLE mimiciii.inputevents_mv ADD CONSTRAINT inputevents_mv_rowid_pk PRIMARY KEY (ROW_ID);

-- Changeset mimic.yml::add-labevents-constraints::lcp
ALTER TABLE mimiciii.labevents ADD CONSTRAINT labevents_rowid_pk PRIMARY KEY (ROW_ID);

-- Changeset mimic.yml::add-microbiologyevents-constraints::lcp
ALTER TABLE mimiciii.microbiologyevents ADD CONSTRAINT micro_rowid_pk PRIMARY KEY (ROW_ID);

-- Changeset mimic.yml::add-noteevents-constraints::lcp
ALTER TABLE mimiciii.noteevents ADD CONSTRAINT noteevents_rowid_pk PRIMARY KEY (ROW_ID);

-- Changeset mimic.yml::add-outputevents-constraints::lcp
ALTER TABLE mimiciii.outputevents ADD CONSTRAINT outputevents_cv_rowid_pk PRIMARY KEY (ROW_ID);

-- Changeset mimic.yml::add-patients-constraints::lcp
ALTER TABLE mimiciii.patients ADD CONSTRAINT pat_rowid_pk PRIMARY KEY (ROW_ID);

ALTER TABLE mimiciii.patients ADD CONSTRAINT pat_subid_unique UNIQUE (SUBJECT_ID);

-- Changeset mimic.yml::add-prescriptions-constraints::lcp
ALTER TABLE mimiciii.prescriptions ADD CONSTRAINT prescription_rowid_pk PRIMARY KEY (ROW_ID);

-- Changeset mimic.yml::add-procedureevents-constraints::lcp
ALTER TABLE mimiciii.procedureevents ADD CONSTRAINT procedureevents_mv_rowid_pk PRIMARY KEY (ROW_ID);

-- Changeset mimic.yml::add-procedures_icd-constraints::lcp
ALTER TABLE mimiciii.procedures_icd ADD CONSTRAINT proceduresicd_rowid_pk PRIMARY KEY (ROW_ID);

-- Changeset mimic.yml::add-services-constraints::lcp
ALTER TABLE mimiciii.services ADD CONSTRAINT services_rowid_pk PRIMARY KEY (ROW_ID);

-- Changeset mimic.yml::add-transfers-constraints::lcp
ALTER TABLE mimiciii.transfers ADD CONSTRAINT transfers_rowid_pk PRIMARY KEY (ROW_ID);

-- Changeset mimic.yml::createIndex-ADMISSIONS::lcp
CREATE INDEX ADMISSIONS_IDX01 ON mimiciii.ADMISSIONS(subject_id);

CREATE INDEX ADMISSIONS_IDX02 ON mimiciii.ADMISSIONS(hadm_id);

-- Changeset mimic.yml::createIndex-CALLOUT::lcp
CREATE INDEX CALLOUT_IDX01 ON mimiciii.CALLOUT(subject_id);

CREATE INDEX CALLOUT_IDX02 ON mimiciii.CALLOUT(hadm_id);

-- Changeset mimic.yml::createIndex-CPTEVENTS::lcp
CREATE INDEX "CPTEVENTS_idx01" ON mimiciii.CPTEVENTS(subject_id);

CREATE INDEX "CPTEVENTS_idx02" ON mimiciii.CPTEVENTS(CPT_CD);

-- Changeset mimic.yml::createIndex-D_ICD_DIAG::lcp
CREATE INDEX "D_ICD_DIAG_idx01" ON mimiciii.D_ICD_DIAGNOSES(ICD9_CODE);

CREATE INDEX "D_ICD_DIAG_idx02" ON mimiciii.D_ICD_DIAGNOSES(LONG_TITLE);

-- Changeset mimic.yml::createIndex-D_ICD_PROC::lcp
CREATE INDEX "D_ICD_PROC_idx01" ON mimiciii.D_ICD_PROCEDURES(ICD9_CODE);

CREATE INDEX "D_ICD_PROC_idx02" ON mimiciii.D_ICD_PROCEDURES(LONG_TITLE);

-- Changeset mimic.yml::createIndex-D_ITEMS::lcp
CREATE INDEX "D_ITEMS_idx01" ON mimiciii.D_ITEMS(itemid);

CREATE INDEX "D_ITEMS_idx02" ON mimiciii.D_ITEMS(LABEL);

-- Changeset mimic.yml::createIndex-D_LABITEMS::lcp
CREATE INDEX "D_LABITEMS_idx01" ON mimiciii.D_LABITEMS(itemid);

CREATE INDEX "D_LABITEMS_idx02" ON mimiciii.D_LABITEMS(LABEL);

CREATE INDEX "D_LABITEMS_idx03" ON mimiciii.D_LABITEMS(LOINC_CODE);

-- Changeset mimic.yml::createIndex-DATETIMEEVENTS::lcp
CREATE INDEX "DATETIMEEVENTS_idx01" ON mimiciii.DATETIMEEVENTS(subject_id);

CREATE INDEX "DATETIMEEVENTS_idx02" ON mimiciii.DATETIMEEVENTS(itemid);

CREATE INDEX "DATETIMEEVENTS_idx03" ON mimiciii.DATETIMEEVENTS(icustay_id);

CREATE INDEX "DATETIMEEVENTS_idx04" ON mimiciii.DATETIMEEVENTS(hadm_id);

-- Changeset mimic.yml::createIndex-DIAGNOSES_ICD::lcp
CREATE INDEX "DIAGNOSES_ICD_idx01" ON mimiciii.DIAGNOSES_ICD(subject_id);

CREATE INDEX "DIAGNOSES_ICD_idx02" ON mimiciii.DIAGNOSES_ICD(ICD9_CODE);

CREATE INDEX "DIAGNOSES_ICD_idx03" ON mimiciii.DIAGNOSES_ICD(hadm_id);

-- Changeset mimic.yml::createIndex-DRGCODES::lcp
CREATE INDEX "DRGCODES_idx01" ON mimiciii.DRGCODES(subject_id);

CREATE INDEX "DRGCODES_idx02" ON mimiciii.DRGCODES(DRG_CODE);

CREATE INDEX "DRGCODES_idx03" ON mimiciii.DRGCODES(DESCRIPTION);

-- Changeset mimic.yml::createIndex-ICUSTAYS::lcp
CREATE INDEX "ICUSTAYS_idx01" ON mimiciii.ICUSTAYS(subject_id);

CREATE INDEX "ICUSTAYS_idx02" ON mimiciii.ICUSTAYS(icustay_id);

CREATE INDEX "ICUSTAYS_idx03" ON mimiciii.ICUSTAYS(hadm_id);

-- Changeset mimic.yml::createIndex-INPUTEVENTS_CV::lcp
CREATE INDEX "INPUTEVENTS_CV_idx01" ON mimiciii.INPUTEVENTS_CV(subject_id);

CREATE INDEX "INPUTEVENTS_CV_idx02" ON mimiciii.INPUTEVENTS_CV(hadm_id);

CREATE INDEX "INPUTEVENTS_CV_idx03" ON mimiciii.INPUTEVENTS_CV(icustay_id);

CREATE INDEX "INPUTEVENTS_CV_idx04" ON mimiciii.INPUTEVENTS_CV(itemid);

-- Changeset mimic.yml::createIndex-INPUTEVENTS_MV::lcp
CREATE INDEX "INPUTEVENTS_MV_idx01" ON mimiciii.INPUTEVENTS_MV(subject_id);

CREATE INDEX "INPUTEVENTS_MV_idx02" ON mimiciii.INPUTEVENTS_MV(hadm_id);

CREATE INDEX "INPUTEVENTS_MV_idx03" ON mimiciii.INPUTEVENTS_MV(icustay_id);

CREATE INDEX "INPUTEVENTS_MV_idx04" ON mimiciii.INPUTEVENTS_MV(itemid);

-- Changeset mimic.yml::createIndex-LABEVENTS::lcp
CREATE INDEX "LABEVENTS_idx01" ON mimiciii.LABEVENTS(subject_id);

CREATE INDEX "LABEVENTS_idx02" ON mimiciii.LABEVENTS(hadm_id);

CREATE INDEX "LABEVENTS_idx03" ON mimiciii.LABEVENTS(itemid);

-- Changeset mimic.yml::createIndex-MICROBIOLOGYEVENTS::lcp
CREATE INDEX "MICROBIOLOGYEVENTS_idx01" ON mimiciii.MICROBIOLOGYEVENTS(subject_id);

CREATE INDEX "MICROBIOLOGYEVENTS_idx02" ON mimiciii.MICROBIOLOGYEVENTS(hadm_id);

-- Changeset mimic.yml::createIndex-NOTEEVENTS::lcp
CREATE INDEX "NOTEEVENTS_idx01" ON mimiciii.NOTEEVENTS(subject_id);

CREATE INDEX "NOTEEVENTS_idx02" ON mimiciii.NOTEEVENTS(hadm_id);

CREATE INDEX "NOTEEVENTS_idx03" ON mimiciii.NOTEEVENTS(CATEGORY);

-- Changeset mimic.yml::createIndex-OUTPUTEVENTS::lcp
CREATE INDEX "OUTPUTEVENTS_idx01" ON mimiciii.OUTPUTEVENTS(subject_id);

CREATE INDEX "OUTPUTEVENTS_idx02" ON mimiciii.OUTPUTEVENTS(hadm_id);

CREATE INDEX "OUTPUTEVENTS_idx03" ON mimiciii.OUTPUTEVENTS(icustay_id);

CREATE INDEX "OUTPUTEVENTS_idx04" ON mimiciii.OUTPUTEVENTS(itemid);

-- Changeset mimic.yml::createIndex-PRESCRIPTIONS::lcp
CREATE INDEX "PRESCRIPTIONS_idx01" ON mimiciii.PRESCRIPTIONS(subject_id);

CREATE INDEX "PRESCRIPTIONS_idx02" ON mimiciii.PRESCRIPTIONS(hadm_id);

CREATE INDEX "PRESCRIPTIONS_idx03" ON mimiciii.PRESCRIPTIONS(icustay_id);

CREATE INDEX "PRESCRIPTIONS_idx04" ON mimiciii.PRESCRIPTIONS(DRUG_TYPE);

CREATE INDEX "PRESCRIPTIONS_idx05" ON mimiciii.PRESCRIPTIONS(DRUG);

-- Changeset mimic.yml::createIndex-PROCEDUREEVENTS_MV::lcp
CREATE INDEX "PROCEDUREEVENTS_MV_idx01" ON mimiciii.PROCEDUREEVENTS_MV(subject_id);

CREATE INDEX "PROCEDUREEVENTS_MV_idx02" ON mimiciii.PROCEDUREEVENTS_MV(hadm_id);

CREATE INDEX "PROCEDUREEVENTS_MV_idx03" ON mimiciii.PROCEDUREEVENTS_MV(icustay_id);

CREATE INDEX "PROCEDUREEVENTS_MV_idx04" ON mimiciii.PROCEDUREEVENTS_MV(itemid);

-- Changeset mimic.yml::createIndex-PROCEDURES_ICD::lcp
CREATE INDEX "PROCEDURES_ICD_idx01" ON mimiciii.PROCEDURES_ICD(subject_id);

CREATE INDEX "PROCEDURES_ICD_idx02" ON mimiciii.PROCEDURES_ICD(ICD9_CODE);

CREATE INDEX "PROCEDURES_ICD_idx03" ON mimiciii.PROCEDURES_ICD(hadm_id);

-- Changeset mimic.yml::createIndex-SERVICES::lcp
CREATE INDEX "SERVICES_idx01" ON mimiciii.SERVICES(subject_id);

CREATE INDEX "SERVICES_idx02" ON mimiciii.SERVICES(hadm_id);

-- Changeset mimic.yml::createIndex-TRANSFERS::lcp
CREATE INDEX "TRANSFERS_idx01" ON mimiciii.TRANSFERS(subject_id);

CREATE INDEX "TRANSFERS_idx02" ON mimiciii.TRANSFERS(hadm_id);

CREATE INDEX "TRANSFERS_idx03" ON mimiciii.TRANSFERS(icustay_id);

