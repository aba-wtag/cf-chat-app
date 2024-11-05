component {
    public query function getAllContact(required string username) {
        var qry = "SELECT * FROM users WHERE username != :username";
        var findContactsQuery = new Query();
        findContactsQuery.setSQL(qry);
        findContactsQuery.addParam(name="username", value=arguments.username, cfsqltype="cf_sql_varchar");
        var findContactsQueryResult = findContactsQuery.execute().getResult();

        return findContactsQueryResult;
    }
}