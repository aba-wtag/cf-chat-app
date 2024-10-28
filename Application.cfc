component {

    this.name = "chatapp";
    this.sessionManagement = true;
    this.loginstorage = "session";
    this.datasource = "chatapp";

    public void function onRequest() {
        new routes().init();
    }
}
