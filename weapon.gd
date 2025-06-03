extends Node2D
class_name weapon
const bullet=preload("res://bullet.tscn")
@onready var bullet_Point=$bulletPoint
#射击设计
func fire():
	var instance=bullet.instantiate()
	instance.global_position=bullet_Point.global_position
	instance.dir=global_position.direction_to(get_global_mouse_position())
	get_tree().root.add_child(instance)
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("fire"):fire()
