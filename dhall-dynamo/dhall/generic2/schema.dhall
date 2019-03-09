-- This schema uses only primitives at the nodes level

-- We can extract this repetitive fragment here:
-- TODO: Can we extract key name `ProvisionedThroughput` itself. I tried https://github.com/dhall-lang/dhall-lang/wiki/Getting-started%3A-Generate-JSON-or-YAML#combining-records
-- but it works only for records and here we operate on type
let Types = ./types.dhall

in	{
		TableName : Text, 
		KeySchema : List Types.KeySchemaItem,
		AttributeDefinitions : List Types.AttributeDefinition,
	    GlobalSecondaryIndexes: List Types.GlobalSecondaryIndex,
	    ProvisionedThroughput: Types.ProvisionedThroughput
	}



-- "KeyType": "HASH", 
--            "AttributeName": "fingerprint"


-- https://docs.aws.amazon.com/amazondynamodb/latest/APIReference/API_CreateTable.html
-- https://docs.aws.amazon.com/amazondynamodb/latest/developerguide/DynamoDBMapper.DataTypes.html
-- let type = constructors < A : {} | B : {} > in [ type.A {=}, type.B {=} ]
-- https://github.com/dhall-lang/dhall-lang/issues/35
-- let type = constructors < A : {} | B : {} > in [ type.A {=}, type.B {=} ]
