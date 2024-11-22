extends Node2D

var over_part = false
var grabbed_part
var grab_position 
var grabbing = false
var last_area_over

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.global_position = get_global_mouse_position()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("part"):
		over_part = true
		last_area_over = area

func _on_area_2d_area_exited(area: Area2D) -> void:
	over_part = false

func set_grab(area):
	var node = area.get_parent()
	grabbed_part = node
	grab_position = self.global_position

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Left Click"):
		if !grabbing:
			set_grab(last_area_over)
		
	if event.is_action_released("Left Click"):
		pass # TODO let go
