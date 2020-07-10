def prompt(message)
  Kernel.puts("=> #{message}")
end

def integer?(num)
  num.strip.to_i.digits.reverse.join == num
  # doesn't work for multiple 0s in a string
end

def float?(input)
  input.to_f.to_s == input
  # doesn't work for 1. as it translates to 1.0
end

def valid_number?(num)
  integer?(num) || float?(num)
end

prompt('Welcome to my Mortgage Calculator!')
loop do
  loan_amount = ''
  loop do
    prompt('Please enter your loan amount:')
    loan_amount = Kernel.gets().chomp()
    break if valid_number?(loan_amount) && loan_amount.to_i > 0
    prompt('Your loan amount is invalid. Please try again.')
  end

  apr = ''
  loop do
    prompt('Please enter your APR in percent format (Must be between 0 and 100):')
    apr = Kernel.gets().chomp()
    break if valid_number?(apr) && 0.0 <= apr.to_f && apr.to_f <= 100.0
    prompt('Your APR is invalid. Please try again.')
  end

  duration_months = ''
  loop do
    prompt('Please enter your loan duration in months:')
    duration_months = Kernel.gets().chomp()
    break if valid_number?(duration_months) && duration_months.to_i > 0
    prompt('Your duration is invalid. Please try again')
  end

  monthly_interest = apr.to_f / 100 / 12

  denominator = (1 - (1 + monthly_interest)**-duration_months.to_i)
  monthly_payment = loan_amount.to_i * (monthly_interest / denominator)

  prompt("Your monthly payment is $#{monthly_payment.round(2)}")
  prompt('Would you like to try again? Y/N')

  to_repeat = Kernel.gets().chomp()
  break unless to_repeat.downcase().start_with?('y')
end
