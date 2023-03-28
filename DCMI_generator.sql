/* Create and auto-complete a metadata table according to Dublin Core specifications 
on Postgres - Postgis database*/

DO $$

DECLARE
    
    -- Get tables with geography as type 
    geog_tables TEXT[]:= (SELECT array["f_table_name"] FROM geography_columns);
    t TEXT;

BEGIN

    -- DROP TABLE metadata_dcmi;

    -- ADD a new Table 
    CREATE TABLE IF NOT EXISTS metadata_dcmi(
    "Identifier" TEXT PRIMARY KEY,
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
    ALTER TABLE metadata_dcmi DROP CONSTRAINT IF EXISTS metadata_dcmi_constraint;
    ALTER TABLE metadata_dcmi ADD CONSTRAINT metadata_dcmi_constraint UNIQUE ("Identifier");


    -- Insert table names & materialized views & views
    INSERT INTO metadata_dcmi ("Identifier")
    SELECT "f_table_name" FROM geometry_columns WHERE f_table_name NOT IN ('world', 'metadata_dcmi')
    ON CONFLICT ("Identifier") 
    DO NOTHING;

    -- Update values
    UPDATE metadata_dcmi
    SET
    "Title" =  metadata_dcmi."Identifier",
    "Description" =  metadata_dcmi."Identifier",
    "Subject" ='theme[General]:RTTP project,Pêche,DCF,Thon,Thon albacore,Thon obèse,FAD,Tagging,Baithaul,Tuna,Seine, Purse seine, canneur, banc libre, banc objet, DCP (FAD),objet flottant,stock assessment, fisheries_
theme[Taxon]:Albacore, Thunnus albacares,Listao,Katsuwonus pelamis, Patudo,Thunnus obesus, Thon obèse,skipjack_
theme[Observation]:marquage, tagging, OTC_
theme[Area]:SWIO, Indian Ocean, océan Indien, Seychelles, Indian Ocean Tuna Tagging Programme, IOTTP, RTTP, canneur_',
    "Creator" = 'owner:secretariat@iotc.org_
publisher:secretariat@iotc.org_
originator:fabio.fiorellato@iotc.org_
pointOfContact:julien.barde@ird.fr_
principalInvestigator:secretariat@coi-ioc.org_
principalInvestigator:secretariat@iotc.org',
    "Type" = 'Dataset',
    "Language" = 'eng',
    "TemporalCoverage" = '2007/2013',
    "Relation" = 'thumbnail:Aperçu@https://drive.google.com/uc?id=1YgbiwX4zQ7mp7RKuZChEXhMO2sqlc72O_
thumbnail:spatial_extent@https://drive.google.com/uc?id=11x0bkB2iio9knd3k4UT-tgv_wIYq1-Oe_
http:Feature_Type@https://docs.google.com/spreadsheets/d/1rLhq_FHFNOdCjgU-EoyfOiGofe3uc1_xGfx8ybitaJg/edit?usp=sharing_
http:Feature_Attribute@https://docs.google.com/spreadsheets/d/1CfLVB4grDyl3USSz6YPuAmdPQyEGmYRm56LvvgcXIxs/edit?usp=sharing',
    "Rights" = 'accessConstraint:Access to the data is restricted, contact the creator for an access request',
    "Data" = REPLACE('access:default_
source:table_name.sql_
sourceType:dbquery_
uploadSource:table_name_
uploadType:dbquery_
sql:SELECT * FROM public.table_name_
featureType:rttp_dbquery_
upload:true_
layername: table_name_
geometry:geom,Point_ 
style:point_
spatialRepresentationType:vector_
attribute:schoolnumber[schoolnumber],cruisenumber[cruisenumber]_
variable:timestamp[timestamp]',
'table_name',
    metadata_dcmi."Identifier");


    FOREACH t IN ARRAY geog_tables
    LOOP
        RAISE WARNING '% has been ignored : type is geography unstead of geometry', t;
    END LOOP;

END $$;
