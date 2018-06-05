#!/usr/bin/env ruby

file="/etc/passwd"
user_home = []
no_login = []
begin
    a = File.open(file,"r")
    total=0
    a.each do |line| 
        total+=1;
        users = line.split(":") 
        user_home<<users[0] if users[5].match("^/home")
        no_login<<users[0] if users[6] =~ /nologin|false/
    end
    a.close
    puts "Total Users : #{total}"
    puts "Normal Users : #{user_home}"
    puts "Users without login: #{no_login.sort()}"
rescue
    puts "Error! #{$!}"
end



