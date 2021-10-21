
# convert the given number to the roman numerals
def convert_to_roman(received_number):
    roman = {1000:"M", 900:"CM", 500:"D", 400:"CD", 100:"C", 90:"XC",
    50:"L", 40:"XL", 10:"X", 9:"IX", 5:"V", 4:"IV", 1:"I"}

    roman_num = ""
    for i in roman.keys():
        roman_num += roman[i]*(received_number//i)
        received_number%=i

    return roman_num

# flag to show warning to the user, default is False
is_invalid = False

while True:

    info = """
###  This program converts decimal numbers to Roman Numerals ###
(To exit the program, please type "exit")
Please enter a number between 1 and 3999, inclusively : """


    given_number = input('\nNot Valid Input !!!\n'*is_invalid + info).strip()
    
    # if the input is not decimal number
    if not given_number.isdecimal():
        # then check, if it is the "exit" keyword
        if given_number.lower() == 'exit':
            # if it is "exit", then say goodbye and terminate the program
            print('\nExiting the program... Good Bye')
            break
        
        # if it is a strint other than "exit"
        else:
            is_invalid = True
            continue
    
    number = int(given_number)
    # if the number is between 1 and 3999, inclusively
    if 0 < number < 4000:
        print(
            f'\nRoman numerals representation of decimal number "{number}"" is equal to {convert_to_roman(number)}')
        is_invalid = False

    # if the number is out of bounds
    else:
        # then set to invalid flag to True to show warning
        is_invalid = True