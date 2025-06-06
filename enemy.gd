extends CharacterBody2D
class_name enemy
var speed=randf_range(5,20)
var player:Node2D=null
var current_player=null
@onready var body=$body
enum State{IDLE,MOVE,ATK,DEATH}
#全局变量game.gd在查找player时报错，现在改为分组方法
func _ready():
	await get_tree().process_frame
	var found_player=get_tree().get_nodes_in_group("player")
	if not found_player.is_empty():
		player=found_player[0]
		print("分组已找到：",player)
var current_state=State.IDLE
func _physics_process(delta: float) -> void:
	if current_state==State.DEATH||current_state==State.ATK:return
	if player and is_instance_valid(player) and player is Node2D:
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * speed
		move_and_slide()
		changeAnim()
func changeAnim():
	if velocity==Vector2.ZERO:
		$body/AnimatedSprite2D.play(&"idle")
		current_state=State.IDLE
	else:
		$body/AnimatedSprite2D.play(&"move")
		await get_tree().create_timer(3.5).timeout
		current_state=State.MOVE
		body.scale.x=-1 if velocity.x<0 else 1
func _on_area_2d_body_entered(body: Node2D) -> void:
	print("碰撞检测为：",body)
	if body is Player:
		current_player=body
		current_state=State.ATK
		$body/AnimatedSprite2D.play("atk")
func _on_animated_sprite_2d_frame_changed() -> void:
	if current_state==State.ATK && $body/AnimatedSprite2D.animation=='atk':
		if current_player&&$body/AnimatedSprite2D.frame==2:pass
func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player && body==current_player:
		current_player=null
func _on_animated_sprite_2d_animation_finished() -> void:
	if current_state==State.ATK && $body/AnimatedSprite2D.animation=='atk':
		if current_player:$body/AnimatedSprite2D.play(&"atk")
		else:current_state=State.MOVE
#状态机未完成，需要重做
