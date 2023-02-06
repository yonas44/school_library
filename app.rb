require_relative './association'
require_relative './student'
require_relative './teacher'

class App
  attr_reader :options

  def initialize
    @all_books = []
    @all_people = []
    @all_rentals = []

    @options = {
      '1': method(:list_books),
      '2': method(:list_people),
      '3': method(:create_person),
      '4': method(:create_book),
      '5': method(:create_rental),
      '6': method(:list_rentals),
      '7': method(:exit)
    }
  end

  def list_books
    return puts 'There are no books, currently' if @all_books.empty?

    @all_books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
  end

  def list_people
    return puts 'There are no people, currently' if @all_people.empty?

    @all_people.each do |person|
      puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_person
    num = ask_question('Do you want to create a Student (1) or a teacher (2)? [Enter a number]: ')
    case num
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'Your choice is invalid, try'
    end
  end

  def create_student
    age = ask_question('Age: ')
    name = ask_question('Name: ')

    # Loops until the user gives the right input [Y/N] for parent_permission
    permission = ask_question('Has parent permission?: [Y/N]') until %w[Y N y n].include?(permission)

    permission = true if %w[Y y].include?(permission)
    permission = false if %w[N n].include?(permission)

    puts 'Please, enter a valid input'

    @all_people.push(Student.new(nil, age, name, parent_permission: permission))
    puts 'Person created successfully'
  end

  def create_teacher
    age = ask_question('Age: ')
    name = ask_question('Name: ')
    specialization = ask_question('Specialization: ')
    @all_people.push(Teacher.new(specialization, age, name))
    puts 'Person created successfully'
  end

  def create_book
    title = ask_question('Enter the title of the book: ')
    author = ask_question('Enter the author of the book: ')
    @all_books.push(Book.new(title, author))
    puts 'Book created successfully'
  end

  def create_rental
    if @all_books.empty? || @all_people.empty?
      puts 'There are no books or people to rent, create a book and person first'
      return
    end

    puts 'Select a book from the following list by number'
    @all_books.each_with_index { |book, index| puts "#{index}) Title: #{book.title}, Author: #{book.author}" }
    book_index = gets.chomp
    puts 'Select a person from the following list by number (no id)'

    @all_people.each_with_index do |person, index|
      if defined?(person.specialization)
        puts "#{index}) [Teacher] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      else
        puts "#{index}) [Student] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
      end
    end
    person_index = gets.chomp

    date = ask_question('Date: ')
    @all_rentals.push(Rental.new(@all_people[person_index.to_i], @all_books[book_index.to_i], date))
    puts 'Rental created successfully'
  end

  def list_rentals
    id = ask_question('ID of person: ')
    puts 'Rentals:'

    return puts 'There are no rentals yet.' if @all_rentals.empty?

    @all_rentals.map do |rental|
      next unless rental.person.id.to_s == id.to_s

      puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}"
    end
  end

  def ask_question(question)
    print question
    gets.chomp
  end
end
