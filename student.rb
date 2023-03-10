require_relative './person'

class Student < Person
  attr_accessor :classroom

  def initialize(classroom, age, name = 'unknown', parent_permission: true)
    super(name, age, parent_permission)
    @classroom = classroom
    classroom&.students&.push(self) unless classroom&.students&.include?(self)
  end

  def play_hooky
    '¯(ツ)/¯'
  end
end
