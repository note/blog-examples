#!/usr/bin/env bash

# It runs dhall for `migration.dhall` and then compares the JSON output to expected one
dhall-to-json --explain --pretty <<< './dhall/migration.dhall : ./dhall/generic/schema.dhall' > dhall.out && diff <(jq -S . dhall.out) <(jq -S . json/table.json)
