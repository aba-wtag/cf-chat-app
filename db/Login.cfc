component Login {

    public struct function checkValidity(required string username, required string password) {

        var qry = "select * from users where username = :username";
        var findUserNameQuery = new Query();
        findUserNameQuery.setSQL(qry);
        findUserNameQuery.addParam(name="username", value=arguments.username, cfsqltype="cf_sql_varchar");
        var findUserNameQueryResult = findUserNameQuery.execute().getResult();


        try {
            if (len(findUserNameQueryResult) == 1) {
                if (findUserNameQueryResult.password == arguments.password) {
                    return {
                        role = findUserNameQueryResult.role, 
                        username = findUserNameQueryResult.username,
                        password = findUserNameQueryResult.password,
                        error = false,
                        message = "success"
                    };
                } else {
                    return {
                        error = true,
                        message = "password incorrect"
                    };
                }
            } else {
                return {error=true, message= "users does not exists"};
            }
        } catch (any e) {
            return {error=true, message=e.message};
        }
    }

}