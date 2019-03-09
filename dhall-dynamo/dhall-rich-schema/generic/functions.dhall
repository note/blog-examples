let Types = ./types.dhall
let RichTypes = ./richTypes.dhall

let Prelude/List/fold = https://raw.githubusercontent.com/dhall-lang/Prelude/35deff0d41f2bf86c42089c6ca16665537f54d75/List/fold
let Prelude/List/map  = https://raw.githubusercontent.com/dhall-lang/Prelude/35deff0d41f2bf86c42089c6ca16665537f54d75/List/map


let mkIndexComponent = 
	λ(keyType 		: Text)
  → λ(attributeName : Text)
  → {
    KeyType 		= keyType,
    AttributeName   = attributeName
  }
let mkHashIndex  = mkIndexComponent "HASH"
let mkRangeIndex = mkIndexComponent "RANGE"
let mkIndex = 
    λ(components: List Types.IndexComponent)
  → λ(throughput: Types.ProvisionedThroughput)
  → let attributeNames = Prelude/List/map Types.IndexComponent Text (λ(x: Types.IndexComponent) → x.AttributeName) components
    in {
	     IndexName = Prelude/List/fold Text attributeNames Text (λ(x : Text) → λ(y : Text) → x ++ y) "Index",
	     Projection = {
	       ProjectionType = "ALL"
	     },
	     ProvisionedThroughput = throughput,
	     KeySchema = components
	   }
let mkAttribute = 
	λ(attributeType 		: RichTypes.AttributeType)
  → λ(attributeName 		: Text)
  → {
  	AttributeName = attributeName,
	AttributeType = attributeType
  }
-- partially applied functions for each of types:
let mkStringAttribute = mkAttribute (RichTypes.attributeType.String {=})
let mkNumberAttribute = mkAttribute (RichTypes.attributeType.Number {=})
let mkThroughput = 
	λ(writeUnits 		: Natural)
  → λ(readUnits 		: Natural)
  → {
       WriteCapacityUnits = writeUnits,
       ReadCapacityUnits  = readUnits
	}

in {
	mkIndexComponent = mkIndexComponent,
	mkHashIndex = mkHashIndex,
	mkRangeIndex = mkRangeIndex,
	mkIndex = mkIndex,
	mkAttribute = mkAttribute,
	mkStringAttribute = mkStringAttribute,
	mkNumberAttribute = mkNumberAttribute,
	mkThroughput     = mkThroughput
}
