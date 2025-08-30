extends Node2D

@onready var body: Sprite2D = $body

#symbols
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


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body.texture = CookieSymbolShape[randf_range(0,9)]
	body.global_position = Vector2(randf_range(0, 1000), randf_range(-20, -1000))
	goDown()
	
	
func goDown() -> void:
	#body.global_position = Vector2(randf_range(0, 1000), -20)
	var tween = create_tween()
	tween.set_parallel(true)	
	tween.tween_property(body, "position", Vector2(body.global_position[0]-100, 500), randf_range(2,5))
	tween.tween_property(body, "rotation", (body.rotation+10), 5)

func _process(delta: float) -> void:
	#print(body.global_position[1])
	if body.global_position[1] >= 745:
		body.texture = CookieSymbolShape[randf_range(0,9)]
		body.global_position = Vector2(randf_range(0, 1000), randf_range(-20, -50))
		goDown()
