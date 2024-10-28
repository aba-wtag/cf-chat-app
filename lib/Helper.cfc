component Helper
    output = false
    hint = "Helper functions for the Router.cfc"
    {

        public string function parseURL (
            required string inputURL
        ) {
            if (len(arguments.inputURL) == 1 && arguments.inputURL == "/") {
                return arguments.inputURL;
            } 

            return reReplace(arguments.inputURL, "\/+$", "\1") ;
        }
}
