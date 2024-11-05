component restpath="/chat"  rest="true" {
    remote any function getChatInfo(required struct data) httpmethod="POST" restpath="getchatinfo" {
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
        findChatId.addParam(name="username1", value=arguments.data.from, cfsqltype="cf_sql_varchar");
        findChatId.addParam(name="username2", value=arguments.data.to, cfsqltype="cf_sql_varchar");
        var findChatIdResult = findChatId.execute().getResult();


        if(len(findChatIdResult)) {
            return findChatIdResult.getRow(1);
        } else {
            var qry = "INSERT INTO chats (chat_name, is_grouped) VALUES(:chat_name, :is_grouped)";

            var createNewChat = new Query();
            createNewChat.setSQL(qry);
            createNewChat.addParam(name="chat_name", value=arguments.data.from & '-' &arguments.data.to, cfsqltype="cf_sql_varchar");
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
            insertMembers.addParam(name="username1", value=arguments.data.from, cfsqltype="cf_sql_varchar");
            insertMembers.addParam(name="username2", value=arguments.data.to, cfsqltype="cf_sql_varchar");

            // Execute the query to insert members into chat_members
            insertMembers.execute();

            return last_insert;
        }

        return {"message": "error happened"};
    }
}