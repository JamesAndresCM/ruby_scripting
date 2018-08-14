#!/usr/bin/env ruby
require 'date'
# creo la clase factura
class Factura
	# accesadores de factura
	attr_accessor :nombre, :fecha ,:cliente, :deudor, :estado

	# inicializacion
	def initialize(nombre,fecha, cliente, deudor, estado)
		@nombre = nombre
		@fecha = fecha
		@cliente = cliente
		@deudor = deudor
		@estado = estado
	end
end

# creo la clase persona
class Persona
	# accesadores persona
	attr_accessor :nombre, :apellido, :grupo
	def initialize(nombre, apellido, grupo)
		@nombre = nombre
		@apellido = apellido
		@grupo = grupo
	end
end

# clase cliente hereda de persona
class Cliente < Persona; end

# clase deudor hereda de persona
class Deudor < Persona; end

# declaro constante para "grupos"
GRUPOS = ["grupo1","grupo2","grupo3","grupo4","grupo5","grupo6"]

# declaro constante estado_factura (¿boolean?)
STATUS_FACTURA = ["aceptada","rechazada"]


# declaro arreglos clientes_deudores y facturas
clientes_deudores = []
facturas = []


# creo 30 clientes y 30 deudores, luego los meto en el array declarado previamente, con "grupos" randoms para c/u
30.times do |x|
	cliente = Cliente.new("cliente numero#{x}","cliente apellido#{x}",GRUPOS.sample)
	deudor = Deudor.new("deudor numero#{x}","deudor apellido#{x}",GRUPOS.sample)
	clientes_deudores << [cliente,deudor]
end

# declaro contador para nombre factura
n = 0

# recorro arreglo cliente_deudores
clientes_deudores.each do |cl_de|
	# genero fecha aleaotoria entre un rango
	fecha = rand(Date.civil(2018, 1, 1)..Date.civil(2018, 12, 31))
	n +=1	
	cliente = cl_de[0]
	deudor = cl_de[1]
	# creo un arreglo de facturas introduzco datos de cliente, deudor, fecha y status de forma al azar
	facturas << Factura.new("factura numero#{n}",fecha,cliente,deudor,STATUS_FACTURA.sample)
end

cantidad_facturas_aceptadas = 0
# recorro array de facturas
facturas.each do |factura|
	nombre = factura.nombre
	fecha = factura.fecha
	cliente = factura.cliente
	deudor = factura.deudor
	estado = factura.estado
	# pregunto si estado de factura es aceptada, luego incremento el contador
	if estado.eql? "aceptada"
		cantidad_facturas_aceptadas +=1
		puts "Nombre factura : #{nombre} | fecha : #{fecha} | cliente : #{cliente.nombre} -- #{cliente.grupo} | deudor : #{deudor.nombre} -- #{deudor.grupo} | estado : #{estado}"
	end
end

# imprimo numero total de facturas (definido en iterador times)
puts "total facturas : #{facturas.count}"
# imprimo total facturas aceptadas
puts "facturas aceptadas : #{cantidad_facturas_aceptadas}" unless cantidad_facturas_aceptadas.nil?

# variable aceptacion : en base divido cantidad de facturas aceptadas por el total
aceptacion = ((cantidad_facturas_aceptadas.to_f / facturas.count) * 100).to_i

# imprimo porcentaje de aceptacion de una factura en relacion a las aceptadas durante un rango de tiempo X y cantidad X
puts "probabilidad aceptacion : #{aceptacion}%" unless aceptacion.nil?

