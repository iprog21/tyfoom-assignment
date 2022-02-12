# TYFOOM ASSIGNMENT

Setup

1. git clone the repo
2. set ruby version to 2.5.7. if you are using rben, then type this rbenv local 2.5.7. if thats not installed. you need to install the ruby version first.
   2.1 then bundle install
3. rails db:create
4. rails db:migrate
5. rails db:seed ( this will create the admin account. email: admin@gmail.com pass: 123456)
6. rails s then access localhost:3000

DEMO 1: https://www.loom.com/share/e1f66f8651dd4e679392ee64a6769f87
DEMO 2: https://www.loom.com/share/57aa23ae0aa3436881df7c570bde293f

# SPECS

Here is the little programming task - let me know what you think and how long it will take you.

We need to implement an OAuth2 provider so our clients can connect securely to Tyfoom and provision their users and organization structure into their Tyfoom Company organization.

The first step is to get OAuth2 set up, then we can protect the controllers with an authorization check from Oauth2 (doorkeeper gem with Client Credentials flow see https://auth0.com/docs/get-started/authentication-and-authorization-flow/client-credentials-flow for diagrams and descriptions).

Success is in demonstrating the creation of company client credentials and demonstrating authorized access and blocking unauthorized access.

You can put it in GitHub with some minimal documentation so I can check it out and test it. My github handle is bartpalmtree so you can invite me to view your code.

Looking forward to following your progress!

- The Company model has id and name fields.
- The User model has id, name, and company_id fields. Users currently authenticate with devise gem.
- Need to configure and set up OAuth2 via the doorkeeper gem
  - Configure for Client Credentials flow
  - Make the Company the owner of OAuth2 applications.
- When you create a company it should also create the OAuth2 application, client ID, and secret are all auto-created.
- The company admins can look at the company page to (1) copy the client ID and secret for use with a provisioning script, and (2) click a button that would refresh the secret (invalidating any live auth tokens/credentials created with the old client ID and secret).
- Create a separate api controller that is protected by doorkeeper.
- Show that you can use the client id and secret to connect to the server and obtain an auth token.
- Show that you can, with the auth token, make requests to an endpoint at GET /api/users to retrieve a json list of users.
- Show that you can, with the auth token, make requests to an endpoint at POST /api/users to create a new user.
- Show that you can, with the auth token, make requests to an endpoint at PUT /api/users/:id to update a specific user's name.
