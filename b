import RPi.GPIO as GPIO
import time

# Set GPIO numbering mode
GPIO.setmode(GPIO.BCM)

# Set GPIO pin for the servo
servo_pin = 17

# Set PWM parameters
GPIO.setup(servo_pin, GPIO.OUT)
pwm = GPIO.PWM(servo_pin, 50)  # 50 Hz (20 ms period)

# Start PWM
pwm.start(0)  # Initialize servo at 0 degree position

try:
    while True:
        # Move servo to 0 degree position
        pwm.ChangeDutyCycle(2.5)  # 0 degree
        time.sleep(1)
        
        # Move servo to 90 degree position
        pwm.ChangeDutyCycle(7.5)  # 90 degree
        time.sleep(1)

        # Move servo to 180 degree position
        pwm.ChangeDutyCycle(12.5)  # 180 degree
        time.sleep(1)

except KeyboardInterrupt:
    pass

# Cleanup
pwm.stop()
GPIO.cleanup()
