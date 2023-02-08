require_relative './app'

def main
  puts 'Welcome to School Library App!'
  app = App.new
  # File.write("./store/books.json", 'This is just a sample text', mode: 'a')

  loop do
    puts [' ', 'Please, choose an option by entering a number:',
          '1. List all books', '2. List all people', '3. Create a person',
          '4. Create a book',
          '5. Create a rental',
          '6. List all rentals for a given person id',
          '7. Exit']

    num = gets.chomp

    if num == '7'
      puts 'Thank you for using our App!'
      break
    elsif (1...7).include?(num.to_i)
      app.options[:"#{num}"].call
    else
      puts 'Please enter a valid input; Hint: try (1...7)'
    end
  end
end

main
