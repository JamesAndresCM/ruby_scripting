#!/usr/bin/env ruby

numeros = ARGV.shift

#sin recursividad
fib = Hash.new{|k,v| k[v] = v <= 1 ? v : k[v-1] + k[v-2]}
puts numeros =~ /^[a-zA-Z]+$/ ? "Error solo numeros" : numeros.nil? ? "Usage #{$0} number example: #{$0} 10" : "total : %s" % (fib[numeros.to_i])

#con recursividad
def fibonacci(n) return n <=1 ? n : fibonacci(n-1) + fibonacci(n-2) end

i = 0
(1..numeros.to_i).map{|x| i+=1; puts "indice : #{i} value : %s" % (fibonacci(x)) }
