component {

    this.name = "chatapp";
    this.sessionManagement = true;
    this.loginstorage = "session";
    this.datasource = "chatapp";

    this.mappings['/views'] = getDirectoryFromPath(getCurrentTemplatePath()) & "views";
    this.mappings['/controllers'] = getDirectoryFromPath(getCurrentTemplatePath()) & "controllers";
    this.mappings['/assets'] = getDirectoryFromPath(getCurrentTemplatePath()) & "assets";

    public void function onRequest() {
        new routes().init();
    }
}
