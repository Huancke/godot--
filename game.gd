extends Node
pass
#课程中采用全局game脚本控制enemy的方法因为难以查明的bug被弃用，改为分组方法
#var player:Player=null
#func _ready():
#	await get_tree().process_frame
#	player=get_tree().root.get_node_or_null("Player")
#	if !player:push_error("没有player")
#	else:print("已注册player",player)
#func register(p:Player):
#	if not player:
#		player=p
#		print("player注册成功",player)
	
