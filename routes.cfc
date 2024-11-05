component routes
    output = false
    hint = "Routes defination should be defined here"
    {

    public void function init() {
        var router = new lib.Router();

        router.get("/", "/views/index.cfm");
        router.get("/signup", "/views/signup.cfm");
        router.get("/login", "/views/login.cfm");
        router.get("/logout", "/controllers/logout/logout-controller.cfm");

        if (CGI.PATH_INFO.startswith("/admin") && isUserInRole('admin')) {
            router.get("/admin", "/views/admin/admin.cfm");
        } 

        if (CGI.PATH_INFO.startswith("/user") && isUserInRole('user')) {
            router.get("/user/profile", "/views/user/user.cfm");
            router.get("/user/chat", "/views/user/chat.cfm");
        } 


        router.post("/signup", "/controllers/signup/signup-controller.cfm");
        router.post("/login", "/controllers/login/login-controller.cfm");

        router.get("*", "/views/404.cfm");
    }
}

