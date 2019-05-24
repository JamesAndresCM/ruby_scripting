
class Rut
  attr_accessor :dv
  MOD_DV = 11
  class FailFormat < StandardError; end
  
  def initialize(dv)
    is_valid?(dv)
    @dv = dv
  end
    

  def calc_dv_rut
    input = self.dv.to_s.split('')  
    i = 1
    j = 1
    
    total_sum = []
    
    input.reverse!.each do |n|
      i+=1 
      if i < 8
        total_sum << n.to_i * i
      else
        j+=1
        total_sum << n.to_i * j 
      end
    end
    res = (MOD_DV - (total_sum.sum % MOD_DV))
    dv_format_ouptut(res,input)
  end

  private 

  def is_valid?(dv)
    raise FailFormat, 'Error only numbers' unless dv.is_a?(Integer)
    raise FailFormat, 'Error not valid size digits' unless dv.digits.size.between?(7,8)
  end

  def dv_format_ouptut(res,input)
    case res
    when 11
      res = 0
    when 10
      res = 'k'
    else
      res
    end
    "#{input.reverse.join('')}-#{res}"
  end

end
rut = Rut.new(17156101)
p rut.dv
p rut.calc_dv_rut

