#!/usr/bin/env ruby
require 'mathn' #lib prime

numeros = [23,12,34,1,234,4,7,19,11]
puts "numeros : #{numeros}\n\n"

mayor = numeros[0]
menor = numeros[0]

numeros.each do |x| 
    mayor = x if x > mayor 
    menor = x if x < menor 
end

puts "numero mayor #{mayor}"
puts "numero menor #{menor}"

#native ruby
puts "\nnative enumerable ruby"
puts "numero mayor #{numeros.max}"
puts "numero menor #{numeros.min}"

primos = []
numeros.each do |x|
    n = 0
    (1..x).each do |y|
        n+=1 if x % y == 0
    end
    primos << x if n == 2
end
puts "\nPrimos de #{numeros}\n\n"
primos.each{|primo| puts "numero #{primo} es primo" }

#native ruby

puts "\nNative Ruby lib mathn"
numeros.each do |primo| 
    puts "numero #{primo} es primo " if primo.prime?
end

puts "\nprimos entre 1-10"
Prime.each do |primo| 
    puts "numero #{primo} es primo"
    break unless primo < 10 
end

