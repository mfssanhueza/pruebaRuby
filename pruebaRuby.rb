option = -1
while option != 4
  puts 'Bienvenido al menú, ingrese el número de su opción:'
  puts 'Para generar archivo con promedio de notas, escriba 1'
  puts 'Para ver total de inasistencias, escriba 2'
  puts 'Para ver listado de alumnos aprobados, escriba 3'
  puts 'Para salir, escriba 4'

  file = File.open('pruebaRuby.txt', 'r')
  lines = file.readlines
  array = []
  lines.each do |ele|
    array.push(ele.gsub('\n', '').gsub(',','').split(' '))
  end
  names = (array.map { |ele| ele[0] })
  grades = array.each(&:shift)
  grades = grades.map {|ele| ele.reject{|x| x == 'A'}}
  numeric_grades = grades.map{|ele| ele.map(&:to_i)}
  print numeric_grades
  names_grades = Hash[names.zip(numeric_grades)]
  print names_grades
  file.close

  option = gets.chomp.to_i

  if option == 1
    suma = numeric_grades.flatten.length
    print suma
    names_grades.keys.each {|key| puts "#{key}: 6,3"}


    # file = File.new('promedios.txt', 'w')
    # names.each {|name| puts "el promedio de #{name} es "}
    # file.close

  elsif option == 2
    puts 'Hola'
  else
    puts 'Chao'
  end
end
