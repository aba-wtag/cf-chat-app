<cflogout/>

<cfinclude template="./partials/header.cfm" runonce="true"/>

<div class="container mt-5">
    <div class="form-container">
        <h2>Login</h2>
        <form action="/login" method="POST">
            <div class="mb-3">
                <label for="username" class="form-label">User Name</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>
            <button type="submit" class="btn btn-primary">Login</button>
        </form>
    </div>
</div>


<cfinclude template="./partials/footer.cfm" runonce="true"/>