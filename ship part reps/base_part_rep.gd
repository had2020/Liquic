extends Node2D

@export var part_type = ""

func drop():
	pass

func _process(delta: float) -> void:
	self.position = Globals.build_mode_curosr.position #TODO add offset

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("Left Click"):
		drop()
