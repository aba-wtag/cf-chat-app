<cfscript>

    try {
        new db.Signup().insertToDB(form.username, form.password);
        cflocation(url="/login", addtoken="false");
    } catch (any e) {
        writeOutput("Error occurred: " & e.message);
        cflocation(url="/", addtoken="false");
    }

</cfscript>