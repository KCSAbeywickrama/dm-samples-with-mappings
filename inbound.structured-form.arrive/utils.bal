import ballerina/regex;
import ballerina/io;
import ballerina/time;

function idLookup(string id) returns string {
    return id == "SAMSUNG" ? "TheJoshTruck" : id;
}

function convertDate(string date, boolean removeAbbrev = false) returns string {
    time:Civil|time:Error civilTime = time:civilFromString(date);
    if civilTime is time:Civil {
        decimal? seconds = civilTime?.second;
        if (seconds is decimal) {
            civilTime.second = seconds.floor();
        }
        string? abbr = civilTime.timeAbbrev;
        if (abbr is string) {
            string outAbbr = abbr != "Z" ? abbr : "+00:00";
            string secs = civilTime.second.toString() == "0" ? "00" : string `${civilTime.second ?: "00"}`;
            return string `${civilTime.year}-${civilTime.month}-${civilTime.day}T${civilTime.hour}:${civilTime.minute}:${secs}${removeAbbrev ? "" : outAbbr}`;
        }
    }
    return "";
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
