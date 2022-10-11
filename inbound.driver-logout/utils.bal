import ballerina/time;

function idLookup(string id) returns string {
    return "TheJoshTruck";
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
            string secs = civilTime.second.toString() == "0" ? "00" : string `${civilTime.second?:"00"}`;
            return string `${civilTime.year}-${civilTime.month}-${civilTime.day}T${civilTime.hour}:${civilTime.minute}:${secs}${removeAbbrev ? "" : outAbbr}`;
        }
    }
    return "";
}