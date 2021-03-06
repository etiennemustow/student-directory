require 'date'
@students = [] # an empty array accessible to all methods

def print_header 
  header = "The students of Makers Academy"
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
       puts "#{i + 1}. #{student[:name]}: Age: #{student[:age]}; Birth Country: #{student[:birth_country]}; Hobbies: #{student[:hobbies]}"
     end
   end
   end
end

def print_footer
    if @students.count == 1
    puts "\nOverall, we have #{@students.count} student."
    else 
    puts "\nOverall, we have #{@students.count} students."
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
            puts "Program ended"
            exit #this will terminate the program
        else 
            puts "I don't know what you meant. Please, try again"
        end
    end
end
 
def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return "
  name = STDIN.gets.chomp
  
    while !name.empty? do
    puts "Please submit the following extra information for this student."
    puts "Which cohort is #{name} part of?"
    cohort = gets.chomp.capitalize
    if cohort == ""? cohort = "November" : cohort = valid_cohort(cohort)
    extra_info(name)
    add_info(name, cohort, @age, @birth_country, @hobbies)
    student_count
    puts "\nPlease, enter next name:" 
    name = STDIN.gets.chomp
    end
    @students
    end
end

def extra_info(name)
     puts "#{name}'s age:"
     @age = STDIN.gets.chomp
     puts "#{name}'s country of birth:"
     @birth_country = STDIN.gets.chomp
     puts "#{name}'s hobbies:"
     @hobbies = STDIN.gets.chomp
end


def valid_cohort(cohort)
  until Date::MONTHNAMES.include? cohort
    puts "Please enter a valid cohort."
    cohort = STDIN.gets.chomp.capitalize
  end
  cohort = cohort.to_sym
end

def student_count
  if @students.count == 1
    puts "\nNow we have #{@students.count} student." # Updated with a new message
  else
    puts "\nNow we have #{@students.count} students."# Updated with a new message
  end
end

def print_menu
    puts "\n1. Input the students"
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
    puts "Press Enter to start"
    process(gets.chomp)
end

def save_students
    file = File.open("students.csv", "w")
    @students.each do |student|
        student_data = [student[:name], student[:cohort], student[:age], student[:birth_country], student[:hobbies]]
        csv_line = student_data.join(",")
        file.puts csv_line
    end
    file.close
    puts "students.csv saved!"
end

def load_students(filename = "students.csv")
    file = File.open(filename, "r")
    file.readlines.each do |line|
        name, cohort, age, birth_country, hobbies = line.chomp.split(',')
        add_info(name, cohort, age, birth_country, hobbies)
end
    file.close
    puts ""#{filename}" loaded!"
end

def try_load_students
  filename = ARGV.first # first argument from the command line
  filename = "students.csv" if filename.nil? # get out of the method if it isn't given
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
