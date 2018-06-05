#!/usr/bin/env ruby

#the quick brown fox jumps over the lazy DOG
puts "ingrese frase "; argumento = gets.chomp.downcase.split(/ ?/).sort.uniq.join; puts "si es pangrama #{argumento}" if argumento == ("a".."z").to_a.join
