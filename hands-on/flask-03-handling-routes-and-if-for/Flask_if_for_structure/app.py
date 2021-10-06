from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def head():
    msg = 'This is my first conditional Flask render experience'
    return render_template('index.html', message = msg)

@app.route('/pehlivan')
def mylist():

    my_list = ['Salih', 'Hatice', 'Ahmet', 'Serra', 'Feyza']
    return render_template('body.html', object = my_list)



if __name__ == '__main__':
    # app.run(debug=True)
    app.run(host='0.0.0.0', port=80)