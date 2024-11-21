extends Button

@export var part_type = ""
@onready var base = preload("res://ship part reps/base_part_rep.tscn")

# part icons list
#TODO
# end of list

func _on_pressed() -> void:
	
	var myparent = self.get_parent().has_part #TODO has part tracking bool
	var node = base.instantiate()
	add_child(node)

func _on_button_up() -> void:
	visible = true

func _on_button_down() -> void:
	visible = false
