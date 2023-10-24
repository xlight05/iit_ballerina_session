import ballerina/http;

service /star on new http:Listener(9093) {
    resource function get .(string uid) returns StarData|http:NotFound {
        StarData? entry = starDB[uid];
        if entry is () {
            return http:NOT_FOUND;
        }
        return entry;
    }
}
