def fetch_books
  return 'Failed' unless File.exist?('./store/books.json')

  File.open('./store/books.json', 'r') { |file| JSON.parse(file.read) }
end

def fetch_people
  return 'Failed' unless File.exist?('./store/books.json')

  File.open('./store/people.json', 'r') { |file| JSON.parse(file.read) }
end

def store_book(book)
  books = fetch_books

  books << JSON.generate(book.to_json)

  File.write('./store/books.json', JSON.generate(books), mode: 'w')
end

def store_people(person)
  people = fetch_people

  people << JSON.generate(person.to_json)

  File.write('./store/people.json', JSON.generate(people), mode: 'w')
end

def fetch_rentals
  return 'Failed' unless File.exist?('./store/rentals.json')

  File.open('./store/rentals.json') { |line| JSON.parse(line.read) }
end

def store_rentals(rental, book_index, person_index)
  rentals = File.open('./store/rentals.json', 'r') { |line| JSON.parse(line.read) }
  rentals << JSON.generate(rental.to_json)

  File.write('./store/rentals.json', JSON.generate(rentals), mode: 'w')

  update_people(rental, person_index)
  update_books(rental, book_index)
  puts 'Rental created successfully'
end

def update_books(rental, book_index)
  books = fetch_books
  book = JSON.parse(books[book_index])
  book['rentals'].concat(rental.book['rentals'])
  books[book_index] = JSON.generate(book)

  File.write('./store/books.json', JSON.generate(books), mode: 'w')
end

def update_people(rental, person_index)
  people = fetch_people
  person = JSON.parse(people[person_index])
  person['rentals'].concat(rental.person['rentals'])
  people[person_index] = JSON.generate(person)

  File.write('./store/people.json', JSON.generate(people), mode: 'w')
end
