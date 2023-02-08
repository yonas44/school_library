require_relative './association'
require_relative './student'
require_relative './teacher'
require_relative './utils'
require 'json'

class App
  attr_reader :options

  def initialize
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
    @all_books = fetch_books
    unless @all_books.is_a? Array
      return puts 'There is no books.json file inside the store directory, make sure it exits!'
    end
    return puts 'There are no books, currently' if @all_books.empty?

    @all_books.each do |book|
      book = JSON.parse(book)
      puts "Title: #{book['title']}, Author: #{book['author']}"
    end
  end

  def list_people
    @all_people = fetch_people
    unless @all_people.is_a? Array
      return puts 'There is no people.json file inside the store directory, make sure it exits!'
    end
    return puts 'There are no people, currently' if @all_people.empty?

    @all_people.each do |person|
      person = JSON.parse(person)
      puts "[#{person['role']}] Name: #{person['name']}, ID: #{person['id']}, Age: #{person['age']}"
    end
  end

  def create_person
    num = ask_question('Do you want to create a Student (1) or a teacher (2)? [Enter a number]: ')
    case num
    when '1' then create_student
    when '2' then create_teacher
    else puts 'Your choice is invalid, try'
    end
  end

  def create_student
    age = ask_question('Age: ')
    name = ask_question('Name: ')

    # Loops until the user gives the right input [Y/N] for parent_permission
    permission = ask_question('Has parent permission?: [Y/N]') until %w[Y N y n].include?(permission)

    permission = true if %w[Y y].include?(permission)
    permission = false if %w[N n].include?(permission)
    store_people(Student.new(nil, age, name, parent_permission: permission))
    puts 'Person created successfully'
  end

  def create_teacher
    age = ask_question('Age: ')
    name = ask_question('Name: ')
    specialization = ask_question('Specialization: ')
    store_people(Teacher.new(specialization, age, name))
    puts 'Person created successfully'
  end

  def create_book
    title = ask_question('Enter the title of the book: ')
    author = ask_question('Enter the author of the book: ')
    store_book(Book.new(title, author))
    puts 'Book created successfully'
  end

  def create_rental
    if fetch_books.empty? || fetch_people.empty?
      return puts 'There are no books or people to rent, create a book and person first'
    end

    puts 'Select a book from the following list by number'
    fetch_books.each_with_index do |book, index|
      book = JSON.parse(book)
      puts "#{index}) Title: #{book['title']}, Author: #{book['author']}"
    end
    book_index = gets.chomp.to_i
    puts 'Select a person from the following list by number (no id)'

    fetch_people.each_with_index do |person, index|
      person = JSON.parse(person)
      puts "#{index}) [#{person['role']}] Name: #{person['name']}, ID: #{person['id']}, Age: #{person['age']}"
    end
    person_index = gets.chomp.to_i

    date = ask_question('Date: ')

    store_rentals(
      Rental.new(JSON.parse(fetch_people[person_index]),
                 JSON.parse(fetch_books[book_index]), date), book_index, person_index
    )
  end

  def list_rentals
    @all_rentals = fetch_rentals
    return puts "There is no rentals.json file inside the store directory, make sure it exits!" unless @all_rentals.is_a? Array
    id = ask_question('ID of person: ')
    puts 'Rentals:'

    return puts 'There are no rentals yet.' if @all_rentals.empty?

    @all_rentals.map do |rental|
      parsed_rental = JSON.parse(rental)
      next unless parsed_rental['id'].to_s == id.to_s

      puts "Date: #{parsed_rental['date']}, Book '#{parsed_rental['book']}' by #{parsed_rental['author']}"
    end
  end

  def ask_question(question)
    print question
    gets.chomp
  end
end