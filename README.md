# Pipplet Test

## Prerequisites

- Docker [Installation help](https://docs.docker.com/get-docker/)

## Installation steps

- firsty, build the image with the command:

  ```
  $ docker build -t pipplet-interview .
  ```

- secondly, run the app with the command:

  ```
  $ docker run --rm -it -v $(pwd):/pipplet -p 3000:3000 pipplet-interview
  ```

## How to run a command on the docker app

  ```
  $ docker run --rm -it -v $(pwd):/pipplet -p 3000:3000 pipplet-interview bash
  ```

## API documentation

In order to communicate with the application, your request will need to follow the requirements given below:

In order to do dialog with the application on given API endpoint, here are some tools you can use:

Some applications that do the job:
- Postman (Chrome browser )
- RESTClient (Firefox browser )
- AdvancedRestClient (Linux Application)

You can also use 'curl', an unix package that can do http requests.

### Creating a new TestInstance

In order to create on new TestInstance you need to do a POST request on the following endpoint:

[DOMAIN NAME]/user/test_instances

#### HEADER

Header-name: Content-type
Header-value: Application/json

#### BODY

```json
{
  "user_id":,
  "language":
}
```

#### DOCUMENTATION

user_id: id of the user that will be associated to the test instance
language: language of the test instance

valid_input for language:
"en": english
"fr": french
"de": deutsch
"it": italian
"es": spanish
1: english
2: french
3: deutsch
4: deutsch
5: spanish

#### EXEMPLE WITH CURL

```bash
curl -X POST -H 'Content-Type: application/json' -i http://localhost:3000/user/test_instances --data '{ "user_id": 1, "language": 1 }'
```

#### HANDLED RESPONSE

HTTP 200: {"message":"test instance created"} -> The new test instance got succesfully created.
HTTP 422: {"message":"incorrect user id"} -> The user id is not of a test taker, or is unknown.
HTTP 422: {"message":"incorrect language"} -> The language is unknown.

### Retrieving all TestInstance of an user

In order to retrieve all TestInstance of an user you need to do a GET request on the following endpoint:

[DOMAIN NAME]/user/test_instances?user_id=

#### DOCUMENTATION

user_id: id of the user that will be associated to the test instance

#### EXEMPLE WITH CURL

```bash
curl -X GET -H 'Content-Type: application/json' -i 'http://localhost:3000/user/test_instances?user_id=1'
```

#### HANDLED RESPONSE

HTTP 422: {"message":"incorrect user id"} -> The user id is not of a test taker, or is unknown.

HTTP 200: { json data }
