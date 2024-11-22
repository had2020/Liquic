extends Node2D

# Preloaded ship parts list
@onready var bridge = preload("res://ship parts/Humanic/Bridge.tscn")
# End of preloaded ship parts list

var current_ship_parts

func spawn_part(part, location):
	var node = part.instantiate()
	node.global_position = location
	$RigidBody2D.add_child(node)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#spawn_part(bridge, Vector2(0.0,0.0)) #TODO brigde force spawn if missing
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
