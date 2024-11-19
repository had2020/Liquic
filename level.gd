extends Node2D

@onready var build_scene = preload("res://build_mode_level.tscn")
var loaded_scene
@onready var build_belt = preload("res://build_belt.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func freeze_node(node):
	#node.visiblity = false  TODO change trans or visablity or ordering
	if not node.is_in_group("non-build-freeze"):
		if node.is_in_group("hide_when_frooze"):
			node.visible = false
		if node.is_in_group("player"):
			$Active/Player/CollisionShape2D.disabled = true
		node.set_process(false)
		if node.get("sleeping") != null:
			node.sleeping = true
		node.set_physics_process(false)
		if node.get_child_count() != 0:
			var active_objects = node.get_children()
			for child in active_objects:
				freeze_node(child)
	elif node.is_in_group("camera"):
		var camera = node
		$Build_mode_level.current_camera_node = camera

func unfreeze_node(node):
	if not node.is_in_group("non-build-freeze"):
		if node.is_in_group("hide_when_frooze"):
			node.visible = true
		if node.is_in_group("player"):
			$Active/Player/CollisionShape2D.disabled = false
		node.set_process(true)
		if node.get("sleeping") != null:
			node.sleeping = false
		node.set_physics_process(true)
		if node.get_child_count() != 0:
			var active_objects = node.get_children()
			for child in active_objects:
				unfreeze_node(child)

func spawn_build_level():
	var node = build_scene.instantiate()
	node.global_position = $Active/Player.global_position
	add_child(node)
	loaded_scene = node

func despawn_build_level():
	loaded_scene.queue_free()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Build Mode"):
		var active_objects = $Active.get_children()
		if Globals.build_mode == false:
			#var blue_color = Color(0, 0, 0, 0.1) 
			$Active.modulate.a = 0.1
			Globals.build_mode = true
			spawn_build_level()
			#print("Player entered Build Mode.")
			for child in active_objects:
				freeze_node(child)
		else:
			#print("Player exited Build Mode.")
			Globals.build_mode = false
			$Active.modulate.a = 1
			despawn_build_level()
			for child in active_objects:
				unfreeze_node(child)
	
	# Only quiters use this TODO change to small menu screen
	elif event.is_action("esc"):
			#get_tree().reload_current_scene() #reset
			get_tree().quit() #quit
