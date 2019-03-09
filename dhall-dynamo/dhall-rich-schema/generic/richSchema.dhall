let RichTypes = ./richTypes.dhall

in	{
		TableName : Text, 
		KeySchema : List RichTypes.KeySchemaItem,
		AttributeDefinitions : List RichTypes.AttributeDefinition,
	    GlobalSecondaryIndexes: List RichTypes.GlobalSecondaryIndex,
	    ProvisionedThroughput: RichTypes.ProvisionedThroughput
	}
