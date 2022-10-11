function idLookup(string id) returns string {
    string newId = id;
    match id {
       "SAMSUNG" => {
           newId = "TheJoshTruck";
       }
       "sri" => {
           newId = "SRIDRV";
       }
    }
    return newId;
}
