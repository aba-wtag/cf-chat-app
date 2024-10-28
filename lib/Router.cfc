component Router 
    output = false
    hint = "I define the routing capability"
    {

    helper = new Helper();

    public void function get (
        required string route,
        required any path_to_include
    ) {

        if (CGI.REQUEST_METHOD == "GET") {
            evaluateRoute(route, path_to_include);
        }

        return;
    }

    public void function post (
        required string route,
        required any path_to_include
    ) {

        if (CGI.REQUEST_METHOD == "POST") {
            evaluateRoute(route, path_to_include);
        }

        return;
    }

    private void function evaluateRoute (
        required string route,
        required any path_to_include
    ) {

        if (arguments.route == "*") {
            cfinclude(template=arguments.path_to_include, runonce=true);
            exit;
        }

        if (isClosure(arguments.path_to_include)) {
            path_to_include();
            exit;
        } else {
            if (helper.parseURL(CGI.PATH_INFO) == arguments.route) {
                cfinclude(template=arguments.path_to_include, runonce=true);
                exit;
            }
        }

        return;
    }
}
