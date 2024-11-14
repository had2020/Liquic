extends RigidBody2D

var last_mouse_pos = Vector2(0,0)

@export var max_speed = 1000

# dirctional-conditionals
var directional_change = false
var directional = 0 # 0 null, 1, foward, 2 back, 3 left, 4 right, 5 left stafe, 6 right stafe

# 1, foward, 2 back, 3 left, 4 right
var thrusts_array = [10.0, 10.0, 10.0, 10.0]

# Rotation trust factor
var rotational_trust:float = 10.0



# The input actions for controlling the body
var input_up = "Foward"
var input_down = "Backward"
var input_left = "Left"
var input_right = "Right"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	'''
	# Rotation
	var direction = (last_mouse_pos - global_position).normalized() #calulate direction
	var angle_to_target:float = direction.angle()
	var angle_differnence:float = wrapf(angle_to_target - rotation, -PI, PI)
	#self.angular_velocity = angle_differnence * rotational_trust
	apply_torque_impulse(angle_differnence * rotational_trust)
	var forward_direction = Vector2(cos(rotation), sin(rotation)) # Forward direction based on rotation
	apply_central_impulse(forward_direction) #* thrusts_array[0])
	'''
	
	var input_vector = Vector2.ZERO
	#input strengths
	input_vector.y += Input.get_action_strength(input_up) - Input.get_action_strength(input_down)
	input_vector.x += Input.get_action_strength(input_right) - Input.get_action_strength(input_left)
	input_vector = input_vector.normalized()

	# rotation
	var mouse_pos = get_global_mouse_position()
	if mouse_pos != last_mouse_pos:
		last_mouse_pos = mouse_pos
		# Apply a torque to the body to make it rotate
		var torque = -input_vector.x * angular_velocity
		apply_torque(torque)
		#self.look_at(mouse_pos) # TODO change mouse point  with engine force and lerp
	
	'''
	#thursters
	if directional_change:
		match directional:
			0: # null
				pass
			1: # foward                    #TODO 0 changes direction
				self.apply_central_force(Vector2(0,-thrusts_array[0]))
			2: # back
				self.apply_impulse(Vector2(0,thrusts_array[1]))
			3: # left
				self.apply_impulse(Vector2(-thrusts_array[2],0))
			4: # right
				self.apply_impulse(Vector2(thrusts_array[3],0))
			5: # stafe left
				self.apply_impulse(Vector2(thrusts_array[2]/2,thrusts_array[2]/2))
			6: # stafe right
				self.apply_impulse(Vector2(thrusts_array[3]/2,thrusts_array[3]/2))
	'''
	# Limit the body speed
	var speed = linear_velocity.length()
	if speed > max_speed:
		linear_velocity = linear_velocity.normalized() * max_speed

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Foward"):
		directional = 1
		directional_change = true
	if event.is_action_released("Foward"):
		directional = 0;
		directional_change = true
