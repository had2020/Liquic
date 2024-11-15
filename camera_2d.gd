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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	# Scrolling TODO add max zoom out or in
	if event is InputEventPanGesture:
		if event.delta.y > 0 and zoom < max_zoomin:
			self.zoom = self.zoom * zooming_speed_pan
		elif event.delta.y < 0 and zoom > min_zoomout:
			self.zoom = self.zoom / zooming_speed_pan
	elif event.is_action_pressed("ZoomIn") and zoom < max_zoomin:
		self.zoom = self.zoom * zooming_speed_mouse
	elif event.is_action_pressed("ZoomOut") and zoom > min_zoomout:
		self.zoom = self.zoom / zooming_speed_mouse
	if event.is_action_pressed("Build Mode"):
		if build_mode == true:
			oringal_camera_position = self.position
			build_mode = true
		if build_mode == false:
			build_mode = false
