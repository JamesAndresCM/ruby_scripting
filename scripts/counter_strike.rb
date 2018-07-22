#!/usr/bin/env ruby
class Player
	attr_accessor :nombre, :equipo, :cantidad ,:cantidad_eliminado

	def initialize(nombre, equipo,cantidad, cantidad_eliminado)
		@nombre = nombre
		@equipo = equipo
		@cantidad = cantidad
		@cantidad_eliminado = cantidad_eliminado
	end
end

class Equipo 
	attr_accessor :nombre_equipo

	def initialize(nombre_equipo)
		@nombre_equipo = nombre_equipo
	end
end

estudiante = Equipo.new("Estudiantes")
profesor = Equipo.new("Profesores")

jugadores = []

loop do
	puts %Q{Selecciona option:\n 1-Agregar Jugador\n 2-Ver jugadores\n 3-Salir}
	option = Integer(gets)
	case option
	when 1
		puts "Ingrese nombre jugador" 
		nombre = gets.to_s
		equipo = nil
		while ![1,2].include?(equipo)
			puts %Q{Equipo jugador: 1-Estudiante 2-Profesor\n}
			begin 
				equipo = Integer(gets)
			rescue Exception => e
				puts "solo numeros : #{e}"
					equipo = nil
				end
		end 
		equipo = equipo.eql?(1) ? "Estudiantes" : "Profesores"

		puts "Ingrese Cantidad Enemigos eliminados : "
		cantidad = gets.to_i
		
		puts "Ingrese Cantidad de Veces que fue eliminado jugador"
		cantidad_eliminado = gets.to_i
		jugadores << Player.new(nombre,equipo,cantidad, cantidad_eliminado)
	when 2
		victorias = []
		derrotas = []
		victoria_100 = []
		unless jugadores.empty?
			jugadores.map do |jugador|
				nombre = jugador.nombre
				equipo_jugador = jugador.equipo
				cantidad_victorias = jugador.cantidad
				derrotas_profesores = jugador.cantidad_eliminado
				if equipo_jugador.eql? "Estudiantes"
				 	victorias << cantidad_victorias
				end
				if equipo_jugador.eql? "Profesores"
					derrotas << derrotas_profesores
				end
				if cantidad_victorias.eql? 100
					victoria_100 << [nombre,cantidad_victorias,equipo_jugador]
				end
			end
			unless victorias.empty?
				promedio = victorias.sum / victorias.count
				puts "Promedio victorias equipo Estudiantes : #{promedio}"
			end
			puts "Derrotas equipo Profesores : #{derrotas.sum}" unless derrotas.empty?
			puts "Primer jugador en eliminar a 100 : #{victoria_100.first}" unless victoria_100.empty? 
		else
			puts "no hay jugadores aun"
		end
	when 3
		puts "saliendo.." 
		exit(0)
	else puts "opcion no valida"
	end
end
