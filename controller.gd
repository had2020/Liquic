extends RigidBody2D
# forces applied when thrusting
#TODO use globals when storing spaceship states to update accordingly 
@export var horizontal_thrust = 50.0 # TODO update in a truster array that splits all directions
@export var rotational_trust = 0.03
@export var vertical_trust = 20.0

@export var max_speed = 1000

@export var damping = 0.01

# input actions for controlling the body
var input_up = "Foward"
var input_down = "Backward"
var input_left = "Left"
var input_right = "Right"

func _physics_process(delta):
	# Get the direction towards the mouse
	var target_direction = (get_global_mouse_position() - global_position).normalized()
	# Calculate the target angle
	var target_rotation = target_direction.angle()
	# Interpolate between the current rotation and the target rotation
	rotation = lerp_angle(rotation, target_rotation + 90.0, rotational_trust)
	#look_at(get_global_mouse_position()) works but without physic-like rotation trust
	#rotate(deg_to_rad(90))
	
	#directional keyboard movement horizontal
	var input_vector = Vector2.ZERO
	input_vector.y += Input.get_action_strength(input_up) - Input.get_action_strength(input_down)
	#input_vector.x += Input.get_action_strength(input_right) - Input.get_action_strength(input_left)
	input_vector = input_vector.normalized()
	
	var force = Vector2.UP.rotated(rotation) * input_vector.y * horizontal_thrust
	apply_central_force(force)

	# torque for rotation
	var torque = -input_vector.x * angular_velocity
	apply_torque(torque)
	
	# body speed imiter
	var speed = linear_velocity.length()
	if speed > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed
	
		#vertical-directional thrust
	if Input.is_action_pressed("Left"):
		apply_central_impulse(-Vector2(vertical_trust , 0)) # TODO update with rotation
	elif Input.is_action_pressed("Right"):
		apply_central_impulse(Vector2(vertical_trust, 0))
	
	# Apply a damping factor to the body's velocity
	linear_velocity *= 1.0 - damping

#func _unhandled_input(event: InputEvent) -> void: #TODO keep pushing while held
	#vertical-directional thrust
	#if event.is_action_pressed("Left"):
		#apply_central_impulse(-Vector2(vertical_trust , 0)) # TODO update with rotation
	#if event.is_action_pressed("Right"):
		#apply_central_impulse(Vector2(vertical_trust, 0))
