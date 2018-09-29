### Create some proyect (flag -d postgresql obligatory) in host (app container port 8080)
- `rails new test_docker -d postgresql`

### Copy these files to previous proyect
- `cp -r ....`

### Set variables
- `bash basename.sh`

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
