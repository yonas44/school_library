require_relative './nameable'

class Person < Nameable
  attr_reader :id
  attr_accessor :name, :age, :parent_permission

  def initialize(name, age, parent_permission: true)
    super()
    @id = Random.rand(1..1000)
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

  def correct_name
    @name
  end
end

class BaseDecorator < Nameable
  def initialize(props)
    super()
    @nameable = props
  end

  def correct_name
    @nameable.correct_name
  end
end

class CapitalizeDecorator < BaseDecorator
  def correct_name
    @nameable.correct_name.capitalize
  end
end

class TrimmerDecorator < BaseDecorator
  def correct_name
    @nameable.correct_name[0, 10]
  end
end
