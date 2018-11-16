class Participant

  attr_accessor :dni, :name, :age, :point_jury, :public_point

  def initialize(dni, name, age, point_jury, public_point)
    raise ErrorPoint , "Point_Jury no valid: #{point_jury}" if (point_jury < 0 || point_jury > 100)
    raise ErrorPoint , "Public_Point no valid: #{public_point}" if (public_point < 0 || public_point > 100)
    @dni, @name, @age, @point_jury, @public_point = dni, name, age, point_jury, public_point
  end

  def to_s
    "DNI : #{dni}, Name: #{name}, Age: #{age}, Point_Jury: #{point_jury}, Public_Point: #{public_point}"
  end

  def total_points
    ( point_jury * 0.7 + public_point * 0.3 ).round(2)
  end

end

class Amateur < Participant

  def initialize(dni, name, age, point_jury, public_point)
    super(dni, name, age, point_jury, public_point)
  end

  def to_s
    "#{super} Category: Amateur, Point: #{total_points}"
  end

end

class Professional < Participant

  attr_accessor :years_exp

  def initialize(dni, name, age, point_jury, public_point, years_exp)
    super(dni, name, age, point_jury, public_point)
    @years_exp = years_exp
  end

  def total_points
    years_exp > 10 ? super + 2 : super
  end

  def to_s
    "#{super} Category: Professional, Point: #{total_points} ,Years Exp: #{years_exp}"
  end

end

class Master < Participant

  def initialize(dni, name, age, point_jury, public_point)
    super(dni, name, age, point_jury, public_point)
  end

  def total_points
    point_jury
  end

  def to_s
    "#{super} Category: Master, Point: #{total_points}"
  end

end

class ErrorPoint < StandardError; end


