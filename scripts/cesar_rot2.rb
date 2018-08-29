#cifrado césar rot2
def convert(n)
	data = Array.new
	letters = ('a'..'z').to_a
	value = n.downcase.delete(', ').split('')
	abort("#{value.join} error solo letras") unless value.join =~ /^[a-z]+$/
	value.each do |pos| 
		if pos.eql? 'z'
			pos='a'
			res=letters.index(pos) + 1
		elsif pos.eql? 'y'
			pos='a'
			res=letters.index(pos)
		else  
			res=letters.index(pos) + 2
		end 
		res_final=letters[res]
		data << res_final
	end
	{input: n, output: data.join}
end
puts convert('Carmelo')
puts convert('Casa')
puts convert('WIKIPEDIA, LA ENCICLOPEDIA LIBRE')
puts convert('Cas5')
