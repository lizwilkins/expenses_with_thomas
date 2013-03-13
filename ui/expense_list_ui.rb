require './ui_helper.rb'

def list_expenses
  unless Expense.all.length == 0
    puts "How would you like to sort your expenses?"
    puts "Press: | To sort by:"
    puts "  C    |  Category"
    puts "  A    |   Amount"
    puts "  N    |    Name"
    puts "  D    |    Date"
    puts "  I    |     ID"
    
    sort_method_choice = gets.chomp.upcase
    case sort_method_choice
    when 'C'
      list_expenses_by_category
    when 'A'
      list_expenses_by_amount
    when 'N'
      list_expenses_by_name
    when 'D'
      list_expenses_by_date
    when 'I'
      list_expenses_by_id
    else
      input_error_for(valid_inputs)
    end
  else
    puts empty_expense_list
  end
end

def list_expenses_by_category
  puts "Your expenses listed by category:"
  puts "ID     Date     Amount    Category    Name"
  Expense.order("category").each do |expense|
    puts "#{expense.id}   $#{expense.amount}   #{expense.category_id}    #{expense.name}"
  end
end

def list_expenses_by_amount
  puts "Your expenses listed by amount:"
  puts "ID     Date     Amount    Category    Name"
  Expense.order("amount").each do |expense|
    puts "#{expense.id}   $#{expense.amount}   #{expense.category_id}    #{expense.name}"
  end
end

def list_expenses_by_name
  puts "Your expenses listed by name:"
  puts "ID     Date     Amount    Category    Name"
  Expense.order("name").each do |expense|
    puts "#{expense.id}   $#{expense.amount}   #{expense.category_id}    #{expense.name}"
  end
end

def list_expenses_by_date
  puts "Your expenses listed by date:"
  puts "ID     Date     Amount    Category    Name"
  Expense.order("expense_date").each do |expense|
    puts "#{expense.id}   $#{expense.amount}   #{expense.category_id}    #{expense.name}"
  end
end

def list_expenses_by_id
  puts "Here are your expenses listed by ID:"
  puts "ID     Date     Amount    Category    Name"
  Expense.all.each do |expense|
    puts "#{expense.id}   $#{expense.amount}   #{expense.category_id}    #{expense.name}"
  end
end