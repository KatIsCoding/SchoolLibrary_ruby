class Person
  def initialize(age, name = "Unknown", parent_permission = true)
    @id = Random.rand(1..10000)
    @name = name
    @age = age
  end

  attr_reader :id
  attr_accessor :name
  attr_accessor :age

  def can_use_services?
    return true if self.is_of_age? && @parent_permission
    return false
  end

  

  def is_of_age?
    return true if @age >= 18
    return false
  end

  private :is_of_age?

end