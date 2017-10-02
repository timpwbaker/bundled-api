# Bundled

The application is a work in progress, still to come is querying credits, adding
credits and using credits.

Bundled is an API only service for administering credits. If your application
sells individual things, Bundled can help you sell bundles of things without
adding lots of new logic to your application.

For example, if you sell fresh cut flowers and want to allow people to buy 10
bunches of flowers mailed out at their request then a bundle may work well, as
it means they only need to pay once.

# Local setup

This is a Rails 5.1 api only application with a Postgres database. To get up and
running

    brew install postgresql
    bundle exec rails db:create
    bundle exec rails db:migrate

Tests are RSpec, run them with

    bundle exec rspec

# Endpoints

All endpoints are found at the base URL

    https://bundled-api.herokuapp.com

## Create a user

### Path

    /signup

### Method

    POST

### Headers

    {
      "Content-Type: application/json"
    }

### Parameters

    {
      "name":"Dulce Marks",
      "email":"domingo.carroll@langworthturcotte.net",
      "password":"Password",
      "password_confirmation":"Password"
    }

### Response

    201 (Created)

    {
      "message":"Account created successfully",
      "auth_token":"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1"
    }

## Authenticate

### Path

    /auth/login

### Method

    POST

### Headers

    {
      "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1"
      "Content-Type: application/json"
    }

### Parameters

    {
      "email":"domingo.carroll@langworthturcotte.net",
      "password":"Password"
    }

### Response

    200 (OK)

    {
      "auth_token":"eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1"
    }

## Create a bundle

To create a bundle you must first generate a UUID for the customer and store
this in your database, you must also provide the name of the product the bundle
is for.

### Path

    /bundles

### Method

    POST

### Headers

    {
      "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1"
      "Content-Type: application/json"
    }

### Parameters

    {
      "customer_reference":"[CUSTOMER_UUID]",
      "starting_credits":43,
      "remaining_credits":34,
      "product":"Intelligent Paper Watch",
    }

### Response

    {
      "product":"Intelligent Paper Watch",
      "customer_reference":"326abe129f76457c5494",
      "starting_credits":43,
      "remaining_credits":34
    }

## Credit count

Query the number of credits a customer has for a specific product

### Path

    /credit_counter

### Method

    POST

### Headers

    {
      "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1"
      "Content-Type: application/json"
    }

### Parameters

    {
      "customer_reference":"[CUSTOMER_UUID]",
      "product":"Intelligent Paper Watch"
    }

### Response

    {
      "remaining_credits":34
    }

## Credit adjustment

Adjust the number of credits on a bundle for a specific customer and product

### Path

    /credit_adjustment

### Method

    POST

### Headers

    {
      "Authorization: eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoyLCJleHAiOjE1"
      "Content-Type: application/json"
    }

### Parameters

    {
      "customer_reference":"[CUSTOMER_UUID]",
      "product":"Intelligent Paper Watch",
      "credit_adjustment":-1
    }

### Response

    {
      "credit_adjustment":-1,
      "remaining_credits":33
    }
