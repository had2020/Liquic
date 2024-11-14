extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func freeze_node(node):
	#node.visiblity = false  TODO change trans or visablity
	node.set_process(false)
	if node.get("sleeping") != null:
		node.sleeping = true
	node.set_physics_process(false)
	if node.get_child_count() != 0:
		var active_objects = node.get_children()
		for child in active_objects:
			freeze_node(child)

func unfreeze_node(node):
	node.set_process(true)
	if node.get("sleeping") != null:
		node.sleeping = false
	node.set_physics_process(true)
	if node.get_child_count() != 0:
		var active_objects = node.get_children()
		for child in active_objects:
			unfreeze_node(child)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Build Mode"):
		var active_objects = $Active.get_children()
		if Globals.build_mode == false:
			Globals.build_mode = true
			#print("Player entered Build Mode.")
			for child in active_objects:
				freeze_node(child)
		else:
			#print("Player exited Build Mode.")
			Globals.build_mode = false
			for child in active_objects:
				unfreeze_node(child)
	
	# Only quiters use this TODO change to small menu screen
	elif event.is_action("esc"):
			#get_tree().reload_current_scene() #reset
			get_tree().quit() #quit
