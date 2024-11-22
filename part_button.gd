extends Button

@export var part_type = ""

# part list
@onready var brigde = preload("res://ship part reps/Bridge_rep.tscn")
# end of list

func _on_pressed() -> void:
	
	var self_parent = self.get_parent()
	
	var has_part = self_parent.has_part
	print("")
	if !has_part:#TODO match for part-type to list
		var node = brigde.instantiate()
		self_parent.add_child(node)

func _on_button_up() -> void:
	visible = true

func _on_button_down() -> void:
	visible = false
