# Pokemon API
**Small Door Veterinary Test Ruby backend**

### Overview

The Pokemon TCG API is a RESTful service that allows evaluating the quality of the code.

The purpose of this application is to connect an APIRestful and get a list of pokemons cards.

## Requirements

* The project is developed as a REST API.
* Data should be stored in a relational database (either MySQL or Postgres)
* A deck should contain exactly 60 cards
* 12-16 pokemon of a given type
* 10 energy cards for that type
* The rest of the cards should be random trainer cards where no more than 4 cards of the same kind can be repeated

### Constraints

1. To initialize the project, use the following command:

```bash
  rails new pokemon_tcg_api --api -d postgresql -T
```

## Technologies

The following technologies are used in this project:

||Version|Command for checking
|-|-:|-|
|ruby|3.2.3|ruby --version|
|rails|7.1.3.2|rails --version|
|postgresql|16.2-1.pgdg120+2|postgres --version|
|elasticsearch|7.15.2||

## Deployment

To deploy the application, follow these steps:

1. Install dependencies:

```bash
  bundle install
```

3. Run migrations:

```bash
  bin/rails db:migrate; RAILS_ENV=test bin/rails db:migrate
```

4. Run seeders:

```bash
  bin/rails db:seed
```

5. Start the server:

```bash
  bin/rails serve
```

## API Reference

To access the API documentation, perform the following steps:

1. Retrieve the documentation:

```bash
curl  -X GET \
  'localhost:3000/api/docs' \
  --header 'Accept: */*'
```

2. Copy the content and visualize it using [Swagger Editor](https://editor.swagger.io/)

## Running Tests

Execute the following command to run the tests:

```bash
   bundle exec rspec spec/
```

## Solution Approach

The solution for building the Pokemons TCG API involves the following steps:

1. **Choosing the Framework:** We opted to use the Grape framework for building our RESTful API. Grape provides a lightweight and flexible approach to define API endpoints and manage request handling.

2. **Entity Serialization:** To ensure clean and structured responses from our API, we use Grape Entity for entity serialization. This allows us to define the structure of our API responses in a clear and organized manner.

3. **Documentation Generation:** We integrate Grape Swagger and Grape Swagger Entity to automatically generate Swagger-compliant documentation for our API. This ensures that our API endpoints are well-documented and easy to explore.

4. **Testing Strategy:** We employ RSpec and related gems for behavior-driven development (BDD) and testing. RSpec Rails provides a robust framework for testing Rails applications, while Rack Test allows us to test Rack applications with a simple API. Additionally, we use RSpec JSON Expectations for validating JSON responses in our tests.

5. **Code Quality:** To maintain code quality and adherence to best practices, we utilize RuboCop, a linter for Ruby code. RuboCop helps us enforce consistent coding styles and identify potential issues in our codebase.

6. **Service Objects:** The core functionality of the system is organized using the concept of service objects. The service objects responsible for retrieving pokemon cards data and processing it reside in the `app/services/pokemon` directory. This approach promotes encapsulation and modularity, making our codebase easier to understand and maintain.

7. **Implementation of Data Retrieval Solutions:** Regarding the extraction of data from the External API, we implemented two solutions. For downloading Pokemon types data and optimizing the rate limit, we implemented Redis as a cache for the extracted data. In relation to retrieving cards, we implemented Elasticsearch for handling the data.

8. **Job Implementation:** Due to the constraints of the External API, which has a volume of 17,000 registered cards and enforces a maximum of 250 records per page, we implemented the `app/jobs/pokemon_cards_indexer_job` to download data concurrently. This way, when creating a random deck under the given conditions, all the information is already available on the Elasticsearch server.

## Installed Gems

The following gems are installed for the project:

- `byebug`: Debugging tool for Ruby.
- `chewy`: ODM (Object Document Mapper) to integrate Elasticsearch with Rails
- `dotenv-rails`: Loads environment variables from a .env file into ENV when the Rails app initializes.
- `elasticsearch`: Integrates Elasticsearch with Rails
- `factory_bot_rails`: Provides support for defining and using factories in RSpec tests
- `faker`: Generates fake data for testing purposes
- `grape`: REST-like API framework for Ruby
- `grape-entity`: Entity serialization for Grape APIs
- `grape-swagger`: Adds swagger compliant documentation to your Grape API
- `grape-swagger-entity`: Swagger documentation for Grape entities
- `rack-test`: Add the 'rack/test' gem for testing Rack applications with a simple API.
- `rspec-json_expectations`: Integrate 'rspec/json_expectations' gem for additional JSON-related expectations in RSpec.
- `rspec-rails`: Behavior-driven development for Ruby on Rails applications
- `rubocop`: Linter for Ruby code
- `shoulda-matchers`: Simple one-liner tests for common Rails functionality
- `sidekiq`: Background processing for Ruby.
