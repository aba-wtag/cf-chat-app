component {
    function onOpen(websocket, endpointConfig, sessionScope, applicationScope) {
        // this.notifyChannel(
        //     arguments.websocket,
        //     {
        //         from: "<server>",
        //         message: serializeJSON({ from: "server", message: "connected"})
        //     }
        // );
    }

    function onMessage(websocket, message, sessionScope, applicationScope) {

        var data = deserializeJSON(message);

        new db.Chat().insertMessage(data.message, data.from, data.chat_id);

        this.notifyChannel(
            arguments.websocket,
            {
                from: "wow",
                message: arguments.message,
                more: arguments.sessionScope

            }
        );
    }

    private void function notifyChannel(websocket, data) {
        var chanId = arguments.websocket.getPathParameters().channel;
        var connMgr = arguments.websocket.getConnectionManager();
        arguments.data.channel = chanId;
        arguments.data.timestamp = getTickCount();

        connMgr.broadcast(chanId, serializeJSON(arguments.data));
    }
}

