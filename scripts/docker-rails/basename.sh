#!/bin/bash - 

dir=$(basename "$PWD")

# OSX
sed -i '' 's/rails_app_dir/'$dir'/g' docker/web/app.conf
sed -i '' 's/rails_app_dir/'$dir'/g' docker/web/Dockerfile
sed -i '' 's/web_server/web_server_'$dir'/' docker-compose.yml
sed -i '' 's/app_rails/app_'$dir'/' docker-compose.yml
sed -i '' 's/rails_db/rails_db_'$dir'/' docker-compose.yml
sed -i '' 's/.*encoding.*/&\'$'\n  host: db/' config/database.yml
sed -i '' 's/.*host: db.*/&\'$'\n  username: postgres/' config/database.yml

# GNU/LINUX
#sed -i 's/rails_app_dir/'$dir'/g' docker/web/app.conf
#sed -i 's/rails_app_dir/'$dir'/g' docker/web/Dockerfile
#sed -i 's/web_server/web_server_'$dir'/' docker-compose.yml
#sed -i 's/app_rails/app_'$dir'/' docker-compose.yml
#sed -i 's/rails_db/rails_db_'$dir'/' docker-compose.yml
#sed -i 's/.*encoding.*/&\n\  host: db/' config/database.yml
#sed -i 's/.*host: db.*/\  username: postgres/' config/database.yml
