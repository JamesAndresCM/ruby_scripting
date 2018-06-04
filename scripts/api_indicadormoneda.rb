#!/usr/bin/env ruby

require "open-uri"
require "json"
require "date"
API_URL = "https://mindicador.cl/api"

begin
    data = JSON.parse(open(API_URL).read)
rescue Exception
    puts "Error al consultar api"
    exit
end
unless data.empty?
    data.each do |key,value|
        puts "Codigo : #{value["codigo"]} | Nombre : #{value["nombre"]} | Unidad de Medida : #{value["unidad_medida"]} | Fecha : #{Date.parse(value["fecha"]).strftime("%Y-%m-%d")} | Valor : #{value["valor"].to_s}" unless key =~ /version|autor|fecha/
    end
else
    puts "no hay datos..."
end
