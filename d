import RPi.GPIO as GPIO
import time

# Set GPIO numbering mode
GPIO.setmode(GPIO.BCM)

# Set GPIO pin for the servo
servo_pin = 17

# Set PWM parameters
GPIO.setup(servo_pin, GPIO.OUT)
pwm = GPIO.PWM(servo_pin, 50)  # 50 Hz (20 ms period)

# Function to convert angle to duty cycle
def angle_to_duty_cycle(angle):
    return 2.5 + (angle / 18.0)

# Start PWM
pwm.start(0)  # Start PWM with 0% duty cycle

# Move to 0 degree position initially
pwm.ChangeDutyCycle(angle_to_duty_cycle(0))
time.sleep(1)  # Give time to move to initial position

try:
    while True:
        # Rotate from 0 to 9 degrees
        for angle in range(0, 10):  # 0 to 9 degrees
            duty_cycle = angle_to_duty_cycle(angle)
            pwm.ChangeDutyCycle(duty_cycle)
            print("Rotated to", angle, "degrees")  # Print the current angle
            time.sleep(1)  # Wait for 1 second

        # Rotate back from 9 to 0 degrees
        for angle in range(9, -1, -1):  # 9 to 0 degrees
            duty_cycle = angle_to_duty_cycle(angle)
            pwm.ChangeDutyCycle(duty_cycle)
            print("Rotated to", angle, "degrees")  # Print the current angle
            time.sleep(1)  # Wait for 1 second

except KeyboardInterrupt:
    pass

# Cleanup
pwm.stop()
GPIO.cleanup()
