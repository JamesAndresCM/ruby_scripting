# encoding: UTF-8

def convert(n, char)
  n.times.map do |t| 
    ( " " * ( n - t - 1 ) ) + ( char * ( t * 2 + 1) )
  end
end

begin
  puts "Enter size pyramid : (Size must be greater than 1)"
  number = gets.chomp.to_i 
end while number <= 1 

puts "Enter char for pyramid : "
char = gets.chomp[0]

puts "result\n", convert(number,char)
