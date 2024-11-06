component {
    public query function getAllContact(required string username) {
        var qry = "SELECT * FROM users WHERE username != :username";
        var findContactsQuery = new Query();
        findContactsQuery.setSQL(qry);
        findContactsQuery.addParam(name="username", value=arguments.username, cfsqltype="cf_sql_varchar");
        var findContactsQueryResult = findContactsQuery.execute().getResult();

        return findContactsQueryResult;
    }

    public void function insertMessage(required string body, required string from, required string chat_id) {
        var qry = "INSERT INTO messages (body, `from`, chat_id) VALUES (:body, :from, :chat_id)";
        var messageInsertQuery = new Query();
        messageInsertQuery.setSQL(qry);
        messageInsertQuery.addParam(name="body", value=arguments.body, cfsqltype="cf_sql_varchar");
        messageInsertQuery.addParam(name="from", value=arguments.from, cfsqltype="cf_sql_varchar");
        messageInsertQuery.addParam(name="chat_id", value=arguments.chat_id, cfsqltype="cf_sql_integer");
        messageInsertQuery.execute();
    }
}