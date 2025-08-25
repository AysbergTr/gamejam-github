extends Area2D

const NEEDLE = preload("res://assets/Needle.png")
const USUAL_CURSOR = preload("res://assets/hand_small_point.png")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



func _on_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(NEEDLE, Input.CURSOR_ARROW, Vector2(24, 36))

func _on_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(USUAL_CURSOR, Input.CURSOR_ARROW, Vector2(8, 8)) 
