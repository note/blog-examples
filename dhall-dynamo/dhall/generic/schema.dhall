let Types = ./types.dhall

in	{
		TableName : Text, 
		KeySchema : List Types.KeySchemaItem,
		AttributeDefinitions : List Types.AttributeDefinition,
	    GlobalSecondaryIndexes: List Types.GlobalSecondaryIndex,
	    ProvisionedThroughput: Types.ProvisionedThroughput
	}

