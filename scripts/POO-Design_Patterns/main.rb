require './participant'
require './participant_factory'
require './competition'


competition = Competition.instance
competition.name = "Competition 1"
begin
  competition.add_participant("amateur","17265389","ama1",29,11,0)
  competition.add_participant("amateur","172653892","ama2",29,67,0)
  competition.add_participant("professional","772653893","pro1",49,17,88,4)
  competition.add_participant("professional","762653893","pro2",39,15,90,6)
  competition.add_participant("professional","762653843","pro3",39,78,97,8)
  competition.add_participant("master","92653893","master1",59,10,0)
  competition.add_participant("master","92653893","master2",79,10,0)
  puts competition.list_participants
  puts competition.winner
  puts competition.winner_category
rescue ErrorPoint => e 
  puts "#{e.class}: #{e.message}"
end
