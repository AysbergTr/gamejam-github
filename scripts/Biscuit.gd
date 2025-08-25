extends Area2D

const NEEDLE = preload("res://assets/Needle.png")
const USUAL_CURSOR = preload("res://assets/hand_small_point.png")
@onready var clicking_sound: AudioStreamPlayer2D = $"../ClickingSound"
const COOKIE = preload("res://sfx/cookie.wav")
const CLICKING_SOUND = preload("res://sfx/clicking_sound.wav")

#Handles different sprites
@onready var sprite_2d: Sprite2D = $Sprite2D
@export_enum("Triangle", "Square", "Circle",
			 "Star", "Heart", "Pentagon", 
			 "Umbrella","Half Moon", "Lightning Bolt",
			 "Snowflake", "8 Point Star", "Skull") var CookieName

#ALL COOKIE SPRITES
const TRIANGLE_BISCUIT = preload("res://assets/Cookie Shapes/TriangleBiscuit.png")
const SQUARE_BISCUIT = preload("res://assets/Cookie Shapes/SquareBiscuit.png")
const CIRCLE_BISCUIT = preload("res://assets/Cookie Shapes/CircleBiscuit.png")
const STAR_BISCUIT = preload("res://assets/Cookie Shapes/StarBiscuit.png")
const HEART_BISCUIT = preload("res://assets/Cookie Shapes/HeartBiscuit.png")
const PENTAGON_BISCUIT = preload("res://assets/Cookie Shapes/PentagonBiscuit.png")
const UMBREALLA_BISCUIT = preload("res://assets/Cookie Shapes/UmbreallaBiscuit.png")
const MOON_BISCUIT = preload("res://assets/Cookie Shapes/MoonBiscuit.png")
const THUNDER_BISCUIT = preload("res://assets/Cookie Shapes/ThunderBiscuit.png")

var CookieShape := [TRIANGLE_BISCUIT, SQUARE_BISCUIT, CIRCLE_BISCUIT,
				   STAR_BISCUIT, HEART_BISCUIT, PENTAGON_BISCUIT,
				   UMBREALLA_BISCUIT, MOON_BISCUIT, THUNDER_BISCUIT]
func _ready() -> void:
	print(CookieName)
	sprite_2d.texture = CookieShape[CookieName]
	
func GameOver() -> void:
	print("Game over")


#All inside collisions options (its not a good code)
func _on_triangle_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if CookieName == 0:
		if event is InputEventMouseButton and event.is_pressed():
			GameOver()

func _on_square_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if CookieName == 1:
		if event is InputEventMouseButton and event.is_pressed():
			GameOver()

func _on_circle_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if CookieName == 2:
		if event is InputEventMouseButton and event.is_pressed():
			GameOver()

func _on_star_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if CookieName == 3:
		if event is InputEventMouseButton and event.is_pressed():
			GameOver()

func _on_heart_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if CookieName == 4:
		if event is InputEventMouseButton and event.is_pressed():
			GameOver()

func _on_pentagon_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if CookieName == 5:
		if event is InputEventMouseButton and event.is_pressed():
			GameOver()

#Changes the cursor image and the clicking sound
func _on_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(NEEDLE, Input.CURSOR_ARROW, Vector2(24, 36))
	clicking_sound.stream = COOKIE
func _on_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(USUAL_CURSOR, Input.CURSOR_ARROW, Vector2(8, 8)) 
	clicking_sound.stream = CLICKING_SOUND

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		#print("Mouse Click/Unclick at: ", event.position)
		pass
