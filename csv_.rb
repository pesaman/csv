require 'faker'
require 'csv'

class People
  attr_accessor :first_name, :last_name, :email, :phone_number, :created_at
  def initialize(first_name, last_name, email, phone_number, created_at)
      @first_name = first_name
      @last_name = last_name
      @email = email
      @phone_number = phone_number
      @created_at = created_at
  end
end

def persons(number)
    array = []
    for i in 0..number
      array <<  People.new(Faker::Name.first_name, Faker::Name.last_name, Faker::Internet.email, Faker::PhoneNumber.phone_number, Time.now)
     end
    array 
end
people = persons(20)

class PersonWriter
  def initialize(file,list)
      @file = file
      @list = list
  end

  def create_csv
      CSV.open(@file, "wb") do |csv|
         @list.each do |person|
           csv << [person.first_name, person.last_name, person.email, person.phone_number, Time.now]                 
         end
      end
   end
end

class PersonParser 

  def initialize(files)
    @files = files
    @person = []
  end

  def people
     CSV.foreach(@files).each do |person|
       @person << People.new(person[0], person[1], person[2], person[3], person[4])
     end

     p @person[0..9]
  end
end

class PersonSearch
  
 # puts "¿busca el nombre a cambiar?"  
 # @nam = gets.chomp
  def initialize(file, name)
    @file = file
    @name = name
  end

  def get_data
    person_list = []
    CSV.foreach(@file).each do |person|
      person_list << People.new(person[0], person[1], person[2], person[3], person[4])
    end
    person_list
  end

  def remp_name(new_name)
   
    people_list = get_data
    people_list.each do |person|
    person.first_name = new_name if person.first_name == @name
    end
    p save_list(people_list)
  end

  def save_list(list)
    @list=list
    CSV.open(@file, "wb") do |csv|
      @list.each do |person|
        csv << [person.first_name, person.last_name, person.email, person.phone_number, Time.now]                 
      end
    end
  end
 
  #preguntar nombre a buscar
  #nuevo nombre
  #leer csv
  #obtienes arreglo objetos persona
  #encuentras nombre
  #modificas nombre
  #guardas nuevo arreglo
end

# person_writer = PersonWriter.new("people.csv", people)
# person_writer.create_csv

# parser = PersonParser.new('people.csv')
# people = parser.people

parser = PersonSearch.new('people.csv', "DarthVader")
new_array = parser.remp_name("campanita")

# person_writer = PersonWriter.new("people.csv", new_array)
# person_writer.create_csv




