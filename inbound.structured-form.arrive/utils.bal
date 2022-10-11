import ballerina/regex;
import ballerina/io;
import ballerina/time;

function idLookup(string id) returns string {
    return id == "SAMSUNG" ? "TheJoshTruck" : id;
}

function reverseMessageId(string msgId) returns string {
    string[] msgIdParts = regex:split(msgId, "-");
    string[] reversedMsgParts = msgIdParts.'map(
        function(string msgIdPart) returns string {
            var reversedChars = regex:split(msgIdPart, "")
                    .reverse();
            var reversedPart = "";
            foreach var char in reversedChars {
                reversedPart += char;
            }
            return reversedPart;
        }
    );
    var reversedId = "";
    foreach int i in 0 ..< reversedMsgParts.length() {
        reversedId += reversedMsgParts[i] 
            + (i != reversedMsgParts.length() -1 ? "-": "");
    }
    io:println(reversedId);
    return reversedId;
}
