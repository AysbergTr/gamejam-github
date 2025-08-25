extends Area2D

@onready var door_open_sprite: Sprite2D = $DoorOpenSprite

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	door_open_sprite.visible = true


func _on_mouse_exited() -> void:
	door_open_sprite.visible = false
