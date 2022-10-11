import ballerina/time;

function idLookup(string id) returns string {
    string newId = id;
    match id {
       "SAMSUNG" => {
           newId = "TheJoshTruck";
       }
    }
    return newId;
}

function typeLookup(string 'type) returns int {
    int newType = -1;
    match 'type {
       "Tractor" => {
           newType = 1;
       }
       "Driver" => {
           newType = 2;
       }
    }
    return newType;
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
            string month = civilTime.month < 10 ? "0" + civilTime.month.toBalString() : civilTime.month.toBalString();
            return string `${civilTime.year}-${month}-${civilTime.day}T${civilTime.hour}:${civilTime.minute}:${secs}${removeAbbrev ? "" : outAbbr}`;
        }
    }
    return "";
}

function collectOrderItems(OrdersItem[][] orderItems) returns OrdersItem[] {
    OrdersItem[] collectedItems = [];
    foreach var items in orderItems {
        collectedItems.push(...items);
    }
    return collectedItems;
}