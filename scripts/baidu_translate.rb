require 'net/http'
require 'uri'
require 'json'

module SaltAuth
  require 'digest/md5'
  def auth(app_id, query, salt,secret_key)
    sign = "#{app_id}#{query}#{(salt.to_s)}#{secret_key}"
    Digest::MD5.hexdigest(sign)
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
    %i[zh en yue wyw jp kor fra spa th ara ru pt de it el nl pl bul est dan fin cs rom slo swe hu cht]
  end

  private

  def send_post
    salt = rand(10000..50000)
    sign = auth(app_id, query, salt, secret_key)
    uri = URI.parse("#{API_URL}?appid=#{app_id}&q=#{query}&from=#{from}&to=#{to}&salt=#{salt}&sign=#{sign}")
    response = Net::HTTP.get_response(uri).body

    error = JSON.parse(response)["error_code"]
    if error == '54001' || error == '52003'
      raise AuthError, 'Error Auth'
    else
      JSON.parse(response)["trans_result"][0]["dst"]
    end
  end
end

#Get your app_id!! http://api.fanyi.baidu.com/api/trans/product/index

# Usage
=begin
a = BaiduTranslate.new(your_app_id,your_secret_key)
p "Langs : #{a.language_args}"
puts a.translate
puts "\nConvert Auto to english"
puts a.translate("spa","en","auto")
=end
  
   

