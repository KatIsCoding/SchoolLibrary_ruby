require_relative './corrector'

class Person
  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = Random.rand(1..10_000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @corrector = Corrector.new
    @rentals = []
  end

  attr_reader :id
  attr_accessor :name, :age

  def validate_name
    @name = @corrector.correct_name(@name)
  end

  def can_use_services?
    is_of_age? || @parent_permission
  end

  def of_age?
    @age >= 18
  end

  def add_rental(rental)
    @rentals << rental unless @rentals.include?(rental)
  end

  private :of_age?
end
