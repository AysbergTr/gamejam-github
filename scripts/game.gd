extends Node2D

@onready var clicking_sound: AudioStreamPlayer2D = $ClickingSound


#camera shake
@onready var camera: Camera2D = $Camera2D
@export var RANDOM_SHAKE_STRENGTH: float = 30.0
@export var SHAKE_DECAY_RATE: float = 5.0

@onready var camera_2d: Camera2D = $Camera2D
@onready var rand = RandomNumberGenerator.new()
var shake_strength: float = 0.0


#particle effect
const CLICKING_PARTICLE = preload("res://scenes/clicking_particle.tscn")

@onready var biscuit: Area2D = $%Biscuit
const PARTICLE_COOKIE1 = preload("res://assets/particle_cookie.png")
var on_cookie = false
const PARTICLE_COOKIE = preload("res://assets/particle_cookie (1).png")


var badgeNumber :int = 0


func _ready() -> void:
	#fade out an
	$Fade_transition.color.a = 255
	$Fade_transition.show()
	$Fade_transition/Fade_timer.start()
	$Fade_transition/AnimationPlayer.play("FadeOut")

	#$Fade_transition.hide()
	
	rand.randomize()
	#apply_button.connect("pressed", self, "apply_shake")
	biscuit.connect("on_cookie", entered_cookie)
	biscuit.connect("off_cookie", exited_cookie)

func apply_shake() -> void:
	shake_strength = RANDOM_SHAKE_STRENGTH

func _process(delta: float) -> void:
	# Fade out the intensity over time
	shake_strength = lerp(shake_strength, 0.0, SHAKE_DECAY_RATE * delta)

	# Shake by adjusting camera.offset so we can move the camera around the level via it's position
	camera.offset = get_random_offset()

func get_random_offset() -> Vector2:
	return Vector2(
		rand.randf_range(-shake_strength, shake_strength),
		rand.randf_range(-shake_strength, shake_strength)
	)

func entered_cookie():
	on_cookie = true
	
func exited_cookie():
	on_cookie = false
	



func spawn_particle():
	var fx = CLICKING_PARTICLE.instantiate()
	add_child(fx)
	fx.global_position = get_global_mouse_position()
	fx.one_shot = true
	fx.emitting = true
	if on_cookie:
		fx.texture = PARTICLE_COOKIE
	else:
		fx.texture = null
	

func _input(event):
	if event.is_action_pressed("click"):
		#print("Mouse Click/Unclick at: ", event.position)
		clicking_sound.pitch_scale = randi_range(0.9, 1.1)
		clicking_sound.play()
		spawn_particle()
		apply_shake()


func _on_fade_timer_timeout() -> void:
	$Fade_transition.hide()

func GameWon() -> void:
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/end_won.tscn")


func GameOver() -> void:
	await get_tree().create_timer(2).timeout
	get_tree().change_scene_to_file("res://scenes/end_lost.tscn")

func _on_timer_out_of_time() -> void:
	GameOver()

func _on_biscuit_biscuit_lost() -> void:
	GameOver()


func _on_biscuit_biscuit_cleared(CookieName) -> void:
	badgeNumber += 1
	#print("badge Number:", badgeNumber)
	#print("Cookie Number:", CookieName)
	
	if badgeNumber >= 9:
		GameWon()
