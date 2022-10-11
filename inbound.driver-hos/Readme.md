# Ballerina Project with a Data Mapping Sample

## Files
 - transform.bal: Contains the data mapping function - An expression bodied Ballerina Function
 - types.bal: Contains Ballerina record types defined to represent input and output json payloads
 - map.liquid: contains the Liquid transformation script for reference
 - tests/transform_test.bal: Contains Ballerina Test case for testing the data mapping function
 - tests/resources/input.json: Input payload for testing the mapping function
 - tests/resources/output.json: Expected payload to assert mapping result while testing
 - tests/data.bal: Data provider function for tests, you can add more test data here.

 ## How to test

 1. Install latest Ballerina distribution from ballerina.io (This was tested on Ballerina 2201.1.0 (Swan Lake Update 1))
 2. Update tests/resources/input.json and tests/resources/output.json files with input payload and expected payload accordingly.
 3. In a shell, run ```bal test --tests transformTest``` from project root dir
