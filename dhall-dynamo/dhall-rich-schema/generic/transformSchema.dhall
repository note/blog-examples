let RichTypes = ./richTypes.dhall
let RichSchema = ./richSchema.dhall
let Types = ./types.dhall

let Prelude/List/map  = https://raw.githubusercontent.com/dhall-lang/Prelude/35deff0d41f2bf86c42089c6ca16665537f54d75/List/map

let transformAttributeType = 
	λ(x : RichTypes.AttributeType)
      → merge
        { Number = λ(t : {}) → "N"
        , Binary = λ(t : {}) → "B"
        , String = λ(t : {}) → "S"
        }
        x

let transformAttributeDefinition = 
	λ(x : RichTypes.AttributeDefinition)
      → {
      	AttributeName = x.AttributeName,
      	AttributeType = transformAttributeType x.AttributeType
      } : Types.AttributeDefinition

let transform = 
	λ(richSchema 		: RichSchema)
  → {
	  	TableName = richSchema.TableName, 
		KeySchema = richSchema.KeySchema,
		AttributeDefinitions = Prelude/List/map RichTypes.AttributeDefinition Types.AttributeDefinition (λ(x: RichTypes.AttributeDefinition) → (transformAttributeDefinition x)) richSchema.AttributeDefinitions,
		GlobalSecondaryIndexes = richSchema.GlobalSecondaryIndexes,
	    ProvisionedThroughput  = richSchema.ProvisionedThroughput
	}

in

transform