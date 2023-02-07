def fetch_books
  File.open('./store/books.json', 'r') { |file| JSON.parse(file.read, { symbolize_names: true }) }
end

def fetch_people
  File.open('./store/people.json', 'r') { |file| JSON.parse(file.read, { symbolize_names: true }) }
end

def store_book(book)
  books = fetch_books
  hashed_book = { title: book.title, author: book.author }
  books << hashed_book

  File.write('./store/books.json', JSON.generate(books), mode: 'w')
end

def store_people(person)
  puts person.class
  people = fetch_people
  hashed_person_obj = {
    id: person.id,
    role: person.class,
    name: person.name,
    age: person.age,
    specialization: defined?(person.specialization) ? person.specialization : nil,
    parent_permission: defined?(person.parent_permission) ? person.parent_permission : nil
  }
  people << hashed_person_obj

  File.write('./store/people.json', JSON.generate(people), mode: 'w')
end
