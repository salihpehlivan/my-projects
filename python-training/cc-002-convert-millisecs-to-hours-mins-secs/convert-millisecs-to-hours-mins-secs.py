


def convert_ms(ms):
    hour = {3600000:" hour/s ", 60000:" minute/s ", 1000:' second/s '}

    result = ""

    if ms < 1000:
        result =  'just '+ str(ms) +' millisecond/s'
    else:
        for i in hour.keys():
            if ms//i != 0:
                result += str(ms//i)+hour[i]
            ms%=i 

    return result

    

test = int(input('enter a number: '))

print(convert_ms(test))

