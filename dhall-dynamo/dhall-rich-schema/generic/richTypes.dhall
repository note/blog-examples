-- types are the same as in `types.dhall` except of `AttributeType` which is an union type instead of `Text`
-- in real example it would be beneficial to make more of them more specific (e.g. KeySchemaItem.KeyType)

let Types = ./types.dhall

let AttributeType = < Number : {} | Binary : {} | String : {} >
let attributeType = constructors AttributeType

let AttributeDefinition = {
	AttributeName: Text,
	AttributeType: AttributeType
}

in

{
	attributeType 		  = attributeType,
	AttributeType 		  = AttributeType,
	AttributeDefinition	  = AttributeDefinition,
	GlobalSecondaryIndex  = Types.GlobalSecondaryIndex,
	IndexComponent		  = Types.IndexComponent,
	KeySchemaItem		  = Types.KeySchemaItem,
	ProvisionedThroughput = Types.ProvisionedThroughput
}
