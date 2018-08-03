option = -1
def aprobados (hash, nota)
  hash.each do |key, data|
    suma = data.inject(0) { |sum, x| sum + x }
    average = suma.to_f / data.length
    puts "#{key} aprobó con #{average}." if average >= nota
  end
end
while option != 4
  puts 'Bienvenido al menú:'
  puts 'Para generar archivo con promedio de notas, escriba 1'
  puts 'Para ver total de inasistencias, escriba 2'
  puts 'Para ver listado de alumnos aprobados, escriba 3'
  puts 'Para salir, escriba 4'
  puts 'Ingrese su opción:'

  file = File.open('pruebaRuby.txt', 'r')
  lines = file.readlines
  array = []
  lines.each do |ele|
    array.push(ele.gsub('\n', '').gsub(',','').split(' '))
  end
  names = (array.map { |ele| ele[0] })
  raw_data = array.each(&:shift)
  absence = raw_data.map { |ele| ele.select { |x| x == 'A' } }
  grades = raw_data.map { |ele| ele.reject { |x| x == 'A' } }
  numeric_grades = grades.map { |ele| ele.map(&:to_i) }
  ordered_data = Hash[names.zip(numeric_grades)]
  file.close
  option =  gets.chomp.to_i

  if option == 1
    file = File.new('promedios.txt', 'w')
    ordered_data.each do |key, data|
      suma = data.inject(0) { |sum, x| sum + x }
      average = suma.to_f / data.length
      file.puts "#{key}: #{average}"
    end
    file.close
    puts 'El archivo con nombres y promedios de alumnos se generó exitosamente'

  elsif option == 2
    puts "En total, ha habido #{absence.flatten.count} inasistencias a pruebas"
  elsif option == 3
    aprobados(ordered_data, 5)
  elsif option == 4
  else
    puts 'Opción inválida, por favor intente nuevamente'
  end
end
