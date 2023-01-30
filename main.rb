class Person
  attr_accessor :name, :age, :parent_permission

  def initialize(name, age = 'unknown', parent_permission: true)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def _is_of_age?(age)
    return true unless age < 18

    false
  end

  def can_use_services?
    return true unless parent_permission

    false
  end
end
