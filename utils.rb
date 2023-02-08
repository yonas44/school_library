def fetch_books
    File.open("./store/books.json", "r") do |file| JSON.parse(file.read) end
end

def fetch_people
    File.open("./store/people.json", "r") do |file| JSON.parse(file.read) end
end

def store_book(book)
    books = fetch_books

    books << book.to_json

    File.write("./store/books.json", JSON.generate(books), mode: "w")
end

def store_people(person)
    people = fetch_people
    
    people << person.to_json

    File.write("./store/people.json", JSON.generate(people), mode: "w")
end

def store_rentals(rental)
    rentals = File.open("./store/rentals.json", "r") do |line| JSON.parse(line.read) end

    rentals << rental.to_json

    File.write("./store/rentals.json", JSON.generate(rentals), mode: "w")
end
