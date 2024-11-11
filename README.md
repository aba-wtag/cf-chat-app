# cf-chat-app
A prototype chat app implementation using ColdFusion and WebSocket extension.

## Note

Before proceeding you should have a `URL Rewrite` enabled `lucee` server. Please refer to this [aba-wtag/Custom_Lucee](https://github.com/aba-wtag/Custom_Lucee) for a custom server.

## How to run

* First, clone this [repository](https://github.com/aba-wtag/lucee-mariadb-starter). This repository contains `Dockerfile` and `compose.yml` that is crucial for running the project.

## Directory Listing

```bash
.
├── Application.cfc
├── DB_CHATAPP.sql
├── README.md
├── WEB-INF
│   └── lucee
├── api
│   ├── GroupChat.cfc
│   └── chat.cfc
├── assets
│   └── css
│       └── chat.css
├── controllers
│   ├── chat
│   │   └── ChatListener.cfc
│   ├── login
│   │   └── login-controller.cfm
│   ├── logout
│   │   └── logout-controller.cfm
│   └── signup
│       └── signup-controller.cfm
├── db
│   ├── Chat.cfc
│   ├── GroupChat.cfc
│   ├── Login.cfc
│   └── Signup.cfc
├── lib
│   ├── Converter.cfc
│   ├── Helper.cfc
│   └── Router.cfc
├── routes.cfc
└── views
    ├── 404.cfm
    ├── admin
    │   └── admin.cfm
    ├── index.cfm
    ├── login.cfm
    ├── partials
    │   ├── footer.cfm
    │   └── header.cfm
    ├── signup.cfm
    └── user
        ├── group-chat
        │   ├── groupChatHandler.js
        │   └── groupchat.cfm
        ├── single-chat
        │   ├── chat.cfm
        │   └── chatHandler.js
        └── user.cfm

19 directories, 30 files
```

