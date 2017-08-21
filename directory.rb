def print_header
  puts "The students of Villains Academy"
  puts "-------------"
end

def which_letter
 puts "With which letter does the names you wish to search for begin?"
 puts "To search for all names, just hit return."
 @initial = gets.chomp.upcase
end

def twelve_chars(students)
 puts "Would you like to search for students whose names are shorter than 12 characters? (Y/N)"
 response = gets.chomp.upcase
 short_names = students.select {|student| student[:name].length < 12}
 response == "Y" ? print(short_names) : print(students)
end

def print(students)
   i = 0
while i < students.size
 puts "#{i + 1}. #{students[i][:name]} (#{students[i][:cohort]} cohort)"
  i += 1
end
end

def print_footer(students)
puts "Overall, we have #{students.count} great students"
end

def input_students
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  
  students = []
  
  name = gets.chomp
  
  while !name.empty? do
    
    students << {name: name, cohort: :november}
    puts "Now we have #{students.count} students"
    
    name = gets.chomp
  end
  
  
  students
end



students = input_students

which_letter
print_header
print(students)
print_footer(students)
twelve_chars(students)