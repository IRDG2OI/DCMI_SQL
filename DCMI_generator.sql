DO $$
DECLARE
    data_name TEXT;

BEGIN
-- Creation d'une table de métadonnée

    CREATE TABLE IF NOT EXISTS metadata_dcmi_cp(
    "id_metadata" SERIAL PRIMARY KEY,
    "Identifier" TEXT,
    "Title" TEXT,
    "Description" TEXT,
    "Subject" TEXT,
    "Creator" Text,
    "Date" TEXT,
    "Type" TEXT,
    "Language" TEXT,
    "SpatialCoverage" TEXT,
    "TemporalCoverage" TEXT,
    "Format" TEXT,
    "Relation" TEXT,
    "Rights" TEXT,
    "Provenance" TEXT,
    "Data" TEXT
    );

    -- ADD constraint on Identifier 
    ALTER TABLE metadata_dcmi_cp DROP CONSTRAINT IF EXISTS metadata_dcmi_cp_constraint;
    ALTER TABLE metadata_dcmi_cp ADD CONSTRAINT metadata_dcmi_cp_constraint UNIQUE ("Identifier");

    -- Insert table names 
    INSERT INTO metadata_dcmi_cp ("Identifier")
     SELECT table_name  AS full_rel_name
        FROM information_schema.tables
        WHERE table_schema not in ('pg_catalog', 'information_schema')
     UNION
        SELECT matviewname FROM pg_matviews
    ON CONFLICT ("Identifier") 
    DO NOTHING;

    -- Update info using table names as key
    UPDATE metadata_dcmi_cp
    SET
    "Creator" = 'owner:secretariat@iotc.org_
publisher:secretariat@iotc.org_
originator:fabio.fiorellato@iotc.org_
pointOfContact:julien.barde@ird.fr_
principalInvestigator:secretariat@coi-ioc.org_
principalInvestigator:secretariat@iotc.org',
    "Type" = 'Dataset',
    "Language" = 'eng',
    "Relation" = 'thumbnail:Aperçu@https://drive.google.com/uc?id=1YgbiwX4zQ7mp7RKuZChEXhMO2sqlc72O_
thumbnail:spatial_extent@https://drive.google.com/uc?id=11x0bkB2iio9knd3k4UT-tgv_wIYq1-Oe_
http:Feature_Type@https://docs.google.com/spreadsheets/d/1rLhq_FHFNOdCjgU-EoyfOiGofe3uc1_xGfx8ybitaJg/edit?usp=sharing_
http:Feature_Attribute@https://docs.google.com/spreadsheets/d/1CfLVB4grDyl3USSz6YPuAmdPQyEGmYRm56LvvgcXIxs/edit?usp=sharing',
    "Rights" = 'accessConstraint:Access to the data is restricted, contact the creator for an access request',
    "Data" = REPLACE('access:googledrive_
source:table_name.sql_
sourceType:dbquery_
uploadSource:table_name_
uploadType:dbquery_
sql:SELECT * FROM public.table_name_
featureType:rttp_dbquery_
upload:true_
layername: table_name
geometry:geom,Point_
style:point_
spatialRepresentationType:vector_
attribute:schoolnumber[schoolnumber],cruisenumber[cruisenumber]_
variable:timestamp[timestamp]',
'table_name',
    metadata_dcmi_cp."Identifier");

END $$;
