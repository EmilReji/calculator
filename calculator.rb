require 'yaml'

LANGUAGE = 'en'.freeze
MESSAGES = YAML.load_file('calculator_messages.yml').freeze

def messages(message, lang = 'en')
  MESSAGES[lang][message]
end

def prompt(key)
  message = messages(key, LANGUAGE)
  Kernel.puts("=> #{message}")
end

def valid_integer?(num)
  num.strip.to_i.digits.reverse.join == num
  # doesn't work for multiple 0s in a string
end

def float?(input)
  input.to_f.to_s == input
  # doesn't work for 1. as it translates to 1.0
end

def valid_number?(num)
  valid_integer?(num) || float?(num)
end

def operation_to_message(op)
  message = case op
            when '1'
              'Adding'
            when '2'
              'Subtracting'
            when '3'
              'Multiplying'
            when '4'
              'Dividing'
            end
  # other code here
  message
end

def string_to_num(str)
  return str.to_i if valid_integer?(str)
  return str.to_f if float?(str)
end

def sum(num1, num2)
  string_to_num(num1) + string_to_num(num2)
end

def difference(num1, num2)
  string_to_num(num1) - string_to_num(num2)
end

def product(num1, num2)
  string_to_num(num1) * string_to_num(num2)
end

def quotient(num1, num2)
  return nil if string_to_num(num2).zero?
  string_to_num(num1) + string_to_num(num2)
end

prompt('welcome')
name = ''
loop do
  name = Kernel.gets().chomp()
  if name.strip().empty?()
    prompt('valid_name')
  else
    break
  end
end

Kernel.puts("Hi #{name}")

loop do
  number1 = nil
  loop do
    prompt('ask_first')
    number1 = Kernel.gets().chomp()
    if valid_number?(number1)
      break
    else
      prompt('invalid_num')
    end
  end

  number2 = nil
  loop do
    prompt('ask_second')
    number2 = Kernel.gets().chomp()
    if valid_number?(number2)
      break
    else
      prompt('invalid_num')
    end
  end

  # multi-line string
  operator_prompt = <<-MSG
  What operation would you like to perform?
  1) add
  2) subtract
  3) multiply
  4) divide
  MSG
  Kernel.puts(operator_prompt)
  operator = nil
  loop do
    operator = Kernel.gets().chomp()
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt('choices')
    end
  end

  Kernel.puts("#{operation_to_message(operator)} the two numbers...")

  puts number1
  puts number2
  result = case operator
           when '1'
             sum(number1, number2)
           when '2'
             difference(number1, number2)
           when '3'
             product(number1, number2)
           when '4'
             quotient(number1, number2)
  end
  if result.nil?
    puts "You can't divide by 0. Please re-enter your information."
    next
  end
  Kernel.puts("The result is #{result}")
  prompt('perform_again')
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end
prompt('end')
