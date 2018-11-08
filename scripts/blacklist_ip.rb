require 'resolv'
require 'optparse'

class IpError < StandardError; end

class IsValidIP
  def valid_ip?(ip_address)
    result = !!(ip_address =~ Regexp.union([Resolv::IPv4::Regex, Resolv::IPv6::Regex]))
    raise IpError, "#{ip_address} not valid ip" if result.eql? false
  end
end
class BlacklistIp
  attr_accessor :ip_address

  def check_ip(ip_address)
    @ip_address = ip_address
    begin
      check_valid = IsValidIP.new
      check_valid.valid_ip?(ip_address)
      check_centrals(ip_address)  
    rescue IpError => e
      puts "#{e.message}"
    end     
  end
  
  def centrals
    %w[
      b.barracudacentral.org
      bl.spamcop.net
      cbl.abuseat.org
      dnsbl.sorbs.net
      spam.dnsbl.sorbs.net
      spam.spamrats.com
      zen.spamhaus.org
      bl.spamcannibal.org
      smtp.dnsbl.sorbs.net
      spam.dnsbl.sorbs.net
    ]
  end

  private 

  def check_centrals(ip_address)
    listed = []
    ip_address = ip_address.split('.').reverse.join('.')
    begin
    centrals.each do |central|
      host = "#{ip_address}.#{central}"
      Resolv::getaddress(host)
      listed << central
      rescue => e
        e
        #puts "ip_address: #{ip_address} in central: #{central} is "+"\e[32mOK\e[0m"
      end
    end
    listed.size > 0 ? listed : "#{@ip_address} is OK"
  end
end


blacklist = BlacklistIp.new
centrals = blacklist.centrals

ARGV << '-h' if ARGV.empty?

options = {}

optparse = OptionParser.new do |opts|
  opts.banner = "Usage: #{File.basename($0)} [options]\nExample: #{File.basename($0)} --ip_address=192.168.X.X"

  opts.on('--ip_address IP', 'Check ip') do |ip|
    options[:ip_address] = ip
    if options[:ip_address].empty?
      puts optparse
      puts "\e[31mParam --ip_address is required\e[0m"
      exit
    end
  end

  opts.on('-c','--centrals', 'Show centrals') do |c|
    options[:c] = c
    puts "Centrals :",centrals.join(' | ') if options[:c]
    exit
  end
end

begin
  optparse.parse!
  if options[:ip_address]
    response = blacklist.check_ip(options[:ip_address])
    if response.is_a? Array
      puts "Ip address: #{options[:ip_address]} is blacklisted in :"
      puts response.join("\n")
    else
      puts response
    end
  else
    puts optparse
    exit
  end
  rescue StandardError => error
    puts error
    puts optparse
    exit 2
end


