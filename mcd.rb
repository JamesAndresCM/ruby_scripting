class MCDM 
	$numeros,$i = [],0

	def initialize
	end

	def cantidadElementos
		cantidad = nil
		until cantidad.is_a?(Integer) do
			puts "ingresa cantidad elementos"
			begin 
				cantidad = Integer(gets)
				while $i < cantidad 
					$i+=1
					valores = nil
					until valores.is_a?(Integer) do	
						puts "ingresa numero #{$i}" 
						begin
							valores = Integer(gets)
							$numeros << valores
						rescue Exception => e
							puts "solo numeros #{e}"
						end
					end
				end
				return $numeros
			rescue ArgumentError
				puts "solo numeros"
				cantidad = nil
			end
		end
	end

	def maximoComunDivisor
		$numeros = cantidadElementos
		begin 
			$numeros = $numeros.min,$numeros.max % $numeros.min 
		end while $numeros.min != 0
		puts "MCD : #{$numeros[0]}"
		#native ruby // $numeros.inject(:gcd) or $numeros.reduce(:gcd) 
	end

	def findMCDtwo(a,b)
		return b == 0 ? a : findMCDtwo(b,a % b)
	end

	def minimoComunMultiplo
		$numeros = cantidadElementos
		mcm = $numeros.reduce do |a, b|
    		return 0 if a.eql?(0)
    		(a * b) / findMCDtwo(a, b)
  		end
		puts "MCM : #{mcm}"
		#native ruby  // $numeros.inject(:lcm) or $numeros.reduce(:lcm)
	end

end

obj = MCDM.new()

option = nil
until option.is_a?(Integer) do
	puts %Q{Selecciona option:\n 1-MCD\n 2-MCM\n}
	begin 
		option = Integer(gets)
		case option
		when 1
			obj.maximoComunDivisor
		when 2
			obj.minimoComunMultiplo
		else
			puts "opcion no valida, saliendo"
			exit(1)
		end
	rescue Exception => e
		puts "solo numeros : #{e}"
 		option = nil
	end
end

