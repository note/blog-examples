let Types = ./types.dhall
let Functions = ./functions.dhall

let id = "Id"
let artist = "Artist"
let song = "Song"
let year = "Year"
let throughput = {
				   	WriteCapacityUnits = 2,
				 	ReadCapacityUnits  = 2
				 }


let IndexComponent = {
	KeyType 		: Text,
	AttributeName 	: Text
}


in

{ 
	TableName = "users", 
	KeySchema = [Functions.mkHashIndex id],
	AttributeDefinitions = [
		Functions.mkStringAttribute id,
		Functions.mkStringAttribute artist,
		Functions.mkStringAttribute song,
		Functions.mkNumberAttribute year
	],
	GlobalSecondaryIndexes = [
		Functions.mkIndex [Functions.mkHashIndex artist, Functions.mkRangeIndex song]   throughput,
		Functions.mkIndex [Functions.mkHashIndex year,   Functions.mkRangeIndex artist] throughput
	],
    ProvisionedThroughput  = throughput
}
