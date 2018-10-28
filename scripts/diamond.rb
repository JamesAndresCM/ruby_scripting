
def draw_diamond(n, char)
  (1..n).to_a.map do |res|
    case 
    when res == 1 || res == n
      " " * ( n - 2 ) + char
    when res <= n / 2 + 1
      " " * ( n - res - 1) + char +  " " * ( res * 2 - 3 ) + char
    when res <= n - 1
      " " * ( res - 2 ) + char + ("  ") * (n - res - 1 ) + " " + char
    end
  end
end

begin
  puts "Entry size of diamond : (only odd number)"
  number = gets.chomp.to_i
end while number <= 1 or number.even?

puts "Entry Char to draw diamond"
char = gets.chomp[0]

puts "result\n", draw_diamond(number,char)
