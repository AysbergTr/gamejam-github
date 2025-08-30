extends Control

var button_type = null

@onready var button_click_sfx: AudioStreamPlayer2D = $Button_click

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		#fade out an
	$Fade_transition.color.a = 255
	$Fade_transition.show()
	$Fade_transition/Fade_timer.start()
	$Fade_transition/AnimationPlayer.play("FadeOut")

 
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	button_type = "start"
	$Fade_transition.show()
	$Fade_transition/Fade_timer.start()
	$Fade_transition/AnimationPlayer.play("FadeIn")
	button_click_sfx.play()
	
func _on_options_pressed() -> void:
	print("options")

func _on_exit_pressed() -> void:
	button_type = "exit"
	button_click_sfx.play()
	$Fade_transition.show()
	$Fade_transition/Fade_timer.start()
	$Fade_transition/AnimationPlayer.play("FadeIn")



func _on_fade_timer_timeout() -> void:
	if button_type == "start":
		get_tree().change_scene_to_file("res://scenes/game.tscn")
		
	elif button_type == "exit":
		get_tree().quit()
	
	else:
		$Fade_transition.hide()


func _on_back_pressed() -> void:
	$CreditsScreen.hide()
	button_click_sfx.play()

func _on_credits_pressed() -> void:
	$CreditsScreen.show()
	button_click_sfx.play()
