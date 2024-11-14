extends Camera2D

var zooming_speed_mouse = 1.55
var zooming_speed_pan = 1.0

var start_zoom = Vector2(5,5)
var min_zoomout = Vector2(1.0,1.0)
var max_zoomin = Vector2(12.0,12.0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.zoom = start_zoom


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	# Scrolling TODO add max zoom out or in
	if event is InputEventPanGesture:
		if event.delta.y > 0 and zoom > max_zoomin:
			self.zoom = self.zoom * zooming_speed_pan
		elif event.delta.y < 0 and zoom < min_zoomout:
			self.zoom = self.zoom / zooming_speed_pan
	elif event.is_action_pressed("ZoomIn") and zoom < max_zoomin:
		self.zoom = self.zoom * zooming_speed_mouse
	elif event.is_action_pressed("ZoomOut") and zoom > min_zoomout:
		self.zoom = self.zoom / zooming_speed_mouse
	
	elif event.is_action("esc"):
			#get_tree().reload_current_scene() #reset
			get_tree().quit() #quit
