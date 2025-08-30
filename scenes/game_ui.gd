extends Node2D

var button_type = null

@onready var fade_transition: ColorRect = $%"Fade_transition"
@onready var fade_timer: Timer = $"../Fade_transition/Fade_timer"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_menu_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
	
	
	
func _on_exit_pressed() -> void:
	get_tree().quit()


	
