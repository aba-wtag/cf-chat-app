component restpath="/groupchat"  rest="true" {
    remote any function createGroupChat(required struct data) httpmethod="POST" restpath="create" {
        try {
            if (len(arguments.data.group_members) >= 3) {
                new db.GroupChat().createGroupChat(arguments.data.group_name, arguments.data.group_members);
                return { "message": "group creation successful" };
            } else {
                return { "message": "atleast 3 members needed" };
            }
        } catch (any e) {
            return { "message": e.message };
        }
    }
}