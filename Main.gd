extends Node

#export (PackedScene) var Bomb
onready var player_node : Node2D = $Player

export (int) var score
var gravity = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	#$ScoreTimer.stop()
	$BombTimer.stop()
	$AppleTimer.stop()
	$HUD.show_game_over()
	$StartTimer.stop()

func new_game():
	score = 0
	player_node.score = 0
	player_node.start($StartPosition.position)
	player_node.get_child(0).set("play", "idle")
	player_node.gameover = false
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Pronti...")

func _on_StartTimer_timeout():
	$BombTimer.start()
	$AppleTimer.start()
	$ScoreTimer.start()

func _on_BombTimer_timeout():
	$BombPath/BombSpawnLocation.set_offset(randi())
	var bomb_scene = load("res://Bomb.tscn")
	var bomb_node = bomb_scene.instance()
	bomb_node.position = $BombPath/BombSpawnLocation.position
	get_node("/root/Main").add_child(bomb_node)
	bomb_node.connect("hit", player_node, "_on_hit_bomb")
	bomb_node.connect("hit", self, "game_over")
	if int($HUD/ScoreLabel.text) > 5:
		bomb_node.set("gravity_scale", 1.5)
		$BombTimer.wait_time = 0.7
	elif int($HUD/ScoreLabel.text) > 10:
		bomb_node.set("gravity_scale", 2)
		$BombTimer.wait_time = 0.6
	elif int($HUD/ScoreLabel.text) > 25:
		bomb_node.set("gravity_scale", 2.5)
		$BombTimer.wait_time = 0.5
	elif int($HUD/ScoreLabel.text) > 50:
		bomb_node.set("gravity_scale", 2.7)
		$BombTimer.wait_time = 0.4
	elif int($HUD/ScoreLabel.text) > 100:
		bomb_node.set("gravity_scale", 3)
		$BombTimer.wait_time = 0.3

func _on_AppleTimer_timeout():
	$BombPath/BombSpawnLocation.set_offset(randi())
	var apple_scene = load("res://Apple.tscn")
	var apple_node = apple_scene.instance()
	apple_node.position = $BombPath/BombSpawnLocation.position
	get_node("/root/Main").add_child(apple_node)
	apple_node.connect("eat", player_node, "_on_eat_apple")
	if int($HUD/ScoreLabel.text) > 5:
		apple_node.set("gravity_scale", 1.5)
		$AppleTimer.wait_time = 0.7
	elif int($HUD/ScoreLabel.text) > 10:
		apple_node.set("gravity_scale", 2)
		$AppleTimer.wait_time = 0.6
	elif int($HUD/ScoreLabel.text) > 25:
		apple_node.set("gravity_scale", 2.5)
		$AppleTimer.wait_time = 0.5
	elif int($HUD/ScoreLabel.text) > 50:
		apple_node.set("gravity_scale", 2.7)
		$AppleTimer.wait_time = 0.4
	elif int($HUD/ScoreLabel.text) > 100:
		apple_node.set("gravity_scale", 3)
		$AppleTimer.wait_time = 0.3
		
func increase_difficulty(object):
	if int($HUD/ScoreLabel.text) > 5:
		object.set("gravity_scale", 1.5)
		$BombTimer.wait_time = 0.7
	elif int($HUD/ScoreLabel.text) > 10:
		object.set("gravity_scale", 2)
		$BombTimer.wait_time = 0.6
	elif int($HUD/ScoreLabel.text) > 25:
		object.set("gravity_scale", 2.5)
		$BombTimer.wait_time = 0.5
	elif int($HUD/ScoreLabel.text) > 50:
		object.set("gravity_scale", 2.7)
		$BombTimer.wait_time = 0.4
	elif int($HUD/ScoreLabel.text) > 100:
		object.set("gravity_scale", 3)
		$BombTimer.wait_time = 0.3
