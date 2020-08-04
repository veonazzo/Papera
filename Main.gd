extends Node

#export (PackedScene) var Bomb
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func game_over():
	#$ScoreTimer.stop()
	$BombTimer.stop()
	$HUD.show_game_over()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

func _on_StartTimer_timeout():
	$BombTimer.start()
	$ScoreTimer.start()

func _on_BombTimer_timeout():
	$BombPath/BombSpawnLocation.set_offset(randi())
	var bomb_scene = load("res://Bomb.tscn")
	var bomb_node = bomb_scene.instance()
	#bomb_node.position.x = rand_range(20, 580)
	bomb_node.position = $BombPath/BombSpawnLocation.position
	get_node("/root/Main").add_child(bomb_node)
	