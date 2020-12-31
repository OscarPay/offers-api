# RoR technical assignment

## Steps to run the project

### Install and run postgres

- ```docker run -p 5432:5432 --name postgres -e POSTGRES_PASSWORD=postgres -d postgres```
- ```docker start postgres```

### Prepare the seeds

- ``` bundle exec rails db:create ```
- ``` bundle exec rails db:migrate ```
- ``` bundle exec rails db:seed ```

### Run the server

- ``` bundle exec rails s ```

### Test offers endpoint

- ``` http://localhost:3000/offers/search ```