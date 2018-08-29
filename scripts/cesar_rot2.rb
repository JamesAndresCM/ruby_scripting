#cifrado césar rot2
def convert(n)
data = Array.new
abecedario = ('a'..'z').to_a
	value = n.downcase.delete(', ').split("")
  abort("#{value.join} error solo letras") unless value.join() =~ /^[a-z]+$/
	value.each do |pos| 
		if pos.eql? "z" 
		  pos="a" 
    	res=abecedario.index(pos) + 1 
		elsif pos.eql? "y" 
			pos="a" 
 		  res=abecedario.index(pos) 
		else  
		  res=abecedario.index(pos) + 2 
		end 
		res_final=abecedario[res] 
    data << res_final
	end
  final = {input: n, output: data.join}
end
puts convert("Carmelo")
puts convert("Casa")
puts convert("WIKIPEDIA, LA ENCICLOPEDIA LIBRE")
puts convert("Cas5")
