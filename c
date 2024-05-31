import RPi.GPIO as GPIO
import time

# Set up GPIO
GPIO.setmode(GPIO.BCM)

# Define GPIO pins
SENSOR_PIN = 17
SERVO_PIN = 22

# Set up sensor pin as input
GPIO.setup(SENSOR_PIN, GPIO.IN)

# Set up servo pin for PWM
GPIO.setup(SERVO_PIN, GPIO.OUT)
servo_pwm = GPIO.PWM(SERVO_PIN, 50)  # 50 Hz (20 ms period)
servo_pwm.start(0)  # Start PWM at 0 degree position

def move_servo(angle):
    duty_cycle = 2.5 + (angle / 18)
    servo_pwm.ChangeDutyCycle(duty_cycle)
    time.sleep(0.5)  # Adjust this delay as needed

try:
    while True:
        sensor_value = GPIO.input(SENSOR_PIN)
        if sensor_value == GPIO.LOW:
            print("Obstacle detected")
            # Move servo from 0 to 180 degrees
            for angle in range(0, 181, 45):
                move_servo(angle)
            # Move servo from 180 to 0 degrees
            for angle in range(180, -1, -45):
                move_servo(angle)
        else:
            print("No obstacle")
            # Move servo to 0 degrees
            move_servo(0)

except KeyboardInterrupt:
    print("Exiting program")

# Clean up GPIO
servo_pwm.stop()
GPIO.cleanup()
