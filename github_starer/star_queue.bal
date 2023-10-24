import ballerinax/github;
import ballerinax/rabbitmq;
import ballerina/log;

map <StarData> starDB = {};

service "StarQueue" on new rabbitmq:Listener(rabbitmq:DEFAULT_HOST, rabbitmq:DEFAULT_PORT) {

    remote function onMessage(StarEntry entry) returns error? {
        final github:Client ghClient = check new ({auth: {token: entry.token}});
        log:printInfo("Started starting the repos for user id : " + entry.uid);
        StarData payload = {
            uid: entry.uid,
            status: "pending"
        };
        starDB[entry.uid] = payload;

        stream<github:Repository, github:Error?> repos = check ghClient->getRepositories(entry.org, true);
        check repos.forEach(function(github:Repository repo) {
            github:Error? starRepository = ghClient -> starRepository(repo.owner.login, repo.name);
            if (starRepository is github:Error) {
                log:printError("Error occurred while starring the repo : ", starRepository);
            } else {
                log:printInfo("Starred the repo : " +  repo.name);
            }
        });
        
        payload = {
            uid: entry.uid,
            status: "completed"
        };
        starDB[entry.uid] = payload;
        log:printInfo("Finished staring orgs for the user id : " + entry.uid);
    }
}
