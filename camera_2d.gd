extends Camera2D

# zoom speeds
var zooming_speed_mouse = 1.55
var zooming_speed_pan = 1.05

#zoom limts
var start_zoom = Vector2(5,5)
var min_zoomout = Vector2(1.0,1.0)
var max_zoomin = Vector2(12.0,12.0)

# build mode controls
var build_mode = false
var oringal_camera_position: Vector2
# 0=W, 1=A, 2=S, 3=D
var directionals = [false, false, false, false]
var directional_move = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.zoom = start_zoom

const build_mode_move_speed = 0.1

func handle_build_move():
	var motion_change_vector = Vector2(0,0) # holds all the movement changes
	
	if directionals[0]: # Foward
		motion_change_vector.y += 1.0
		print("Fow") #TODO fix error here!
	if directionals[1]: # Left
		motion_change_vector.x -= 1.0
		print("Left")
	if directionals[2]: # Backward
		motion_change_vector.y -= 1.0
		print("Back")
	if directionals[3]: # Right
		motion_change_vector.x += 1.0
		print("Right")
	
	self.global_position = motion_change_vector

func _input(event):
	# Scrolling TODO add max zoom out or in
	if event is InputEventPanGesture:
		if event.delta.y > 0 and zoom < max_zoomin:
			self.zoom = self.zoom * zooming_speed_pan
		elif event.delta.y < 0 and zoom > min_zoomout:
			self.zoom = self.zoom / zooming_speed_pan
	
	# Middle Mouse scrolling
	elif event.is_action_pressed("ZoomIn") and zoom < max_zoomin:
		self.zoom = self.zoom * zooming_speed_mouse
	elif event.is_action_pressed("ZoomOut") and zoom > min_zoomout:
		self.zoom = self.zoom / zooming_speed_mouse
	
	# Build Mode
	if event.is_action_pressed("Build Mode"):
		if build_mode == true:
			oringal_camera_position = self.global_position
			build_mode = true
		if build_mode == false:
			self.global_position = oringal_camera_position
			build_mode = false
	
	# Build Mode controls
	# pressed
	if event.is_action_pressed("Forward"):
			directionals[0] = true 
			directional_move = true
	if event.is_action_pressed("Backward"):
			directionals[2] = true
			directional_move = true
	if event.is_action_pressed("Left"):
			directionals[1] = true
			directional_move = true
	if event.is_action_pressed("Right"):
			directionals[3] = true
			directional_move = true
	# released 
	if event.is_action_released("Forward"):
			directionals[0] = true
			directional_move = false
	if event.is_action_released("Backward"):
			directionals[2] = true
			directional_move = false
	if event.is_action_released("Left"):
			directionals[1] = true
			directional_move = false
	if event.is_action_released("Right"):
			directionals[3] = true
			directional_move = false
	
	# handling movement input
	if directional_move == true:
		handle_build_move()
