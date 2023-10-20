# DCMI_SQL


Script Description

The following script is designed to create and auto-complete a metadata table according to Dublin Core specifications on a Postgres-PostGIS database.
The result is a table that can be used as input for [Geoflow process](https://github.com/r-geoflow/geoflow).

This code was produced as part of the G2OI project Co-financed by the European Union, the French State and the Réunion Region.

<div  style="float:left;">
	<img height=120  width=198  src="https://upload.wikimedia.org/wikipedia/commons/b/b7/Flag_of_Europe.svg">
	<img  src="https://upload.wikimedia.org/wikipedia/fr/thumb/2/22/Republique-francaise-logo.svg/512px-Republique-francaise-logo.svg.png?20201008150502"  height=120  width=140 >
	<img  height=120  width=260  src="https://upload.wikimedia.org/wikipedia/fr/3/3b/Logolareunion.png">
</div>
<br>

The script performs the following actions:

    Declares a variable geog_tables as an array of text to store the names of tables with a geography type.
    Creates a new table with the name metadata_dcmi if it doesn't already exist. The table has the following columns:
        "Identifier": Text column and the primary key.
        "Title": Text column.
        "Description": Text column.
        "Subject": Text column.
        "Creator": Text column.
        "Date": Text column.
        "Type": Text column.
        "Language": Text column.
        "SpatialCoverage": Text column.
        "TemporalCoverage": Text column.
        "Format": Text column.
        "Relation": Text column.
        "Rights": Text column.
        "Provenance": Text column.
        "Data": Text column.
    Adds a unique constraint to the "Identifier" column in the metadata_dcmi table.
    Inserts table names, materialized views, and views into the "Identifier" column of the metadata_dcmi table, excluding specific names.
    Updates the values of various columns in the metadata_dcmi table:
        "Title" is set to the value of the "Identifier" column.
        "Description" is set to the "Identifier" column with underscores replaced by spaces.
        "Subject" is set to a specific list of themes related to the project.
        "Creator" is set to a list of email addresses representing different roles.
        "Type" is set to "Dataset".
        "Language" is set to "eng" (English).
        "TemporalCoverage" is set to "2007/2013".
        "Relation" is set to a list of URLs representing different relations.
        "Rights" is set to a specific access constraint message.
        "Data" is set to a specific data structure with placeholders replaced by the "Identifier" values.
    Notifies the user with a warning for each table in the geog_tables array that has a geography type instead of a geometry type.

This script helps automate the creation and population of a metadata table following Dublin Core specifications in a Postgres-PostGIS database, providing standardized metadata for the database objects.
