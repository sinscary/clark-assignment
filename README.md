# README

####### Decisions taken
* I have used data mapper design pattern to create a mapping between user and rewards
* I have used services for the logic
* As I love TDD, I have added some unit and integration tests
* Below is the project structure explaining what every service does

### Project Structure
* I have divided all the component into their separate service
* As we are accepting a file there is a Parsing service which reads the data and cleans it
* Once we have cleaned data ValidationService runs for the validation
* There is a user service to build user nodes
* There is a mapper service to map user nodes with user object and updates if user accepts
* Once we have user rewards mapper rewards service calculates the rewards for each user
* Once rewards is done Response Builder builds and returns the response

#### Requirements
```
Ruby version 2.6.0
Rails version 5.2.3
```

#### Running the application
Once you are done with bundle install execute below command to run application
`bundle exec rails s`

* Once rails server is up and running hit `/process_rewards` API which accepts
a text file containing the data. below is a example curl request.

```
curl -F 'data=@/path/to/data.txt' http://localhost:3000/process_rewards
```

* To run unit tests, execute below command
`bundle exec rake test`
* ...

