### POC docker-rails

### Create some proyect (flag -d postgresql obligatory) in host (app container port 8080)
- `rails new test_docker -d postgresql`

### Copy these files to previous proyect
- `cp -r test_docker/* . && cp test_docker/.ruby-version .`

### Set variables
- Add or Remove Comments in `basename.sh` file, it's depends is your OS (Mac or Linux)
- execute: `bash basename.sh`

### Set ruby version
- `ruby -v`
- paste your result in top file (`docker/app/Dockerfile`): example `ruby:2.6.3`

### Setup
- `docker-compose build`
- `docker-compose up -d`

### Example scaffold
- `docker-compose run --rm app rails g scaffold Product title:string price:integer`

### Create db
- `docker-compose run --rm app rails db:create`

### Run migrate
- `docker-compose run --rm app rails db:migrate`

### Intstall new gem: 

- `docker-compose run --rm app bundle` 
- `docker-compose up --build -d`
- Restart container!
