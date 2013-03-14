require './ui_helper.rb'

def category_menu
  puts "\nCategory Management Options"
  choice = nil
  until choice == 'x'
    puts "Press 'x' to return to the previous menu."
    puts "Press 'a' add a category."
    puts "Press 'd' delete a category."
    puts "Press 'e' edit a category."
    puts "Press 'l' list categories."
    choice = gets.chomp.downcase
    case choice
    when 'a'
      add_category
    when 'd'
      delete_category
    when 'e'
      edit_category
    when 'l'
      list_categories
    when 'x'
      return "Returning to the previous menu...\n"
    else
      input_error
    end
  end
end

# def list_categories
#   if Category.all.length != 0
#     puts "\nHere are your categories"
#     puts "ID    Category"
#     Category.all.each do |category|
#       puts "#{category.id}   #{category.name}"
#     end
#   else
#     puts "You have no categories."
#   end
# end

def add_category
  unless Category.all.length == 0
    list_categories
  end
  puts "\nEnter the new category name: "
  name = gets.chomp
  category = Category.new(:name => name)
  save_category(category)
end 

def delete_category
  unless Category.all.length == 0
    list_categories
    puts "Enter the ID of the category you wish to delete:"
    category_id = gets.chomp.to_i
    if category_id == 1
      puts "You can't delete this category."
      delete_category
    end
    begin
      category = Category.find(category_id)
    rescue ActiveRecord::RecordNotFound
      puts "There isn't a category with that ID."
      delete_category
    end
    puts "Are you sure you want to delete '#{category.name}'? (y/n)"
    choice = gets.chomp.downcase
    case choice
    when 'y'
      puts "'#{category.name}' was deleted."
      category.destroy   #determine the fate of the expenses in this category
    when 'n'
      puts "'#{category.name}' was not deleted."
    else
      puts input_error
    end
  else
    puts "You haven't added any categories yet."
  end
end

def edit_category
  unless Category.all.length == 0
    list_categories
    puts "Enter the ID of the category you wish to edit:"
    category_id = gets.chomp
    if category_id == 1
      puts "You can't modify this category."
      edit_category
    end    
    begin
      category = Category.find(category_id)
    rescue ActiveRecord::RecordNotFound
      puts "There isn't a category with that ID."
      edit_category
    end
    puts "\nEnter a new name for this category:"
    new_name = gets.chomp
    puts "Are you sure you want to change '#{category.name}' to '#{new_name}'?"
    print "('y'/'n'):"
    choice = gets.chomp.downcase
    case choice
    when 'y'
      puts "'#{category.name}' was renamed as '#{new_name}'."
      category.update_attributes(:name => new_name)
    when 'n'
      puts "'#{category.name}' was not changed."
    else
      puts input_error
    end
  else
    puts "You haven't added any categories yet."
  end
end

def save_category(category)
  puts "Review your data for entry:"
  view_category(category)
  puts "Save this category?"
  print "('y/n'):"
  choice = gets.chomp.downcase
  case choice
  when 'y'
    if category.save
      puts "'#{category.name}' was saved."
    else
      puts "'#{category.name}' was not saved (errors)."
      category.errors.full_messages.each {|message| puts message}
    end
  when 'n'
    puts "'#{category.name}' was not saved (user abort)."
  else
    puts input_error
  end
end

def view_category(category)
  puts "Category name:  #{category.name}"
end