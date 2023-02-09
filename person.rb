require_relative './nameable'
require_relative './association'

class Person < Nameable
  attr_reader :id
  attr_accessor :name, :age, :parent_permission, :rentals

  def initialize(name, age, parent_permission)
    super()
    @id = Random.rand(1..1000)
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
  end

  def to_json(*_args)
    {
      'role' => self.class,
      'name' => @name,
      'id' => @id,
      'age' => @age,
      'parent_permission' => @parent_permission,
      'rentals' => @rentals
    }
  end

  private

  def _is_of_age?(age)
    age < 18
  end

  public

  def can_use_services?
    return false unless parent_permission

    true
  end

  def correct_name
    @name
  end

  def add_rental(book, date)
    rental = Rental.new(self, book, date)
    @rentals.push(rental.to_json) unless @rentals.include?(rental.to_json)
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
    return @nameable.correct_name[0, 10] unless @nameable.correct_name.length < 10

    @nameable.correct_name
  end
end

base = Person.new('yonas', 25, true)
decorator = CapitalizeDecorator.new(base)
puts decorator.correct_name
