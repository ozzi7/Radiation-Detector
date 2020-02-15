from datetime import datetime
import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BOARD)
GPIO.setup(13, GPIO.IN) # This is connected to the pin on the Geiger counter which outputs 3v when it blips.

min = 0
while True: # While loop to keep the program running indefinitely.
        count = 0
        currentMinute = datetime.now().minute # saves the current minute of the day
        while datetime.now().minute == currentMinute: # AKA during the minute
                if GPIO.input(13) == True: # If the geiger counter blips, increment the count variable by 1.
                        count += 1
                while GPIO.input(13) == True:
                        pass

        print str(count) + " => " + str(0.0057*count) + "uS/h"  # print to the screen the amount of times the Geiger Counter bliped during the minute.
        if min != 0:
                with open("detections.txt", 'a') as f:
                        ts = time.time()
                        sttime = datetime.fromtimestamp(ts).strftime('%Y-%m-%d_%H:%M:%S')

                        f.write(sttime + " " + str(min) + " " + str(count) + " " + str(0.0057*count) + "\n")
        count = 0 # Reset the count value to be ready for the next loop around.
        min += 1
