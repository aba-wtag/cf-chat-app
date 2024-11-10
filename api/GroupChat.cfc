component restpath="/groupchat"  rest="true" {
    remote any function createGroupChat(required struct data) httpmethod="POST" restpath="create" {
        try {
            if (len(arguments.data.group_members) < 3) {
                cfheader(statuscode="422");
                return { "message": "atleast 3 members needed" };
            }

            if (len(new db.GroupChat().getCommonChatId(arguments.data.group_members)) > 0) {
                cfheader(statuscode="422");
                return { "message": "group already exists" };
            }

            new db.GroupChat().createGroupChat(arguments.data.group_name, arguments.data.group_members);
            cfheader(statuscode="201", statustext="Created");
            return { "message": "group creation successful" };

        } catch (any e) {
            cfheader(statuscode="500");
            return { "message": e.message };
        }
    }

    remote any function test(required struct data) httpmethod="POST" restpath="test" {
        var result = new db.GroupChat().getCommonChatId(arguments.data.group_members);
        cfheader(statuscode="200");
        return len(result);
    }
}