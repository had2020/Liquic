extends Node2D

@onready var build_belt = preload("res://build_belt.tscn")

var setup_belt_on_camera = false

func spawn_build_belt(cam):
	#print(cam) # Debug
	var node = build_belt.instantiate()
	node.global_position = cam.global_position
	add_child(node)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if setup_belt_on_camera == false:
		var Global_cam = Globals.camera_node
		if Global_cam != null:
			setup_belt_on_camera = true
			spawn_build_belt(Global_cam)
