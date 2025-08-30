extends Area2D

@onready var door_open_sprite: Sprite2D = $DoorOpenSprite
@onready var door_shut_sprite: Sprite2D = $DoorShutSprite

@export var cookie_index :int

signal cookie_selected

@onready var sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

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



func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		print(cookie_index)
		emit_signal("cookie_selected", cookie_index)
		collision_shape_2d.disabled = true
		door_shut_sprite.show()
		sfx.play()
