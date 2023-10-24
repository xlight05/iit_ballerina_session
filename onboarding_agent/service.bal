import ballerina/http;
import ballerinax/rabbitmq;

final http:Client starClient = check new("http://localhost:9093");
final http:Client summaryClient = check new("http://localhost:9094");


service /onboard on new http:Listener(9092) {
    private final rabbitmq:Client orderClient;

    function init() returns error? {
        self.orderClient = check new (rabbitmq:DEFAULT_HOST, rabbitmq:DEFAULT_PORT);
    }

    resource function post .(OnboardEntry entry) returns http:Accepted|error {

        check self.orderClient->publishMessage({
            content: entry,
            routingKey: "StarQueue"
        });

        check self.orderClient->publishMessage({
            content: entry,
            routingKey: "SummaryQueue"
        });

        return http:ACCEPTED;
    }
    resource function get status(string uid) returns OnboardData|http:NotFound {
        StarData|http:ClientError starData = starClient->/star(uid=uid);
        if starData is http:ClientError {
            return http:NOT_FOUND;
        }
        SummaryEntry|http:ClientError summaryData = summaryClient->/summary(uid=uid);
        if summaryData is http:ClientError {
            return http:NOT_FOUND;
        }
        return {
            uid: uid,
            likeStatus: starData.status,
            repoSummary: summaryData.summaries
        };
    }
}
