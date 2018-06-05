#!/usr/bin/env ruby

input = nil
    until input.is_a?(Integer) do
        puts "ingresa numero : "
    begin input = Integer(gets)
    rescue ArgumentError
        puts "Error Solo numeros : #{$!}"
        input = nil
        end
    end

sticks = []
until sticks.any? do
    puts "ingresa sucesion : "
    begin sticks = gets.split.map(&:to_i)
    end
end
    

def cut(sticks)
    puts "Solucion" unless sticks.to_s.empty?
    while sticks.size >= 1
        p sticks.size
        min = sticks.min
        sticks.map!{|y| y-min}.select!{|z| z>0}
    end
end
puts cut(sticks)
