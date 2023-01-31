require_relative './main'

class Teacher < Person
  def initialize(name, specialization, age = "Unknown", parent_permission = true)
    super(name, age, parent_permission)
    @specialization = specialization
  end

  def can_use_services?
    true
  end
end
