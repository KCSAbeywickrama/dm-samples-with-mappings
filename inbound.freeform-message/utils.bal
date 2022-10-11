import ballerina/time;

function idLookup(string id) returns string {
    return "TheJoshTruck";
}

function convertDate(string date) returns string {
    time:Civil|time:Error civilTime = time:civilFromString(date);
    if civilTime is time:Civil {
        decimal? seconds = civilTime?.second;
        if (seconds is decimal) {
            civilTime.second = seconds.floor();
        }
        string? abbr = civilTime.timeAbbrev;
        if (abbr is string) {
            return string `${civilTime.year}-${civilTime.month}-${civilTime.day}T${civilTime.hour}:${civilTime.minute}:${civilTime.second?:"00"}${abbr != "Z" ? abbr : "+00:00"}`;
        }
    }
    return "";
}