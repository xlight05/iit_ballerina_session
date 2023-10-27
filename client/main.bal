import ballerina/http;
import ballerina/io;
import ballerina/lang.runtime;

type OnboardData record {|
    string uid;
    string likeStatus;
    map<string> repoSummary;
|};

type OnboardEntry record {|
    string uid;
    string token;
    string org;
|};

public function main() returns error? {
    http:Client onboardClient = check new ("localhost:9092");

    OnboardEntry reqData = {
        uid: "<<Your Name>>",
        token: "<<PAT Token>>",
        org: "ballerina-platform"
    };

    io:println("Sending the request");
    // TODO : Send a POST Request to /onboard using onboardClient varaible with above reqData and assign it to http:Response variable
    // TODO : Check if the response status code is 202


    // Sleep for 20 seconds to wait till some onboarded data is available
    io:println("Waiting 20 seconds till some onboarded data is available");
    runtime:sleep(20);

    // TODO : Send a GET request to /onboard/status using onboardClient varaible. It should have a uid query parameter. 
    // TODO : Then assign it to OnboardData and print it.
    io:println("Sending the GET request to retrieve the data");


}
