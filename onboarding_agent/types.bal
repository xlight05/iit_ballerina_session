type OnboardEntry record {|
    string uid;
    string token;
    string org;
|};

type OnboardData record {|
    string uid;
    string likeStatus;
    map<string> repoSummary;
|};

type StarData record {|
    string uid;
    string status;
|};

type SummaryEntry record {
    string uid;
    map<string> summaries = {};
    //Status?
};
