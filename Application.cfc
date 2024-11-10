component {

    this.name = "chatapp";
    this.sessionManagement = true;
    this.loginstorage = "session";
    this.datasource = "chatapp";

    this.mappings['/views'] = getDirectoryFromPath(getCurrentTemplatePath()) & "views";
    this.mappings['/controllers'] = getDirectoryFromPath(getCurrentTemplatePath()) & "controllers";
    this.mappings['/assets'] = getDirectoryFromPath(getCurrentTemplatePath()) & "assets";
    this.mappings['/lib'] = getDirectoryFromPath(getCurrentTemplatePath()) & "lib";
    this.mappings['/db'] = getDirectoryFromPath(getCurrentTemplatePath()) & "db";

    public void function onApplicationStart() {
        WebsocketServer("/ws/chat/{channel}", new controllers.chat.ChatListener());
    }

    public void function onRequest() {
        new routes().init();
    }

}
