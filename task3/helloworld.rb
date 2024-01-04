def is_prime(num)
    return false if num < 2
  
    (2..Math.sqrt(num).to_i).each do |i|
      return false if num % i == 0
    end
  
    true
  end
  
  print "Enter a number: "
  n = gets.chomp.to_i
  
  puts "Prime numbers up to #{n}:"
  (2..n).each do |i|
    puts i if is_prime(i)
  end
  