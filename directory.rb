require 'date'

def print_header
  header = "The students of Villains Academy"
  puts header.center(header.length)
  puts "-------------".center(header.length)
end

def filter_students
 puts "With which letter does the names you wish to search for begin?"
 puts "To search for all names, just hit return."
 @initial = gets.gsub(/\n/,"")
end

def twelve_chars(students)
 puts "Would you like to search for students whose names are shorter than 12 characters? (Y/N)"
 response = gets.gsub(/\n/,"").upcase
 short_names = students.select {|student| student[:name].length < 12}
 response == "Y" ? print(short_names) : print(students)
end

def print(students)
   if students != []
   cohort_months = students.map{|entry| entry[:cohort]}.uniq
   cohort_months.each do |month|
     puts "#{month} cohort"
     students.select{|student| student[:cohort] == month
     }.each_with_index do |student, i|
       puts "#{i + 1}. #{student[:name]}; Age: #{student[:age]}; Birth Country: #{student[:birth_country]}; Hobbies: #{student[:hobbies]}"
     end
   end
  end
end

def print_footer(students)
    if students.count > 1 || students.count == 0
puts "Overall, we have #{students.count} students."
else 
    puts "Overall, we have #{students.count} student."
end
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  
  students = []
  
  name = gets.gsub(/\n/,"")
  
    while !name.empty? do
      
     puts "Please submit the following extra information for this student."
         puts "Which cohort is #{name} part of?"
     cohort = gets.gsub(/\n/,"").capitalize
     if cohort == ""
       cohort = "november"
     else
      until Date::MONTHNAMES.include? cohort
         puts "Please enter a valid cohort."
         cohort = gets.chomp.capitalize
       end
     end
     cohort = cohort.to_sym
     
     puts "#{name}'s age:"
     age = gets.gsub(/\n/,"")
     puts "#{name}'s country of birth:"
     birthcountry = gets.gsub(/\n/,"")
     puts "#{name}'s hobbies:"
     hobbies = gets.gsub(/\n/,"")
     
    
    students << {name: name, cohort: cohort, age: age, birth_country: birthcountry, hobbies: hobbies}
    if students.count > 1 || students.count == 0
        puts "Now we have #{students.count} students"
    else
        puts "Now we have #{students.count} student"
    end
    
    puts "Enter next name:"
    name = gets.gsub(/\n/,"")
  end
  
  
  students
end



students = input_students

filter_students
print_header
print(students)
print_footer(students)
twelve_chars(students)