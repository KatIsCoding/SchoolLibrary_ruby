class Classroom
  def initialize(label)
    @label = label
    @students = []
  end

  attr_accessor :label
  attr_reader :students

  def add_student(student)
    if !@students.include?(student) do
      @students.push(student)  
    end
    student.classroom = self
  end


end