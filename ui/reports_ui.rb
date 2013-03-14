require './ui_helper.rb'

def list_categories
  if Category.all.length != 0
    puts "\nHere are your categories"
    puts "ID    Category"
    Category.all.each do |category|
      puts "#{category.id}   #{category.name}"
    end
  else
    puts "You have no categories."
  end
end

def list_expenses
  unless Expense.all.length == 0
    puts "Here are your expenses:"
    puts "ID     Date     Amount    Category    Name"
    #uts "##   mm/dd/yy   $11.11    General    an expense"
    Expense.all.each do |expense|
      print "#{expense.id}   #{expense.expense_date}   $#{expense.amount}   "
      begin
        category_name = Category.find(expense.category_id).name
      rescue ActiveRecord::RecordNotFound
        category_name = "invalid category"
      end
      puts "#{category_name}    #{expense.name}"
    end
  else
    puts "You have no expenses, Dawg."
  end
end

#****************************************

def search_menu
  choice = nil
  until choice == 'x'
    puts "PRESS: | TO SEARCH BY:"
    puts "  N    |     Name"
    puts "  C    |   Category"
    puts "  D    |     Date"
    puts "  R    | Range of Dates"    
    choice = gets.chomp.downcase
    case choice
    when 'n'
      search_by_name
    when 'c'
      search_by_category
    when 'd'
      search_by_date
    when 'r'
      search_by_date_range
    when 'x'
      exit
    else
      puts input_error
    end
  end
end

def search_by_name
  puts "\nInput name for which to search :"
  criteria = gets.chomp
  expenses = Expense.where(:name => criteria)
  expenses.each {|expense| view_expense(expense)}
end

def search_by_date
  puts "\nEnter a date to search by:"
  search_date = gets.chomp
  found_expenses = Expense.where(:expense_date => search_date)
  if found_expenses.first.class == Expense
    found_expenses.each {|expense| view_expense(expense)}
  else
    puts empty_expense_list
  end
end

def search_by_date_range
  puts "\nEnter a start date for the search range:"
  start_date = gets.chomp
  puts "\nEnter an end date for the search range:"
  end_date = gets.chomp
  found_expenses = Expense.where(":start <= expense_date AND :end >= expense_date", :end => end_date, :start => start_date)
  if found_expenses.first.class == Expense
    found_expenses.each {|expense| view_expense(expense)}
  else
    puts empty_expense_list
  end
end

# def search_by_category
#   list_categories
#   puts "Enter the ID of the category to search by:"
#   print "ID: "
#   category_id = gets.chomp.to_i
#   begin
#     expense = Category.find(category_id)
#   rescue ActiveRecord::RecordNotFound
#     puts "There isn't a category with that ID."
#   end
#   expenses = Expense.where(:category_id => category_id)
#   expenses.each {|expense| view_expense(expense)}
# end

def search_by_category
  list_categories
  puts "Enter the ID of the category to search by:"
  print "ID: "
  category_id = gets.chomp.to_i
  Category.find(category_id).expenses.each {|expense| view_expense(expense)}
end

# def search_by_name_menu
#   choice = nil
#   until choice == 'x'
#     puts "\nInput search criteria:"
#     puts "Press 'e' for exact."
#     puts "Press 'r' for range."
#     puts "Press 'c' for contains."
#     puts "Press 'g' for greater than."
#     puts "Press 'l' for less than."
#     puts "Press 's' to save your results."
#     puts "Press 'x' to save to the previous menu."
#     choice = gets.chomp.downcase
#     case choice
#     when 'r'
#       print "Enter first string:  "
#       criteria1 = gets.chomp
#       print "Enter last string:  "
#       criteria2 = gets.chomp
#       expenses = Expense.where(":name >= criteria1 AND :name <= criteria2")
#     when 'x'
#       return
#     when 's'
#       expenses.each {|expense| view_expense(expense)} 
#     else
#       print "Enter string:  "
#       criteria = gets.chomp
#       case choice
#       when 'e'
#         expenses = Expense.where(:name => criteria)
#       when 'c'
#         name = "%#{criteria}%"
#         expenses = Expense.where(":name LIKE name")
#       when 'l'
#         expenses = Expense.where(":name < criteria")
#       when 'g'
#         expenses = Expense.where(":id_inputted > id_column", :id_inputted => user_input)
#       end
#     end
#   end
# end



