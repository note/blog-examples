#!/bin/bash

cd haskell
stack run | jq --sort-keys '.' > ../out-haskell

cd ../scala
sbt --error run | jq --sort-keys '.' > ../out-scala

cd ..

if diff out-haskell out-scala; then
	echo "Success: output files don't differ"
	rm out-scala out-haskell
else
	echo "Failure: output files differ"
fi
