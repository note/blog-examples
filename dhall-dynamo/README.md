## Rewrite DynamoDB cli-input-json with Dhall

This repository contains code used for blogpost (Replace JSON with Dhall: DynamoDB case study)[https://msitko.pl/blog/2019/03/13/replace-json-with-dhall.html]

### Structure

* `json/table.json` - contains original JSON file
* `dhall` - rewrite in Dhall; described in details in the blogpost
* `dhall-rich-schema` - contains a prototype of solution #3 mentioned in paragraph `Possible solutions` of the blogpost

### How to run code in `dhall` directory

First you need to install `dhall-to-json` according to [instructions](https://github.com/dhall-lang/dhall-lang/wiki/Getting-started%3A-Generate-JSON-or-YAML).

Then:

```
dhall-to-json --explain --pretty <<< './dhall/migration.dhall : ./dhall/generic/schema.dhall'
```

### Tests

There are 2 bash scripts for testing whether Dhall equivalents correspond excactly to original JSON:

* `test.sh` - verifies output JSON of code from `dhall` directory is as expected
* `richTest.sh` - verifies output JSON of code from `dhall-rich-schema` directory is as expected
