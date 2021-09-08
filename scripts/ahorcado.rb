words = %w[hola amor arroz]
continues = 0
word = words.sample.split('')
size = word.size
arr = size.times.map{ "X" }

arr[0] = word.first.capitalize
arr[size-1] = word.last.capitalize

puts "find the random word\n"
p arr
while continues != 3 do
puts "Entry value for random word: \n" 
value = gets.chomp

find_values = word.each_with_index.map{|e,i| i if e == value && (arr[0] != e.capitalize && arr[size-1] != e.capitalize)}.compact
if find_values.empty?
  continues = continues + 1
else  
  find_values.each do |el|
    arr[el] = value.capitalize
  end
end
  puts "word #{arr}"
  puts "continues #{3 - continues}"
  
  puts "the word was #{word.join.upcase}" if continues == 3
  break unless arr.include?("X")
end
#puts "word was #{word}"
