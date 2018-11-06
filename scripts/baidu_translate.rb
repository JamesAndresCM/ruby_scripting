require 'net/http'
require 'uri'
require 'json'
require 'optparse'

module SaltAuth
  require 'digest/md5'
  def auth(app_id, query, salt,secret_key)
    sign = "#{app_id}#{query}#{(salt.to_s)}#{secret_key}"
    Digest::MD5.hexdigest(sign)
  end
end

class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m"
  end

  def red
    colorize(31)
  end
end

class AuthError < StandardError; end

class BaiduTranslate
  include SaltAuth
  attr_accessor :query, :from, :to, :app_id, :secret_key
  API_URL = 'https://api.fanyi.baidu.com/api/trans/vip/translate'

  def initialize(app_id, secret_key)
    @app_id = app_id
    @secret_key = secret_key
  end

  def translate(from="en", to="spa", query="hello world")
    @from = from
    @to = to
    @query = query
    begin
      send_post
    rescue AuthError => e
      puts "#{e}"
    end
  end

  def language_args
    %w[zh en yue wyw jp kor fra spa th ara ru pt de it el nl pl bul est dan fin cs rom slo swe hu cht]
  end

  private

  def send_post
    salt = rand(10000..50000)
    sign = auth(app_id, query, salt, secret_key)
    uri = URI.parse("#{API_URL}?appid=#{app_id}&q=#{query}&from=#{from}&to=#{to}&salt=#{salt}&sign=#{sign}")
    response = Net::HTTP.get_response(uri).body

    error = JSON.parse(response)["error_code"]
    if error == '54001' || error == '52003'
      raise AuthError, 'Error Auth API BAIDU'.red
    else
      JSON.parse(response)["trans_result"][0]["dst"]
    end
  end
end

#Get your app_id!! http://api.fanyi.baidu.com/api/trans/product/index

translator = BaiduTranslate.new(your_app_id,your_secret_key)
langs = translator.language_args

#if args empty show -h
ARGV << '-h' if ARGV.empty?

options = {}

optparse = OptionParser.new do |opts|
  opts.banner = "Usage: #{$0} [options]\nExample: #{$0} --from=en --to=spa --text=hello"

  opts.on('--from LANG', 'From Lang') do |f|
    options[:from] = f
    if options[:from].empty?
      puts optparse
      puts 'Param --from is required'.red
      exit
    elsif !langs.include?(options[:from])
      puts optparse
      puts "from: #{options[:from].red} not valid language"
      exit
    end
  end

  opts.on('--to LANG','Select Lang') do |t|
    options[:to] = t
    if options[:to].empty?
      puts optparse
      puts 'Param --to is required'.red
      exit
    elsif !langs.include?(options[:to])
      puts optparse
      puts "to: #{options[:to].red} not valid language"
      exit
    end
  end
  opts.on('--text TEXT', 'Text to translate') do |te|
    options[:text] = te
    if options[:text].empty?
      puts optparse
      puts 'Param --text is required'.red
      exit
    end
  end
  opts.on('-l','--lang', 'Display langs') do |l|
    options[:lang] = l
    puts optparse
    puts "\nLangs :",langs.join(' ') if options[:lang]
    exit
  end
  opts.on( '-h', '--help', 'Display this screen' ){ puts opts; exit }
end

begin
  optparse.parse!
  if options[:from] and options[:to] and options[:text]
    puts "\nText: #{options[:text]}\nFrom: #{options[:from].capitalize}\nTo: #{options[:to].capitalize}\n\nTranslate :#{translator.translate(options[:from],options[:to],options[:text])}"
  else
    puts optparse
    exit
  end
  rescue StandardError => error
    puts error
    puts optparse
    exit 2
end

