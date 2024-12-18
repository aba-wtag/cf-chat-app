component GroupChat {
    public void function createGroupChat(required string group_name, required array group_members) {
        var qry = "INSERT INTO chats (chat_name, is_grouped) VALUES (:group_name, 1)";
        var groupInsertQuery = new Query();
        groupInsertQuery.setSQL(qry);
        groupInsertQuery.addParam(name="group_name", value=arguments.group_name, cfsqltype="cf_sql_varchar");

        var chat_id = groupInsertQuery.execute().getPrefix().generatedKey;

        // var qry = "insert into chat_members (chat_id, user_id) select '87', u.user_id from users u where u.username in ('user1', 'user2', 'user3')"
        var qry = "INSERT INTO chat_members (chat_id, user_id) SELECT :chat_id, u.user_id FROM users u WHERE u.username in (:username_list)";
        var insertGroupMembers = new Query();
        insertGroupMembers.setSQL(qry);
        insertGroupMembers.addParam(name="chat_id", value=chat_id, cfsqltype="cf_sql_integer");
        insertGroupMembers.addParam(name="username_list", value=arguments.group_members, cfsqltype="cf_sql_varchar", list="true");

        insertGroupMembers.execute();
    }

    public any function getCommonChatId(required array group_members) {
        var qry = "
            SELECT cm.chat_id
            FROM chat_members cm
            JOIN users u ON cm.user_id = u.user_id
            WHERE u.username IN (:username_list)
            GROUP BY cm.chat_id
            HAVING COUNT(DISTINCT u.username) = :num_members
        ";

        var chatIDQuery = new Query();
        chatIDQuery.setSQL(qry);
        chatIDQuery.addParam(name="username_list", value=arguments.group_members, cfsqltype="cf_sql_varchar", list=true);
        chatIDQuery.addParam(name="num_members", value=arrayLen(arguments.group_members), cfsqltype="cf_sql_integer");

        var result = chatIDQuery.execute();

        return result.getResult();
    }

    public query function findGroupChatsByUsername(required string username) {
        var qry = "
            SELECT c.chat_name
            FROM chats c
            JOIN chat_members cm ON c.chat_id = cm.chat_id
            JOIN users u ON cm.user_id = u.user_id
            WHERE u.username = :username
            AND c.is_grouped = true
        ";
    
        var chatQuery = new Query();
        chatQuery.setSQL(qry);
        chatQuery.addParam(name="username", value=arguments.username, cfsqltype="cf_sql_varchar");
        var result = chatQuery.execute().getResult();
    
        return result;
    }

    public any function getGroupChatId(required string chat_name) {
        var qry = "SELECT chat_id FROM chats WHERE chat_name = :chat_name";

        var findChatId = new Query();
        findChatId.setSQL(qry);
        findChatId.addParam(name="chat_name", value=arguments.chat_name, cfsqltype="cf_sql_varchar");

        var result = findChatId.execute().getResult();

        return result.getRow(1);
    }
}