require './ui_helper.rb'

def category_menu
  puts "\nCategory Management Options"
  choice = nil
  until choice == 'x'
    puts "Press 'x' to exit category menu."
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
      exit
    else
      puts "FAIL! Try again!"
    end
  end
end

def list_categories
  puts "Here are your categories"
  puts "ID    Category"
  Category.all.each do |category|
    puts "#{category.id}   #{category.name}"
  end
end