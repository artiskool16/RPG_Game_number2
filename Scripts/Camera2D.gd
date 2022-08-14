extends Camera2D

onready var player = get_node("../Player")

func _process(delta):
	position = player.global_position
	#round up number using floor
	var x = floor(position.x / 200) * 200
	var y = floor(position.y / 100) * 100
	global_position = Vector2(x,y)
