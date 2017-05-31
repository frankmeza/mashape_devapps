# README

### This application is the API component for a developer & application tracker.

It was built using Rails 5.0.3, Ruby 2.3.0p0, runs on the stock SQLite3 database and is thoroughly tested with Minitest.


## Configuration

Clone this repository with: (if using HTTPS to clone)
```
$ git clone https://github.com/frankmeza/mashape_devapps.git
```
Install any gems you don't have locally with:
```
bundle install
```
Create the SQLite3 database with:
```
rails db:create
```
Run the migrations with:
```
rails db:migrate
```
Start the server with:
```
rails s
```

## How to run the test suite

The tests can be run with the very simple `rake` command.

## How to Use the API

First, an `Admin` can perform CRUD operations on, and manage both Developers and their Applications. They must first be created in the Rails Console, as there is no API meant for creating Admins.
```
$ rails console
```
```
$ Admin.create(email: 'admin@api.com', password: 'adminapi')
```

You can then see the admin, like this:
```
$ Admin.find_by(email: 'admin@api.com')
```

## Signing In, Getting an Auth Token
Using [Postman](https://www.getpostman.com/), this application DevApps, can be signed into with this POST request to `localhost:3000/authenticate`:
```
{
  "email":"admin@api.com",
  "password":"adminapi"
}
```

In addition to the 200 status code, you will also generate an auth token.
```
{
  "auth_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhZG1pbl9pZCI6MSwiZXhwIjoxNDk2Mjc1Mjc3fQ.K5Ubw-aezrA_TN4k2mOIF24Jh36vwmubYHPB8MX2K5Q"
}
```
### This is your Admin Authorization Token

Take this value, "eyJ0..." and set it as the value for an 'Authorization' key in the headers, as seen below. You will need to have this in place for all other operations.
```
Authorization:eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJhZG1pbl9pZCI6MSwiZXhwIjoxNDk2MTYzMDg1fQ.H2K_Eyh_mc5NKIiwODu6tt_e-IAv13c_niVglX6lubM
Content-Type:application/json
```

# Admin Rights
As an Admin, you can create a new Developer, like this:
## POST request to `localhost:3000/developers`
...and make sure to include the admin auth token as mentioned above.
```
{
  "username": "developer 1",
  "email": "dev1@email.com",
  "password": "dev1dev1"
}
```

## POST `localhost:3000/developers`
Create a second Developer the same way:
```
{
  "username":"developer 2",
  "email":"dev2@email.com",
  "password": "dev2dev2"
}
```

## GET `localhost:3000/developers`
...for the index, and you will see them both:
```
{
  "developers": [
    {
      "id": 1,
      "username": "developer 1",
      "email": "dev1@email.com",
      "password": "dev1dev1"
    },
    {
      "id": 2,
      "username": "developer 2",
      "email": "dev2@email.com",
      "password": "dev2dev2"
    }
  ]
}
```

## GET `localhost:3000/developers/new`
...for an instantiated but not-yet-valid developer to edit and save.
```
{
  "developer": {
    "id": null,
    "username": null,
    "email": null,
    "password": null
  }
}
```

## GET `localhost:3000/developers/1`
...for the details on just the one. Similarly, you can also hit
## GET `localhost:3000/developers/1/edit`
...and you will see the same JSON object.
```
{
  "developer": {
    "id": 1,
    "username": "developer 1",
    "email": "dev1@email.com",
    "password": "dev1dev1"
  }
}
```

## PUT `localhost:3000/developers/1`
...with the attribute/value to be updated, like this:
```
{
  "username": "developer 1 1/2"
}
```

## DELETE `localhost:3000/developers/1`
...and poof! Developer 1 1/2 is no longer in our database.

# Applications

Applications are tied to Developers and when created, must explicitly be tied to a Developer id, as the value to `"developer_id"` in the POST request.

## POST `localhost:3000/developers/1/applications`
```
{
  "name":"Fun Fun App",
  "key": "fun_fun_app",
  "description": "I'm serious, it's really fun!",
  "developer_id": 1
}
```

### and another!
## POST `localhost:3000/developers/1/applications`
```
{
  "name":"Fun Fun App Part 2",
  "key": "fun_fun_app_part_2",
  "description": "I'm serious, it's really fun!",
  "developer_id": 1
}
```

## GET `localhost:3000/developers/1/applications`
* The Developer info is on the bottom as well, because that might be handy ;)
```
{
  "applications": [
    {
      "id": 1,
      "name": "Fun Fun App",
      "key": "fun_fun_app",
      "description": "I'm serious, it's really fun!",
      "developer_id": 1
    },
    {
      "id": 2,
      "name": "Fun Fun App Part 2",
      "key": "fun_fun_app_part_2",
      "description": "I'm serious, it's really fun!",
      "developer_id": 1
    }
  ],
  "developer": {
    "id": 1,
    "username": "developer 1 1/2",
    "email": "dev1@email.com",
    "password": "dev1dev1"
  }
}
```

## GET `localhost:3000/developers/1/applications/2`
```
{
  "application": {
    "id": 2,
    "name": "Fun Fun App Part 2",
    "key": "fun_fun_app_part_2",
    "description": "I'm serious, it's really fun!",
    "developer_id": 1
  }
}
```

## PUT `localhost:3000/developers/1/applications/2`
... to make some changes.
```
{
  "description": "Not as good as the first one, but it's still really fun!"
}
```

## DELETE `localhost:3000/developers/1/applications/2`
... and it's gone from our records.



