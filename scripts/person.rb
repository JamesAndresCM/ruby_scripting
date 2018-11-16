require 'json'
class Person
  PEOPLE = []
  @@total = 0
  attr_accessor :name, :hobbies, :friends

  def initialize(name)
    @name = name
    @hobbies = []
    @friends = []
    PEOPLE << self
    @@total+=1
  end

  def has_hobbies(hobby)
    @hobbies << hobby
  end

  def has_friends(friend)
    @friends << friend
  end
  
  def all_person
    PEOPLE.map do |p|
      JSON.pretty_generate(Hash.[](
        name: p.name,
        hobbies: p.hobbies,
        friends: p.friends
      ))
    end unless PEOPLE.size.zero?
  end

  def count
    @@total
  end
end

p = Person.new("james")
p.has_hobbies("play")
p.has_friends("none")

z = Person.new("andres")
z.has_friends("nameless")
z.has_hobbies(["read","play"])

p "total : #{p.count}"
puts p.all_person
