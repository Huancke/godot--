extends Camera2D
func _ready():
	limit_left=32
	limit_right=704
	limit_top=-15
	limit_bottom=366
	print("Camera limits set manually: ", limit_left, ", ", limit_top, ", ", limit_right, ", ", limit_bottom)
