let ProvisionedThroughput = {
	WriteCapacityUnits: Natural,
	ReadCapacityUnits:  Natural
}

let KeySchemaItem = {
	KeyType       : Text,
	AttributeName : Text
}

let AttributeDefinition = {
	AttributeName: Text,
	AttributeType: Text
}

let ProvisionedThroughput = {
	WriteCapacityUnits: Natural,
	ReadCapacityUnits:  Natural
}

let IndexComponent = {
	KeyType 		: Text,
	AttributeName 	: Text
}

let GlobalSecondaryIndex = {
	IndexName: Text,
	Projection: {
		ProjectionType: Text
	},
	KeySchema: List IndexComponent,
	ProvisionedThroughput: ProvisionedThroughput
}

in

{
	AttributeDefinition	  = AttributeDefinition,
	GlobalSecondaryIndex  = GlobalSecondaryIndex,
	IndexComponent		  = IndexComponent,
	KeySchemaItem		  = KeySchemaItem,
	ProvisionedThroughput = ProvisionedThroughput
}