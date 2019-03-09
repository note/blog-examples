let ProvisionedThroughput = {
	WriteCapacityUnits: Natural,
	ReadCapacityUnits:  Natural
}

let KeySchemaItem = {
	KeyType       : Text,
	AttributeName : Text
}

let AttributeType = < Number : {} | Binary : {} | String : {} >
let attributeType = constructors AttributeType

let AttributeDefinition = {
	AttributeName: Text,
	AttributeType: AttributeType
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
	attributeType 		  = attributeType,
	AttributeType 		  = AttributeType,
	AttributeDefinition	  = AttributeDefinition,
	GlobalSecondaryIndex  = GlobalSecondaryIndex,
	IndexComponent		  = IndexComponent,
	KeySchemaItem		  = KeySchemaItem,
	ProvisionedThroughput = ProvisionedThroughput
}