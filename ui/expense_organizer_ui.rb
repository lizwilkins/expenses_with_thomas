require './ui_helper.rb'

def welcome
  puts "\nWelcome to 'A Fool and His Money' Expense Tracker!\n"
  menu
end

def menu
  choice = nil
  until choice == 'x'
    puts "Press 'c' for Category management."
    puts "Press 'e' for Expense management."
    puts "Press 'r' for Report Generation"
    puts "Press 'x' to eXit."
    puts "Press 's' to search expenses."
    choice = gets.chomp.downcase
    case choice
    when 'e'
      expense_menu
    when 'c'
      category_menu
    when 'r'
      search_menu
    when 's'
      search_by_category
    when 'x'
      exit
    else
      puts input_error
    end
  end
end

welcome