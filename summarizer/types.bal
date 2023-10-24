type SummaryRequest record {
    string uid;
    string token;
    string org;
};

type SummaryEntry record {
    string uid;
    map<string> summaries = {};
    //Status?
};
