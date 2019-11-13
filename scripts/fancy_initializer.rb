class Pet
  @@life = 60
  # or only call class var using @@life instead life_val
  class << self
    def life_val
      @@life
    end
  end

  attr_accessor :health, :legs

  def initialize
    yield self if block_given?
  end

  def current_life
    self.class.life_val * health
  end
end

class Dog < Pet
  attr_accessor :color

  def initialize(*args, color: nil)
    super(*args)
    @color = color
  end
end

pet = Pet.new do |el|
  el.health = 20
  el.legs = 2
end
p pet
p pet.current_life

dog = Dog.new.tap do |el|
  el.color = 'black'
  el.legs = 2
  el.health = 10
end
p dog
p dog.current_life
