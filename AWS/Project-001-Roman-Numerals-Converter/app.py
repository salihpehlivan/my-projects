# Import Flask modules
from flask import Flask, render_template, request
# Create an object named app
app = Flask(__name__)

# convert the given number to the roman numerals
def convert_to_roman(received_number):
    roman = {1000:'M', 900:'CM', 500:'D', 400:'CD', 100:'C', 90:'XC',
    50:'L', 40:'XL', 10:'X', 9:'IX', 5:'V', 4:'IV', 1:'I'}

    roman_num = ''
    for i in roman.keys():
        roman_num += roman[i]*(received_number//i)
        received_number%=i

    return roman_num

# Create a function named 'index' which uses template file named 'index.html' 
# send three numbers as template variable to the app.py and assign route of no path ('/') 
not_valid = False
developer = 'Salih'
@app.route('/', methods = ['GET', 'POST'])
def index():
    if request.method == 'POST':
        mynumber1 = request.form.get('number')
        if not mynumber1.isdecimal():
            # not_valid = True
            return render_template('index.html', not_valid = True, developer_name = developer, methods = ['GET'])


        # if the number is between 1 and 3999, inclusively
        else :
            number = int(mynumber1)
            if 0 < number < 4000:
                number_roman = convert_to_roman(number)
                return render_template('result.html', number_decimal = number, number_roman = number_roman, developer_name = developer)           
            else:
                return render_template('index.html', not_valid = True, developer_name = developer, methods = ['GET']) 
    else: 
        return render_template('index.html', not_valid = not_valid, developer_name = developer)


# Add a statement to run the Flask application which can be reached from any host on port 80.
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)