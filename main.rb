require_relative './student'
require_relative './book'
require_relative './rental'
require_relative './teacher'

def list_all_books(books_list = [])
  books_list.each_with_index do |book, index|
    puts "========#{index + 1}========\n#{book.title} by #{book.author}"
  end
end

def list_all_people(people_list = [])
  people_list.each_with_index do |person, index|
    puts "========#{index + 1}========="
    puts "Type: #{person.class}"
    puts "ID: #{person.id}"
    puts "Name: #{person.name}"
    puts "Age: #{person.age}"
  end
end

def choice_selector(choices)
  puts 'Please choose one of the following:'
  choices.each_with_index do |choice, index|
    puts "#{index + 1}: #{choice}"
  end
  gets.chomp.to_i
end

def create_person(people_list)
  type = choice_selector(%w[Student Teacher])

  print('Enter the name: ')
  name = gets.chomp

  print('Enter the age: ')
  age = gets.chomp

  case type
  when 1
    print('Enter the parent permission of the student [Y/N]: ')
    parent_permission = gets.chomp
    parent_permission = parent_permission.upcase == 'Y'
    student = Student.new(age, nil, name, parent_permission: parent_permission)
    people_list << student
  when 2
    print('Enter the specialization of the teacher: ')
    specialization = gets.chomp
    teacher = Teacher.new(age, specialization, name)
    people_list << teacher
  end
  puts 'Person created successfully'
end

def create_book(books_list)
  puts 'Please enter the title of the book'
  print('Enter the title: ')
  title = gets.chomp
  puts 'Please enter the author of the book'
  print('Enter the author: ')
  author = gets.chomp
  book = Book.new(title, author)
  books_list << book
  puts 'Book created successfully'
end

def create_rental(rentals_list, people_list, books_list)
  list_all_people(people_list)
  print('Select the person who is renting the book: ')
  person_id = gets.chomp.to_i
  person_obj = people_list[person_id - 1]
  list_all_books(books_list)
  print('Select the book that is being rented: ')
  book_id = gets.chomp.to_i
  unless book_id - 1 < books_list.length && person_id - 1 < people_list.length
    puts 'Invalid book ID'
    return
  end
  book_obj = books_list[book_id - 1]
  print('Enter the rental date: ')
  rental_date = gets.chomp
  rental = Rental.new(rental_date, book_obj, person_obj)
  rental.inscribe_book
  rental.inscribe_owner
  rentals_list << rental
  puts 'Rental created successfully'
end

def list_all_rentals_for_person(people_list)
  puts 'Please enter the person ID'
  print('Enter the person ID: ')
  person_id = gets.chomp.to_i
  people_list.each do |person|
    next unless person.id == person_id

    puts "========#{person.name}========="
    person.rentals.each do |rental|
      puts "Rented book: #{rental.book.title} by #{rental.book.author}"
      puts "Rental Date: #{rental.date}"
      puts '=============================='
    end
  end
end

def show_menu()
  puts 'Please choose an option by enering a number'
  puts '1. List all books'
  puts '2. Create a book '
  puts '3. Create a person'
  puts '4. List all people'
  puts '5. Create a rental'
  puts '6. List all rentals for a given person id'
  puts '7. Exit'
  print('Enter your choice: ')
  gets.chomp.to_i
end

def book_selections(choice, books_list)
  case choice
  when 1
    list_all_books(books_list)
  when 2
    create_book(books_list)
  end
end

def people_selections(choice, people_list)
  case choice
  when 3
    create_person(people_list)
  when 4
    list_all_people(people_list)
  end
end

def rental_selections(choice, rentals_list, people_list, books_list)
  case choice
  when 5
    create_rental(rentals_list, people_list, books_list)
  when 6
    list_all_rentals_for_person(people_list)
  end
end


def menu_choices(books_list, people_list, rentals_list)
  choice = 0
  while choice != 7
    choice = show_menu
    case choice
    when 1..2
      book_selections(choice, books_list)
    when 3..4
      people_selections(choice, people_list)
    when 5..6
      rental_selections(choice, rentals_list, people_list, books_list)
    when 7
      puts 'Goodbye'
      return 0
    else
      puts 'Invalid choice'
    end
  end
end

def main()
  books_list = []
  people_list = []
  rentals_list = []
  menu_choices(books_list, people_list, rentals_list)
end

main
