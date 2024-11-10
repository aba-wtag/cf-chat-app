component restpath="/chat"  rest="true" {
    remote any function getChatInfo(required struct data) httpmethod="POST" restpath="getchatinfo" {
        try {
            var res =  new db.Chat().getChatInfo(arguments.data.from, arguments.data.to);
            return res;
        } catch (any e) {
            return { "message": e.message };
        }
    }

    remote any function getChatMessages(required struct data) httpmethod="POST" restpath="getchatmessages" {
        try {
            var res = new db.Chat().getMessagesWithChatID(arguments.data.chat_id);
            return res;
        } catch (any e) {
            return { "message": e.message };
        }
    }
}