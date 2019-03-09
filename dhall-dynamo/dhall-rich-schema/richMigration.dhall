let Types = ./generic/types.dhall
let Schema = ./generic/schema.dhall
let Functions = ./generic/functions.dhall

let RichTypes = ./generic/richTypes.dhall
let RichSchema = ./generic/richSchema.dhall

let transformSchema = ./generic/transformSchema.dhall

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
