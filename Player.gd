extends KinematicBody2D

export (int) var speed = 300
export (int) var score

onready var HUD : CanvasLayer = get_node("/root/Main").get_child(0)

# Declare member variables here. Examples:
var screen_size
var gameover = false
var eat = false
var input
var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	score = 0
	
	
	
func _physics_process(delta):
	get_input(delta)
	position += velocity * delta
	position.x = clamp(position.x, 25, screen_size.x-25)
	velocity = move_and_collide(velocity)
	
	#$Visibility.connect("screen_exited", self, "_on_Visibility_screen_exited")
	
	
func get_input(delta):
	velocity = Vector2()
	if Input.is_action_pressed("ui_left") and !gameover and !eat:
		velocity.x -= 1
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk")
	elif Input.is_action_pressed("ui_right") and !gameover and !eat:
		velocity.x += 1
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")
	elif !gameover and !eat:
		$AnimatedSprite.play("idle")
	elif gameover:
		$AnimatedSprite.play("gameover")
	velocity = velocity.normalized() * speed * delta

func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			get_tree().set_input_as_handled()
		else:
			get_tree().set_input_as_handled()
	if event is InputEventScreenDrag:
		_on_touch_drag(event)
		get_tree().set_input_as_handled()
		
		
func _on_touch_drag(event):
	self.position.x = event.position.x

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_hit_bomb():
	$AnimatedSprite.play("bomb")
	gameover = true
	
func _on_eat_apple():
	if !gameover:
		$AnimatedSprite.play("eat")
		score += 1
		HUD.update_score(score)		
		eat = true
		

func _on_AnimatedSprite_animation_finished():
	eat = false
