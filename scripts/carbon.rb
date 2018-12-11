#encoding: UTF-8
require 'json'
require 'uri'

class FileException < StandardError
  attr_accessor :message
  def initialize(message)
    @message = message
  end
end

class ArgvException < StandardError; end

def is_file(f)
  File.file?(f) ? f : (raise FileException.new("#{f} is not file"))
end

def read_file(f)
  text = ""
  if File.empty?(f)
    puts "#{f} is empty!.."
    exit
  else
    File.open(f,"r").each_line do |line|
      text += line
    end
  end
  text
end

def open_url(code)
  url = "https://carbon.now.sh/?bg=rgba(171%2C%20184%2C%20195%2C%201)&t=seti&wt=none&l=auto&ds=true&dsyoff=20px&dsblur=68px&wc=true&wa=true&pv=48px&ph=32px&ln=false&fm=Hack&fs=14px&lh=133%25&si=false&code=#{code}&es=2x&wm=false"
  `open -a "Google Chrome" "#{url}"`
end

begin
  case
    when ARGV.length.eql?(1)
    begin
      file = is_file(ARGV[0])
      code = URI::encode(read_file(file))
      open_url(code)
    rescue FileException => e
      puts "#{e.message}"
    end
    when ARGV.length > 1
    raise ArgvException, "Only one argument not #{ARGV.length}"
    else
      puts "Usage : #{$0} argv"
    end
rescue ArgvException => e
  puts "#{e.message}"
end
