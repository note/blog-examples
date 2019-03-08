#!/usr/bin/env bash

dhall-to-json  --pretty <<< './dhall/migration.dhall : ./dhall/schema.dhall' > dhall.out

diff <(jq -S . dhall.out) <(jq -S . json/table.json)
