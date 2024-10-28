<cfscript>

    var res = new login().checkValidity(form.username, form.password); 
 
    if (res.error) {
       cflocation(url="/", addtoken="false");
    } else {
       cflogin() {
          cfloginuser(name=res.username, password=res.password, roles=res.role);
       }
 
       cflocation(url="/", addtoken="false");
    }
 
    dump(res);
 
 </cfscript>