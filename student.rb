require_relative './person'

class Student < Person
  def initialize(age, classroom, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission)
    @classroom = classroom
  end

  def play_hooky()
    '¯\\(ツ)/¯'
  end

  def set_classroom(classroom)
    @classroom = classroom
    classroom.add_student(self)
  end
end
