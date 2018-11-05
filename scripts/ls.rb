#encoding: UTF-8

require 'etc'
require 'json'


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
  puts "#{f} is not file or directory"
  exit
  end
end

def parse_path(path)
  path = path.end_with?('/') ? path.slice(0..-2) : path
  is_file_or_dir(path) == 'directory' ? "#{path}/*" : path
end

def current_path(argv_path)    
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
    JSON.pretty_generate(result)
end

case 
  when ARGV.length.eql?(1)
  puts current_path(ARGV[0])
  when ARGV.length > 1
  puts "Only one argument... not #{ARGV.length}"
  else
  puts "Usage : #{$0} argv"
end

