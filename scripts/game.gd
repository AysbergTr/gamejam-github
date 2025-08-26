extends Node2D

@onready var clicking_sound: AudioStreamPlayer2D = $ClickingSound

const CLICKING_PARTICLE = preload("res://scenes/clicking_particle.tscn")

@onready var camera: Camera2D = $Camera2D
@export var RANDOM_SHAKE_STRENGTH: float = 30.0
@export var SHAKE_DECAY_RATE: float = 5.0

@onready var camera_2d: Camera2D = $Camera2D
@onready var rand = RandomNumberGenerator.new()

var shake_strength: float = 0.0

func _ready() -> void:
	rand.randomize()
	#apply_button.connect("pressed", self, "apply_shake")

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

func find_color():
	var viewport_tex = get_viewport().get_texture()
	var img = viewport_tex.get_image()
	var mouse_pos = get_viewport().get_mouse_position()
	
	var color = img.get_pixel(mouse_pos.x, mouse_pos.y)
	#inverse
	var inverse = Color(1.0 - color.r, 1.0 - color.g, 1.0 - color.b, color.a)

	return inverse
	
func spawn_particle():
	var fx = CLICKING_PARTICLE.instantiate()
	add_child(fx)
	fx.global_position = get_global_mouse_position()
	fx.one_shot = true
	fx.emitting = true
	fx.color = find_color()
	
func _input(event):
	if event.is_action_pressed("click"):
		#print("Mouse Click/Unclick at: ", event.position)
		clicking_sound.play()
		spawn_particle()
		apply_shake()
