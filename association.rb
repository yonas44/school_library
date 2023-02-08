class Classroom
  attr_accessor :label, :students

  def initialize(label)
    @label = label
    @students = []
  end

  def add_student(student)
    @students.push(student) unless @student.include?(student)
    student.classroom = self
  end
end

class Rental
  attr_accessor :date, :person, :book

  def initialize(person, book, date)
    @person = person
    @book = book
    @date = date
    person.rentals.push(self) unless person.rentals.include?(self)
    book.rentals.push(self) unless book.rentals.include?(self)
  end

  def to_json(*args)
    {
      'person' => @person,
      'book' => @book,
      'date' => @date
    }.to_json(*args)
  end
end

class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def to_json(*args)
    {
      'title' => @title,
      'author' => @author,
      'rentals' => @rentals
    }.to_json(*args)
  end

  def add_rental(person, date)
    rental = Rental.new(person, self, date)
    @rentals.push(rental) unless @rentals.include?(rental)
  end
end
