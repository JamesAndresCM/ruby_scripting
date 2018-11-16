class ParticipantFactory

  def self.create_participant(category, dni, name, age, point_jury, public_point, years_exp = nil)
    
    case category
    when "amateur"
      Amateur.new(dni, name, age, point_jury, public_point)
    when "professional"
      Professional.new(dni, name, age, point_jury, public_point, years_exp)
    when "master"
      Master.new(dni, name, age, point_jury, public_point)
    end
      
  end
end
