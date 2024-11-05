component signup {

    public void function insertToDB(required string username, required string password) {
        try {
            var sql = "INSERT INTO users (username, password) VALUES (:username, :password)";
            
            var qry = new Query();
            qry.setSQL(sql);
            qry.addParam( name="username", value= arguments.username, cfsqltype="cf_sql_varchar" ); 
            qry.addParam( name="password", value= arguments.password, cfsqltype="cf_sql_varchar" ); 
            qry.execute().getResult();

            writeOutput("A new user was inserted successfully!");

            cflocation(url="/login", addtoken="false");

        } catch (any e) {
            writeOutput("Error occurred: " & e.message);
            cflocation(url="/", addtoken="false");
        }
    }

}