class Person
  attr_accessor :name, :age, :parent_permission

  def initialize(name, age, parent_permission)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  private

  def _is_of_age?(age)
    return true unless age < 18

    false
  end

  public

  def can_use_services?
    return false unless parent_permission

    true
  end
end