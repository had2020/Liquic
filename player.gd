extends RigidBody2D

var move_speed = Vector2(100,0)

var last_mouse_pos = Vector2(0,0)

# dirctional-conditionals
var directional_change = false
var direction = 0 # 0 null, 1, foward, 2 back, 3 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# rotation
	var mouse_pos = get_global_mouse_position()
	if mouse_pos != last_mouse_pos:
		last_mouse_pos = mouse_pos
		self.look_at(mouse_pos)
	#thursters
	if directional_change:
		match 

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Foward"):
		self.apply_impulse(move_speed)
	if event.is_action_released("Foward"):
		
