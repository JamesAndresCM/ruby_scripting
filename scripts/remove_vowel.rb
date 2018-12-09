require 'optparse'

class String
  def remove_vowel_1
    #uso de metodo delete (mas eficiente)
    self.downcase.delete(vowels.join).reverse
  end

  # uso de metodo delete_if en array ,se recibe el string se transforma a downcase-split y luego se pregunta si existen vocales 
  # y se eliminan, luego se une la cadena y se incluye el reverse 
  def remove_vowel_2
    self.downcase.split('').delete_if do |v| 
      vowels.include?(v) 
    end.join.reverse
  end

  # uso de array que almacena cuando no es una vocal
  def remove_vowel_3
    temp = []
    self.downcase.split('').each{|v| temp << v unless vowels.include?(v) }
    temp.join.reverse
  end

  # uso de metodo chars y map 
  def remove_vowel_4
    self.downcase.chars.map{|v| v unless vowels.include?(v) }.join.reverse
  end

  # metodo "manual" se utiliza array temporal para guardar caracteres cuando no son vocales
  # se utiliza un ciclo while para consultar por el largo de la cadena, luego con el ciclo unless se revisa si no existen vocales y se insertan en el array
  def remove_vowel_5
    temp = []
    string_vowel = self.downcase.chars
    
    i = 0
    while i < string_vowel.size
      unless vowels.include?(string_vowel[i])
        temp << string_vowel[i]
      end
      i+=1
    end
    temp.join.reverse
  end

  # colorize I/O entrada salida de cadena
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  private
  
  def vowels
    %w(a e i o u)
  end
end

# DISCLAIMER: se ha utilizado la extension de la clase String como buena practica, de lo contrario bastaría con validar la entrada 
# de la cadena con "cadena".is_a?(String), se han diseñado 5 soluciones posibles, no se hablaba en el enunciado acerca de los espacios
# pero bastaria con agregar un "cadena".delete(' ') para su cometido.

ARGV << '-h' if ARGV.empty?

options = {}

optparse = OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename($0)} [options]\nExample: #{File.basename($0)} --word=hello"

  opts.on('--word WORD', 'remove vowels') do |te|
    options[:word] = te
    if options[:word].empty?
      puts optparse
      puts 'Param --word is required'
      exit
    end
  end
  opts.on( '-h', '--help', 'Display this screen' ){ puts opts; exit }
end

begin
  optparse.parse!
  if options[:word]
    puts "\nInput: #{options[:word].downcase.green}"
    puts "\nOutput: 1-Solution #{options[:word].remove_vowel_1.red}"
    puts "\nOutput: 2-Solution #{options[:word].remove_vowel_2.red}"
    puts "\nOutput: 3-Solution #{options[:word].remove_vowel_3.red}"
    puts "\nOutput: 4-Solution #{options[:word].remove_vowel_4.red}"
    puts "\nOutput: 5-Solution #{options[:word].remove_vowel_5.red}"
  else
    puts optparse
    exit
  end
  rescue StandardError => error
    puts error
    puts optparse
    exit 2
end




