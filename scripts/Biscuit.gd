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
#shape list
var CookieShape := [TRIANGLE_BISCUIT, SQUARE_BISCUIT, CIRCLE_BISCUIT,
				   STAR_BISCUIT, HEART_BISCUIT, PENTAGON_BISCUIT,
				   UMBREALLA_BISCUIT, MOON_BISCUIT, THUNDER_BISCUIT]

#ALL COOKIE SYMBOL SPRITES
@onready var cookie_symbol: Sprite2D = $Cookie_symbol
const SYMBOL_TRIANGLE = preload("res://assets/symbols of ccokies/symbol_triangle.png")
const SYMBOL_SQUARE = preload("res://assets/symbols of ccokies/symbol_square.png")
const SYMBOL_CIRCLE = preload("res://assets/symbols of ccokies/symbol_circle.png")
const SYMBOL_STAR = preload("res://assets/symbols of ccokies/symbol_star.png")
const SYMBOL_HEART = preload("res://assets/symbols of ccokies/symbol_heart.png")
const SYMBOL_PENTAGON = preload("res://assets/symbols of ccokies/symbol_pentagon.png")
const SYMBOL_UMBRELLA = preload("res://assets/symbols of ccokies/symbol_umbrella.png")
const SYMBOL_MOON = preload("res://assets/symbols of ccokies/symbol_moon.png")
const SYMBOL_THUNDER = preload("res://assets/symbols of ccokies/symbol_thunder.png")

var CookieSymbolShape :=[SYMBOL_TRIANGLE, SYMBOL_SQUARE, SYMBOL_CIRCLE, 
						 SYMBOL_STAR, SYMBOL_HEART, SYMBOL_PENTAGON,
						 SYMBOL_UMBRELLA, SYMBOL_MOON, SYMBOL_THUNDER]

#All Segments
@onready var tri_segments: Node2D = $"Shape Collisions/Triangle/tri_segments"
@onready var sqr_segments: Node2D = $"Shape Collisions/Square/sqr_segments"
@onready var crc_segments: Node2D = $"Shape Collisions/Circle/crc_segments"
@onready var str_segments: Node2D = $"Shape Collisions/Star/str_segments"
@onready var hrt_segments: Node2D = $"Shape Collisions/Heart/hrt_segments"
@onready var pnt_segments: Node2D = $"Shape Collisions/Pentagon/pnt_segments"
@onready var umb_segments: Node2D = $"Shape Collisions/Umbrella/umb_segments"
@onready var mon_segments: Node2D = $"Shape Collisions/Moon/mon_segments"
@onready var thn_segments: Node2D = $"Shape Collisions/Thunder/thn_segments"
@onready var shape_collisions: Node2D = $"Shape Collisions"


var segments

#main collision
@onready var main_collision: CollisionShape2D = $CollisionShape2D


#Cracking variables
var clicked_segments := 0

#particle signals
signal on_cookie
signal off_cookie

#game won/lose signals
signal biscuitCleared #won
signal biscuitLost #lost

#lose condition-> if crack >= 3 
var _crack = 0 
@onready var cracks_img: Sprite2D = $BaseCrackedBiscuit
var alpha_value = 0

func _ready() -> void:
	#segment lists
	var segments_list = [tri_segments, sqr_segments, crc_segments, 
						 str_segments, hrt_segments, pnt_segments,
						 umb_segments, mon_segments, thn_segments]
	#choosing the segment for different cookies and making it visible so player can touch it
	segments = segments_list[CookieName]
	segments.visible = true
	
	#main sprite
	sprite_2d.texture = CookieShape[CookieName]
	
	#inside symbol sprite
	cookie_symbol.texture = CookieSymbolShape[CookieName]
	
	for child in segments.get_children():
		child.connect("clicked", _on_segment_clicked)

#Checks when a segment clicked
func _on_segment_clicked() -> void:
	clicked_segments += 1
	if clicked_segments == segments.get_children().size():
		GameWon()

func disableCollisions() -> void:
	main_collision.disabled = true
	shape_collisions.visible = false

func GameWon() -> void:
	disableCollisions()
	var tween = create_tween()
	print("All segments cleared")
	emit_signal("biscuitCleared")
	main_collision.disabled
	cookie_symbol.visible= true
	segments.visible = false
	
	#tween effects
	tween.set_parallel(true)
	#making them small
	tween.tween_property(sprite_2d, "scale", Vector2(0.1,0.1) ,1)
	tween.tween_property(cracks_img, "scale", Vector2(0.1,0.1) ,1)
	#making them disappear
	tween.tween_property(sprite_2d, "modulate:a", 0, 1)
	tween.tween_property(cracks_img, "modulate:a", 0, 1)
	#making the symbol pop out
	tween.tween_property(cookie_symbol, "scale", Vector2(2.5, 2.5), 1)
	
	
	

func GameOver() -> void:
	_crack += 1
	if _crack >= 3:
		disableCollisions()
		print("Game over")
		emit_signal("biscuitLost")
		cracks_img.modulate.a = 1
		segments.visible = false
	else:
		alpha_value+=.25
		cracks_img.modulate.a = alpha_value


#Changes the cursor image and the clicking sound
func _on_mouse_entered() -> void:
	Input.set_custom_mouse_cursor(NEEDLE, Input.CURSOR_ARROW, Vector2(24, 36))
	clicking_sound.stream = COOKIE
	emit_signal("on_cookie")
	
func _on_mouse_exited() -> void:
	Input.set_custom_mouse_cursor(USUAL_CURSOR, Input.CURSOR_ARROW, Vector2(8, 8)) 
	clicking_sound.stream = CLICKING_SOUND
	emit_signal("off_cookie")

#clicking
func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		pass



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

func _on_umbrella_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if CookieName == 6:
		if event is InputEventMouseButton and event.is_pressed():
			GameOver()

func _on_moon_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if CookieName == 7:
		if event is InputEventMouseButton and event.is_pressed():
			GameOver()

func _on_thunder_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if CookieName == 8:
		if event is InputEventMouseButton and event.is_pressed():
			GameOver()
