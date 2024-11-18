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

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.zoom = start_zoom

func _physics_process(delta: float) -> void:
	pass

const build_mode_move_speed = 0.1

func _input(event):
	# Scrolling
	if event is InputEventPanGesture:
		if event.delta.y > 0 and zoom < max_zoomin:
			self.zoom = self.zoom * zooming_speed_pan
		if event.delta.y < 0 and zoom > min_zoomout:
			self.zoom = self.zoom / zooming_speed_pan
	
	# Middle Mouse scrolling
	if event.is_action_pressed("ZoomIn") and zoom < max_zoomin:
		self.zoom = self.zoom * zooming_speed_mouse
	if event.is_action_pressed("ZoomOut") and zoom > min_zoomout:
		self.zoom = self.zoom / zooming_speed_mouse
	
	# Build Mode
	if event.is_action_pressed("Build Mode"):
		if build_mode == false:
			oringal_camera_position = self.position
			build_mode = true
		elif build_mode == true:
			self.position = oringal_camera_position
			build_mode = false

const Move_speed = 10.0

func _unhandled_input(event: InputEvent) -> void:
	# Build move controls
	
	if build_mode:
		if event.is_action("Foward"):
				self.global_position += Vector2(0,-Move_speed)
		if event.is_action("Backward"):
				self.global_position += Vector2(0,Move_speed)
		if event.is_action("Left"):
				self.global_position += Vector2(-Move_speed,0)
		if event.is_action("Right"):
				self.global_position += Vector2(Move_speed,0)
