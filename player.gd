extends RigidBody2D

var move_speed = Vector2(100,0)

var last_mouse_pos = Vector2(0,0)

# dirctional-conditionals
var directional_change = false
var directional = 0 # 0 null, 1, foward, 2 back, 3 left, 4 right, 5 left stafe, 6 right stafe

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
			1: # foward 
				self.apply_impulse(move_speed)
			2: # back
				self.apply_impulse(move_speed)
			3: # left
				self.apply_impulse(move_speed)
			4: # right
				self.apply_impulse(move_speed)
			5: # stafe left
				self.apply_impulse(move_speed)
			6: # stafe right
				self.apply_impulse(move_speed)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Foward"):
		directional = 1
		directional_change = true
	if event.is_action_released("Foward"):
		directional = 0;
		directional_change = true
