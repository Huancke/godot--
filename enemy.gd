extends CharacterBody2D
class_name enemy
var speed:float=randf_range(1,15)
var player:Node2D=null
var _player=null
@onready var body=$body
enum state{
	IDLE,
	MOVE,
	ATK,
	DEATH,
}
#全局变量game.gd在查找player时报错，现在改为分组方法
func _ready():
	await get_tree().process_frame
	var found_player=get_tree().get_nodes_in_group("player")
	if not found_player.is_empty():
		player=found_player[0]
		print("分组已找到：",player)
	print(body,"状态：",_state)
var _state=state.IDLE
func _physics_process(delta: float) -> void:
	if _state==state.DEATH or _state==state.ATK:return
	if player and is_instance_valid(player) and player is Node2D:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
		changeAnim()
func changeAnim():
	if _state==state.ATK :return
	elif velocity==Vector2.ZERO:
		$body/AnimatedSprite2D.play("idle")
		_state=state.IDLE
	else:
		$body/AnimatedSprite2D.play("move")
		_state=state.MOVE
		await get_tree().create_timer(3.5).timeout
		body.scale.x=-1 if velocity.x<0 else 1
#状态机未完成，需要重做
func _on_area_2d_body_entered(body: Node2D) -> void:
	_state=state.ATK
	body is enemy
	_player=body
	$body/AnimatedSprite2D.play("atk")
	await $body/AnimatedSprite2D.animation_finished
	_state=state.MOVE
	$body/AnimatedSprite2D.play(&"move")
func _on_area_2d_body_exited(body: Node2D) -> void:
	if $body/AnimatedSprite2D.animation == "atk":
		$body/AnimatedSprite2D.animation_finished
		_state=state.MOVE
		body is enemy
		$body/AnimatedSprite2D.play(&"move")
func _on_animated_sprite_2d_animation_changed() -> void:
	if _state==state.ATK&&$body/AnimatedSprite2D.animation=='atk':
		if _player&&$body/AnimatedSprite2D.frame==2:pass
func _on_animated_sprite_2d_animation_finished() -> void:
	if _player:
		$body/AnimatedSprite2D.play("atk")
	if _state==state.ATK and $body/AnimatedSprite2D.animation=='atk':
		_state=state.MOVE
		$body/AnimatedSprite2D.play("move")
