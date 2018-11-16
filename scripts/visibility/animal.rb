class Animal
  
  def talk
    "im animal"
  end

  def age
    animal_age
  end

  def color
    animal_color
  end

  protected
  def animal_color
    "black"
  end

  private
  def animal_age
    rand(10)
  end
end

class Dog < Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def color
    self.animal_color
  end
end

a = Animal.new
p a.age
p a.talk
p a.color 
p "*" * 10
d = Dog.new("dog")
p d.name
p d.age
p d.color
