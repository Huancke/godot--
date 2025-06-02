extends CharacterBody2D
var speed=50 #基础速度
@onready var animate=$body/AnimatedSprite2D
@onready var body=$body
@onready var weapon=$body/WeaponNode
var _current_animate='down_'
func _physics_process(_delta):
	var dir=Vector2.ZERO
	dir.x=Input.get_axis(&"ui_left",&"ui_right")
	dir.y=Input.get_axis(&"ui_up",&"ui_down")
	velocity=dir.normalized()*speed
	changeAnimate()
	move_and_slide()
#切换动画
func changeAnimate():
	if velocity==Vector2.ZERO:
		animate.play(_current_animate+'idle')
	else:
		_current_animate=get_movement_dir()
		animate.play(_current_animate+'move')
		body.scale.x=-1 if velocity.x<0 else 1
	var _position=get_global_mouse_position()
	weapon.look_at(_position)
	if _position.x > position.x and body.scale.x !=1: body.scale.x=1
	elif _position.x < position.x && body.scale.x !=-1: body.scale.x=-1	
#获取移动时的方向以播放对应的动画，使用''符号进行变量拼接
func get_movement_dir() -> String:
	weapon.z_index=1
	if velocity==Vector2.ZERO:return 'lr_'
	var angle=velocity.angle()
	var degree=rad_to_deg(angle)
	if -45<=degree and degree<45:return'lr_'
	elif  45<=degree and degree<135:return 'down_'
	elif  -135 <=degree and degree <-45:
		weapon.z_index=0
		return'up_'
	return 'lr_'
