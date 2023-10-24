import ballerina/http;

service /summary on new http:Listener(9094) {
    resource function get .(string uid) returns SummaryEntry|http:NotFound {
        SummaryEntry? entry = summaryDB[uid];
        if entry is () {
            return http:NOT_FOUND;
        }
        return entry;
    }
}

