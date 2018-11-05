#encoding: UTF-8
require 'etc'
require 'json'

class FileException < StandardError
  attr_accessor :message
  def initialize(message)
    @message = message
  end
end

class ArgvException < StandardError; end

def _file(f)
  File.stat(f)
end

def filesize(size)
  units = %w(B KiB MiB GiB TiB Pib EiB)

  return '0.0 B' if size == 0
  exp = (Math.log(size) / Math.log(1024)).to_i
  exp = 6 if exp > 6

  '%.1f %s' % [size.to_f / 1024 ** exp, units[exp]]
end

def is_file_or_dir(f)
  case
  when File.file?(f)
    'file'
  when File.directory?(f)
    'directory'
  else
    raise FileException.new("#{f} is not file or directory")
  end
end

def parse_path(path)
  path = path.end_with?('/') ? path.slice(0..-2) : path
  is_file_or_dir(path) == 'directory' ? "#{path}/*" : path
end

def current_path(argv_path)    
  begin
    final_path = parse_path(argv_path)
    result = Dir.glob(final_path, File::FNM_DOTMATCH).sort.map do |f| 
      {
        name: "#{f}", 
        mtime: "#{_file(f).mtime}", 
        type: "#{is_file_or_dir(f)}",
        group: "#{Etc.getgrgid(_file(f).gid).name}", 
        owner: "#{Etc.getpwuid(_file(f).uid).name}", 
        size: "#{(filesize(File.size(f)))}"
      }
    end
    puts JSON.pretty_generate(result)
  rescue FileException => e
    puts "#{e.message}"
  end
end

begin
  case 
    when ARGV.length.eql?(1)
    current_path(ARGV[0])
    when ARGV.length > 1
    raise ArgvException, "Only one argument not #{ARGV.length}"
    else
      puts "Usage : #{$0} argv"
    end
rescue ArgvException => e
  puts "#{e.message}"
end

