require './ui_helper.rb'

def expense_menu
  puts "\nExpense Menu Options"
  choice = nil
  if Category.find(1) == nil
    Category.new(:id => 1, :name => "undecided").save
  end

  until choice == 'x'
    puts "Press 'x' to return to the previous menu."
    puts "Press 'a' add an expense."
    puts "Press 'd' delete an expense."
    puts "Press 'e' edit an expense."
    puts "Press 'v' to view an expense."
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
    when 'v'
      view_expense(nil)
    when 'x'
      return "Returning to the previous menu..."
    else
      puts input_error
    end
  end
end

# def list_expenses
#   unless Expense.all.length == 0
#     puts "Here are your expenses:"
#     puts "ID     Date     Amount    Category    Name"
#     #uts "##   mm/dd/yy   $11.11    General    an expense"
#     Expense.all.each do |expense|
#       print "#{expense.id}   $#{expense.amount}   "
#       begin
#         category_name = Category.find(category_id).name
#       rescue ActiveRecord::RecordNotFound
#         category_name = "invalid category"
#       end
#       puts "#{category_name}    #{expense.name}"
#     end
#   else
#     puts "You have no expenses, Dawg."
#   end
# end

def add_expense
  choice = nil
  category_id = 1
  until choice == 'x'
    puts "\nOptions for New Expense:"
    puts "Press 'x' to return to the previous menu."
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
      save_expense(Expense.new(:name => name, :expense_date => date, 
                               :amount => amount, :category_id => category_id))
      return "Returning to the previous menu..."
    when 'v'
      view_expense(Expense.new(:name => name, :expense_date => date, 
                               :amount => amount, :category_id => category_id))
    when 'x'
      return "Returning to the previous menu..."
    else
      puts input_error
    end
  end
end

def edit_expense
  choice = nil
  unless Expense.all.length == 0
    list_expenses
    puts "Enter the ID of the expense you wish to modify:"
    expense_id = gets.chomp.to_i
    begin
      expense = Expense.find(expense_id)
    rescue ActiveRecord::RecordNotFound
      puts "There isn't a expense with that ID."
      edit_expense
    end
    view_expense(expense)
    name = expense.name
    date = expense.expense_date
    amount = expense.amount
    category_id = expense.category_id
    until choice == 'x'
      puts "\nOptions for Editing an Expense:"
      puts "Press 'x' to return to the previous menu."
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
        update_expense(expense, Expense.new(:name => name, :expense_date => date, 
                               :amount => amount, :category_id => category_id))
      when 'v'
        view_expense(Expense.new(:name => name, :expense_date => date, 
                               :amount => amount, :category_id => category_id))
      when 'x'
        return "Returning to the previous menu..."
      else
        puts input_error
      end
    end
  else
    puts "You haven't added any expenses yet."
  end
end

def delete_expense
  unless Expense.all.length == 0
    list_expenses
    puts "Enter the ID of the expense you wish to delete:"
    expense_id = gets.chomp.to_i
    begin
      expense = Expense.find(expense_id)
    rescue ActiveRecord::RecordNotFound
      puts "There isn't an expense with that ID."
      delete_expense
    end
    puts "Are you sure you want to delete '#{expense.name}'? (y/n)"
    choice = gets.chomp.downcase
    case choice
    when 'y'
      puts "'#{expense.name}' was deleted."
      expense.destroy
    when 'n'
      puts "'#{expense.name}' was not deleted."
    else
      puts input_error
    end
  else
    puts "You haven't added any expenses yet."
  end
end

def view_expense(expense)
  if expense == nil
    list_expenses
    print "Enter the expense ID: "
    expense = Expense.find(gets.chomp.to_i)
  end
  puts "Info for New Expense"
  puts "Date:  #{expense.expense_date}"
  puts "Amount:  $#{expense.amount}"
  puts "Name:  #{expense.name}"
  if expense.category_id
    puts "Category: #{Category.find(expense.category_id).name}"   #check for bad id
  else
    puts "Category: "
  end
end

def save_expense(expense)
  if expense.name.length != 0
    puts "Review your data for entry:"
    view_expense(expense)
    print "Save data (y/n):  "
    if gets.chomp.downcase == 'y'
      if expense.save
        puts "Entry saved!"
        new_tie = Ty.new(:expense_id => expense.id, :category_id => expense.category_id).save  # check for failure
      else
        puts "'#{expense.name}' was not saved (errors)."
        expense.errors.full_messages.each {|message| puts message}
      end
    end
  else
    puts "Expense must have a name field, please add one."
  end
end

def update_expense(expense, updated_expense)
  if updated_expense.name.length != 0
    puts "Review your data for entry:"
    view_expense(updated_expense)
    print "Save data (y/n):  "
    if gets.chomp.downcase == 'y'
      expense.update_attributes(:name => updated_expense.name, :expense_date => updated_expense.expense_date, 
                                :amount => updated_expense.amount, :category_id => updated_expense.category_id)
      # if worked  # need result
      #   "Entry updated!"
      # else
      #   puts "Changes to '#{expense.name}' were not saved (errors)."
      #   expense.errors.full_messages.each {|message| puts message}
      # end
    end
  else
    puts "Expense must have a name field, please add one."
  end
end

def enter_name
  print "Enter the name: "
  name = gets.chomp
end

def enter_date
  print "Enter the date:"
  puts "Example: 2011/07/25"
  print "(YYYY/MM/DD): "
  date = gets.chomp
  p date
end

def enter_amount
  print "Enter the amount: $"
  amount = gets.chomp.to_f
end

def enter_category
  if Category.all.length != 0
    list_categories
  else
    puts "You don't have any categories, yet."
  end
  print "Do you want to use one of these categories (y/n): "
  choice = gets.chomp.downcase
  if choice == 'n'
    add_category
    list_categories
  end
  if choice == 'y' || choice == 'n'
    print "Enter the category ID: "
    category_id = gets.chomp.to_i
  else
    puts input_error
    category_id = 0
  end
end

# def enter_category
#   unless Category.all.length == 0
#     list_categories
#     print "Enter the category ID: "
#     category_id = gets.chomp.to_i
#     categories_ids = Category.all.each {|category| category.id}
#     if categories_ids.include?(category_id)
#       category = Category.find(category_id)
#     else
#       puts "#{category_id} wasn't the ID of an existing category."
#     end
#   else
#     puts "You don't have any categories yet."
#     add_category
#   end
# end


# def list_options_for_add
#     puts "Press 'x' to return add expense menu."
#     puts "Press 'n' for expense name."
#     puts "Press 'd' for expense date."
#     puts "Press 'a' for expense amount."
#     puts "Press 'c' for expense category."    
#     puts "Press 'v' to view your expense."
#     puts "Press 's' to save expense to database."
# end