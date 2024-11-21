extends Node2D

@export var part_type = ""

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position = get_local_mouse_position()
