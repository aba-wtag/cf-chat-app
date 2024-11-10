component Chat {

    // using this query will return all the existing usernames except the passed username
    public query function getAllContact(required string username) {
        var qry = "SELECT * FROM users WHERE username != :username";
        var findContactsQuery = new Query();
        findContactsQuery.setSQL(qry);
        findContactsQuery.addParam(name="username", value=arguments.username, cfsqltype="cf_sql_varchar");
        var findContactsQueryResult = findContactsQuery.execute().getResult();

        return findContactsQueryResult;
    }

    // query to insert messages in the database
    public void function insertMessage(required string body, required string from, required string chat_id) {
        var qry = "INSERT INTO messages (body, `from`, chat_id) VALUES (:body, :from, :chat_id)";
        var messageInsertQuery = new Query();
        messageInsertQuery.setSQL(qry);
        messageInsertQuery.addParam(name="body", value=arguments.body, cfsqltype="cf_sql_varchar");
        messageInsertQuery.addParam(name="from", value=arguments.from, cfsqltype="cf_sql_varchar");
        messageInsertQuery.addParam(name="chat_id", value=arguments.chat_id, cfsqltype="cf_sql_integer");
        messageInsertQuery.execute();
    }

    // query to find the chat_id(channel ID) that is only common between 'from' and 'to' users
    public struct function getChatInfo(required string from, required string to) {
        var qry = "SELECT cm1.chat_id
            FROM chat_members cm1
            JOIN chat_members cm2 ON cm1.chat_id = cm2.chat_id
            JOIN users u1 ON cm1.user_id = u1.user_id
            JOIN users u2 ON cm2.user_id = u2.user_id
            JOIN chats c ON cm1.chat_id = c.chat_id  
            WHERE u1.username = :username1  
            AND u2.username = :username2 
            AND c.is_grouped = 0";

        var findChatId = new Query();
        findChatId.setSQL(qry);
        findChatId.addParam(name="username1", value=arguments.from, cfsqltype="cf_sql_varchar");
        findChatId.addParam(name="username2", value=arguments.to, cfsqltype="cf_sql_varchar");
        var findChatIdResult = findChatId.execute().getResult();


        if(len(findChatIdResult)) {
            return findChatIdResult.getRow(1);
        } else {
            return createAndGetLastChatID(arguments.from, arguments.to);
        }

        return;
    }

    // create a channel between 'from' and 'to' users and return the chat_id (channel ID)
    public struct function createAndGetLastChatID(required string from, required string to) {
        var qry = "INSERT INTO chats (chat_name, is_grouped) VALUES(:chat_name, :is_grouped)";

            var createNewChat = new Query();
            createNewChat.setSQL(qry);
            createNewChat.addParam(name="chat_name", value=arguments.from & '-' & arguments.to, cfsqltype="cf_sql_varchar");
            createNewChat.addParam(name="is_grouped", value=0, cfsqltype="cf_sql_tinyint");  // 0 for a non-grouped chat
            createNewChat.execute();

            // QueryExecute("INSERT INTO chats (chat_name, is_grouped) VALUES(" & arguments.data.from & arguments.data.to & ", '0');");
            var last_insert = QueryGetRow(QueryExecute("SELECT LAST_INSERT_ID() AS chat_id;"), 1);

            var qryInsertMembers = "INSERT INTO chat_members (chat_id, user_id)
                                        SELECT :chat_id, user_id
                                        FROM users
                                        WHERE username IN (:username1, :username2)";

            var insertMembers = new Query();
            insertMembers.setSQL(qryInsertMembers);

            insertMembers.addParam(name="chat_id", value=last_insert.chat_id, cfsqltype="cf_sql_integer");
            insertMembers.addParam(name="username1", value=arguments.from, cfsqltype="cf_sql_varchar");
            insertMembers.addParam(name="username2", value=arguments.to, cfsqltype="cf_sql_varchar");

            insertMembers.execute();

            return last_insert; 
    }

    // get all the messages of a specific chat_id
    public any function getMessagesWithChatID(required string chat_id) {
        var qry = "SELECT * FROM messages WHERE chat_id = :chat_id";
        var findMessages = new Query();
        findMessages.setSQL(qry);
        findMessages.addParam(name="chat_id", value=arguments.chat_id, cfsqltype="cf_sql_integer");
        var result = new lib.Converter().queryToArray(findMessages.execute().getResult());

        return result;
    }
}