require 'date'
@students = [] # an empty array accessible to all methods

def print_header 
  header = "The students of Villains Academy"
  puts header.center(header.length) # centers the header in the entirety of its length
  puts "-------------".center(header.length)
end

def filter_students #de-activated method
 puts "With which letter does the names you wish to search for begin?"
 puts "To search for all names, just hit return."
 @initial = STDIN.gets.chomp
end

def twelve_chars #de-activated method 
 puts "Would you like to search for students whose names are shorter than 12 characters? (Y/N)"
 response = STDIN.gets.chomp.upcase
 short_names = @students.select {|student| student[:name].length < 12}
 response == "Y" ? print(short_names) : print(@students)
end

def print_student_list
   if @students != []
   cohort_months = @students.map{|entry| entry[:cohort]}.uniq
   cohort_months.each do |month|
     puts "#{month} cohort"
     @students.select{|student| student[:cohort] == month
     }.each_with_index do |student, i|
       puts "#{i + 1}. #{student[:name]}; Age: #{student[:age]}; Birth Country: #{student[:birth_country]}; Hobbies: #{student[:hobbies]}"
     end
   end
   end
end

def print_footer
    if @students.count == 1
    puts "Overall, we have #{@students.count} student."
    else 
    puts "Overall, we have #{@students.count} students."
    end
end

def process(selection)
    loop do 
        print_menu
        selection = STDIN.gets.chomp
        
        case selection
        when "1"
            @students = input_students
        when "2"
            show_students
        when "3"
            save_students
        when "4"
            load_students
        when "9"
            exit #this will terminate the program
        else 
            puts "I don't know what you meant. Please, try again"
        end
    end
end
 
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  
  name = STDIN.gets.chomp
  
    while !name.empty? do
      
     puts "Please submit the following extra information for this student."
         puts "Which cohort is #{name} part of?"
     cohort = gets.chomp.capitalize
     if cohort == ""
       cohort = "november"
     else
      until Date::MONTHNAMES.include? cohort
         puts "Please enter a valid cohort."
         cohort = STDIN.gets.chomp.capitalize
      end
     end
     cohort = cohort.to_sym
     
     puts "#{name}'s age:"
     age = STDIN.gets.chomp
     puts "#{name}'s country of birth:"
     birth_country = STDIN.gets.chomp
     puts "#{name}'s hobbies:"
     hobbies = STDIN.gets.chomp
     
    add_info(name, cohort, age, birth_country, hobbies)
    
    if @students.count > 1 || @students.count == 0
        puts "Now we have #{@students.count} students"
    else
        puts "Now we have #{@students.count} student"
    end
    
    puts "Enter next name:"
    name = gets.chomp
    end
  
    @students
end

def print_menu
    puts "1. Input the students"
    puts "2. Show the students"
    puts "3. Save the list to students.csv"
    puts "4. Load the list from students.csv"
    puts "9. Exit"
end

def show_students
    print_header
    print_student_list
    print_footer
end 

def interactive_menu
     process(gets.chomp)
end

def save_students
    # opens file for writing
    file = File.open("students.csv", "w")
    # iterates over the array of students
    @students.each do |student|
        student_data = [student[:name], student[:cohort], student[:age], student[:birth_country], student[:hobbies]]
        csv_line = student_data.join(",")
        file.puts csv_line
    end
    file.close
end

def load_students(filename = "students.csv")
    file = File.open(filename, "r")
    file.readlines.each do |line|
        name, cohort, age, birth_country, hobbies = line.chomp.split(',')
        add_info(name, cohort, age, birth_country, hobbies)
end
    file.close
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  return if filename.nil? # get out of the method if it isn't given
  if File.exists?(filename) # if it exists
    load_students(filename)
     puts "** Loaded #{@students.count} from #{filename} **"
  else # if it doesn't exist
    puts "Sorry, #{filename} doesn't exist."
    exit # quits the program
  end
end

def add_info(name, cohort, age, birth_country, hobbies)
    @students << {name: name, cohort: cohort.to_sym, age: age, birth_country: birth_country, hobbies: hobbies}
end

try_load_students
interactive_menu



