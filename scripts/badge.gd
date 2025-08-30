extends Node2D

@onready var body: Sprite2D = $Sprite2D
@export var image: Texture2D

@export var index :int

@onready var biscuit: Area2D = %Biscuit

var is_gained = false

func _ready() -> void:

	if not is_gained:
		body.modulate = 0
		body.modulate.a = 1	
		pass
	body.texture = image
	
	#biscuit.connect("biscuitCleared", checkIndex(Biscuit_Name))
	
func checkIndex(shape):
	#print(index)
	if index == shape:
		body.modulate.g = 1
		body.modulate.b = 1
		body.modulate.r = 1
		body.modulate.a = 1	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_biscuit_biscuit_cleared(biscuit_index) -> void:
	checkIndex(biscuit_index)
