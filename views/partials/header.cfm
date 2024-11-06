<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>cf-chat-app</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <style>
        body {
            padding-top: 56px;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-light bg-light fixed-top">
        <div class="container">
            <a class="navbar-brand" href="/">cfchat</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <cfif isUserInRole('admin')>
                            <a class="nav-link" href="/admin">admin index</a>
                        <cfelseif isUserInRole('user')>
                            <div class="d-flex">
                                <a class="nav-link" href="/user/profile">Profile</a>
                                <a class="nav-link" href="/user/chat">Chat</a>
                            </div>
                        <cfelse>
                            <a class="nav-link" href="/">Home</a>
                        </cfif>
                    </li>
                </ul>
                <div class="d-flex">
                    <cfif getAuthUser() neq "">
                        <cfoutput>
                            <span class="navbar-text me-3">
                                Welcome, #getAuthUser()#! Your role is #getUserRoles()#
                            </span>
                            <a class="btn btn-danger" href="/logout">Logout</a>
                        </cfoutput>
                    <cfelse>
                        <a class="btn btn-primary me-2" href="/login">Login</a>
                        <a class="btn btn-secondary" href="/signup">Sign Up</a>
                    </cfif>
                </div>
            </div>
        </div>
    </nav>



<!-- Your content goes here -->
