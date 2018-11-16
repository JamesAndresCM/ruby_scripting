require 'singleton'
class Competition

  include Singleton

  attr_accessor :name, :participants

  def initialize
    @name = nil
    @participants = []
  end

  def add_participant(category, dni, name, age, point_jury, public_point, years_exp = nil)
    participants << ParticipantFactory.create_participant(category, dni, name, age, point_jury, public_point, years_exp)
  end

  def list_participants
    message = "** Competition #{name} **\n"
    message += "** List of Participants **\n"
    
    @participants.each do |participant|
      message += "#{participant.to_s} **\n"
    end
    message += "Total Participants #{participants.size}\n"
  end

  def winner
    point = 0
    win = nil
    message = "Winner : \n"
    @participants.each do |participant|
      point , win = participant.total_points, participant if participant.total_points > point
    end
    message += "#{win.name}, TotalPoint : #{point}"
  end

  def winner_category
    amateur_category = 0
    professional_category = 0
    master_category = 0

    win_amateur = nil
    win_pro = nil
    win_master = nil
    
    message = "Winners per category : \n"

    @participants.each do |participant|
      case participant.class.to_s
      when "Amateur"
        amateur_category, win_amateur = participant.total_points, participant if participant.total_points > amateur_category
      when "Professional"
        professional_category, win_pro = participant.total_points, participant if participant.total_points > professional_category
      when "Master"
        master_category, win_master = participant.total_points, participant if participant.total_points > master_category
      end
    end
    message += " Amateur : Name #{win_amateur.name} Points: #{amateur_category}\n"
    message += " Professional : Name #{win_pro.name} Points: #{professional_category}\n"
    message += " Master : Name #{win_master.name} Points: #{master_category}\n"
  end
end