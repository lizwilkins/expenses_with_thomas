require './ui_helper.rb'

def expense_menu
  puts "\nExpense Menu Options"
  choice = nil
  until choice == 'x'
    puts "Press 'x' to exit expense menu."
    puts "Press 'a' add an expense."
    puts "Press 'd' delete an expense."
    puts "Press 'e' edit an expense."
    puts "Press 'l' list expenses."
    choice = gets.chomp.downcase
    case choice
    when 'a'
      add_expense
    when 'd'
      delete_expense
    when 'e'
      edit_expense
    when 'l'
      list_expenses
    when 'x'
      exit
    else
      puts "FAIL! Try again!"
    end
  end
end

def add_expense
  puts "\nOptions for Add Expense"
  choice = nil
  until choice == 'x'
    puts "Press 'x' to exit add expense menu."
    puts "Press 'n' for expense name."
    puts "Press 'd' for expense date."
    puts "Press 'a' for expense amount."
    puts "Press 'c' for expense category."    
    puts "Press 'v' to view your expense."
    puts "Press 's' to save expense to database."
    choice = gets.chomp.downcase
    case choice
    when 'n'
      name = enter_name
    when 'd'
      date = enter_date
    when 'a'
      amount = enter_amount
    when 'c'
      category_id = enter_category
    when 's'
      expense = Expense.new(:name => name, :expense_date => date, :amount => amount, :category_id => category_id)
      save_expense(expense)
    when 'v'
      view_expense(Expense.new(:name => name, :expense_date => date, :amount => amount, :category_id => category_id))
    when 'x'
      exit
    else
      puts "FAIL! Try again!"
    end
  end
end

def save_expense(expense)
  puts "Review your data for entry: "
  #view_expense(expense)
  print "Save data (y/n):  "
  if gets.chomp.downcase == 'y'
    if expense.save
      "Entry saved!"
    else
      puts "Did not save!"    # error message
    end
  end
end

def view_expense(expense)
  print "Expense date:  #{expense.expense_date}"
  print "Expense amount:  #{expense.amount}"
  print "Expense name:  #{expense.name}"
  print "Expense category:  #{Category.find(expense.category_id).first.name}"
end

# def list_options_for_add
#     puts "Press 'x' to exit add expense menu."
#     puts "Press 'n' for expense name."
#     puts "Press 'd' for expense date."
#     puts "Press 'a' for expense amount."
#     puts "Press 'c' for expense category."    
#     puts "Press 'v' to view your expense."
#     puts "Press 's' to save expense to database."
# end

def enter_name
  print "Enter the name: "
  name = gets.chomp
end

def enter_date
  print "Enter the date (mm/dd/yy):"
  date = gets.chomp
end

def enter_amount
  print "Enter the amount: $"
  amount = gets.chomp.to_f #set to 2 decimals
end

def enter_category
  list_categories
  print "Enter the category ID: "
  category_id = gets.chomp.to_i
end

def save_expense(expense)
  expense.save
end