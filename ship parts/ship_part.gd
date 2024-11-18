extends Node2D

@export var part_type = ""

func reparent_node(child, new_parent):
	var orignal_position = child.global_position
	get_parent().remove_child(child)
	new_parent.add_child(child)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# moving collisionpolygon to main rigidbody
	reparent_node($CollisionPolygon2D, self.get_parent())
	reparent()
