# cf-chat-app
A prototype chat app implementation using ColdFusion and WebSocket extension.

## Note

Before proceeding you should have a `URL Rewrite` enabled `lucee` server. Please refer to this [aba-wtag/Custom_Lucee](https://github.com/aba-wtag/Custom_Lucee) for a custom server.

## Directory Listing

```bash
.
├── Application.cfc
├── controllers
│   ├── login
│   │   ├── login.cfc
│   │   └── login-controller.cfm
│   ├── logout
│   │   └── logout-controller.cfm
│   └── signup
│       ├── signup.cfc
│       └── signup-controller.cfm
├── lib
│   ├── Helper.cfc
│   └── Router.cfc
├── README.md
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
        └── user.cfm

10 directories, 18 files
```


