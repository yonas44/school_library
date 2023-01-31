require_relative './main'

class Student < Person
  def initialize(classroom, name, age = 'unknown', parent_permission: true)
    super(name, age, parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end

student = Student.new('A', 'yonas', 2)
puts student.can_use_services?
