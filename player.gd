extends RigidBody2D

var last_mouse_pos = Vector2(0,0)

# dirctional-conditionals
var directional_change = false
var directional = 0 # 0 null, 1, foward, 2 back, 3 left, 4 right, 5 left stafe, 6 right stafe

# 1, foward, 2 back, 3 left, 4 right
var thrusts_array = [10.0, 10.0, 10.0, 10.0]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# rotation
	var mouse_pos = get_global_mouse_position()
	if mouse_pos != last_mouse_pos:
		last_mouse_pos = mouse_pos
		self.look_at(mouse_pos) # TODO change mouse point  with engine force and lerp
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

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Foward"):
		directional = 1
		directional_change = true
	if event.is_action_released("Foward"):
		directional = 0;
		directional_change = true
