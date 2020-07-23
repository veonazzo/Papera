extends Area2D

signal hit
# Declare member variables here. Examples:
export var speed = 400
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2()
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		#$AnimatedSprite.stop()
		$AnimatedSprite.animation = "default"
		
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	
	if velocity.x > 0:
		$AnimatedSprite.animation = "left"
		$AnimatedSprite.flip_h = true
	elif velocity.x < 0:
		$AnimatedSprite.animation = "left"
		$AnimatedSprite.flip_h = false
		#$AnimatedSprite.flip_h = velocity.x < 0

func _on_Player_body_entered(body):
	$AnimatedSprite.animation = "bomb"
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

