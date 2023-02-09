require 'rspec'
require_relative '../association'
require_relative '../student'

describe Classroom do
  before :each do
    @classroom = Classroom.new('Math_class')
  end

  it 'initialize the class correctly' do
    expect(@classroom.label).to eq 'Math_class'
  end

  describe '#add_student' do
    it 'add student to the students array' do
      student = Student.new(nil, 17, 'Sasuke')
      @classroom.add_student(student)
      expect(student.classroom.label).to eq 'Math_class'
    end
  end
end

describe Book do
  before :each do
    @book = Book.new('Atomic_habits', 'James_clear')
  end

  it 'Sets the title and author' do
    expect(@book.author).to eq 'James_clear'
    expect(@book.title).to eq 'Atomic_habits'
  end

  it 'adds rental to rentals array' do
    person = { 'id' => 12, 'name' => 'Robert', 'age' => 32, 'rentals' => [] }
    person2 = { 'id' => 24, 'name' => 'Albert', 'age' => 52, 'rentals' => [] }
    @book.add_rental(person, '2023-02-08')
    @book.add_rental(person2, '2023-02-08')
    expect(@book.rentals.length).to eql 2
  end
end

describe Rental do
  before :each do
    person = { 'name' => 'Robert', 'age' => 32, 'rentals' => [] }
    book = { 'title' => 'Narnia', 'author' => 'Bob', 'rentals' => [] }
    @rental = Rental.new(person, book, '2023-02-09')
  end

  it 'creates a rental' do
    expect(@rental.person['name']).to eq 'Robert'
    expect(@rental.book['title']).to eq 'Narnia'
  end
end
