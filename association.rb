class Classroom
  attr_accessor :label, :students

  def initialize(label)
    @label = label
    @students = []
  end

  def add_student(student)
    @students << (student) unless @students.include?(student)
    student.classroom = self
  end
end

class Rental
  attr_accessor :date, :person, :book

  def initialize(person, book, date)
    @person = person
    @book = book
    @date = date
    person['rentals'].push(to_json) unless person['rentals'].include?(to_json)
    book['rentals'].push(to_json) unless book['rentals'].include?(to_json)
  end

  def to_json(*_args)
    {
      'author' => @book['author'],
      'book' => @book['title'],
      'date' => @date,
      'id' => @person['id']
    }
  end
end

class Book
  attr_accessor :title, :author, :rentals

  def initialize(title, author)
    @title = title
    @author = author
    @rentals = []
  end

  def to_json(*_args)
    {
      'title' => @title,
      'author' => @author,
      'rentals' => @rentals
    }
  end

  def add_rental(person, date)
    rental = Rental.new(person, to_json, date)
    @rentals.push(rental.to_json) unless @rentals.include?(rental.to_json)
  end
end
