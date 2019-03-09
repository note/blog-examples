let Types = ./generic2/types.dhall
let Schema = ./generic2/schema.dhall
let Functions = ./generic2/functions.dhall

let RichTypes = ./generic2/richTypes.dhall
let RichSchema = ./generic2/richSchema.dhall

let transformSchema = ./generic2/transformSchema.dhall

let id = "Id"
let artist = "Artist"
let song = "Song"
let year = "Year"
let defaultThroughput = Functions.mkThroughput 2 2

let richMigration: RichSchema = { 
	TableName = "Songs", 
	KeySchema = [Functions.mkHashIndex id],
	AttributeDefinitions = [
		Functions.mkStringAttribute id,
		Functions.mkStringAttribute artist,
		Functions.mkStringAttribute song,
		Functions.mkNumberAttribute year
	],
	GlobalSecondaryIndexes = [
		Functions.mkIndex [Functions.mkHashIndex artist, Functions.mkRangeIndex song]   (Functions.mkThroughput 3 3),
		Functions.mkIndex [Functions.mkHashIndex year,   Functions.mkRangeIndex artist] defaultThroughput
	],
    ProvisionedThroughput  = defaultThroughput
}

in

transformSchema richMigration
