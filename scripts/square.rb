def draw_square(n,char)
  (1..n).to_a.map do |x| 
    final = (x == 1 || x == (n) ? (char * n) : (char + " " * (n - 2) + char))
    final.gsub(/(?<=[*])?/, ' ').strip
  end
end

begin 
  puts "Enter size Square"
  square_size = gets.chomp.to_i
end while square_size < 1

puts "Enter Char to Draw Square"
char = gets.chomp[0]

puts draw_square(square_size, char)
