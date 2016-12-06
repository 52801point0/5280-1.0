import RPi.GPIO as GPIO
import time

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(9,GPIO.OUT)
GPIO.setup(10,GPIO.OUT)
GPIO.setup(11,GPIO.OUT)

while(True):
    GPIO.output(9,GPIO.HIGH) # 9 on
    time.sleep(0.001)
    GPIO.output(9,GPIO.LOW) # 9 off

    GPIO.output(10,GPIO.HIGH) # 10 on
    time.sleep(0.001)
    GPIO.output(10,GPIO.LOW) # 10 off

    GPIO.output(11,GPIO.HIGH) # 11 on
    time.sleep(0.001)
    GPIO.output(11,GPIO.LOW) # 11 off

