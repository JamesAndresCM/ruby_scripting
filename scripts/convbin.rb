#!/usr/bin/env ruby

opcion = nil

while ![1,2].include?(opcion)
        puts %Q{
        1-Decimal a binario
        2-Octal a decimal
        ingresa tu opcion
        }
opcion = gets.chomp.to_i
end


def convert(opcion)
	numero = nil
	if opcion == 1
	until numero.is_a?(Integer) do
        	puts "ingresa numero"
			begin
				numero = Integer(gets)
			rescue ArgumentError	
				numero = nil
			end	

		end
	if numero == 0 then 0 end
	a = ""
	until numero == 0
		a = String(numero % 2 ) + a
		numero = numero / 2
	end
	puts a
	else opcion == 2
		while ! numero.is_a?(Integer) do
			puts "ingresa numero"
			begin
				numero = Integer(gets)
			rescue ArgumentError
				numero = nil
			end
		end
		b = 0
		c = 1
		until numero == 0
			a = numero % 10
			numero /= 10
			b += a * c
			c *=8
		end
		puts b

	end
end


convert(opcion)

