extends Node2D
class_name bullet
@export var speed=randf_range(50,420)
@export var dir=Vector2.ZERO
func _ready() -> void:
	look_at(get_global_mouse_position())
func _physics_process(delta: float) -> void:
	global_position+=dir*speed*delta
	print(speed)
	
