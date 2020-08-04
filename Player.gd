extends KinematicBody2D

signal hit
# Declare member variables here. Examples:
var screen_size

var state
var input
var velocity = Vector2()

var WALK_SPEED = 60

enum States {
	IDLE,
	WALK,
	HIT,
	EAT
}

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	state = States.IDLE
	
	
func _physics_process(delta):
	velocity.x = 0
	match state:
		States.IDLE:
			_idle(delta)
		States.WALK:
			_walk(delta)
		States.HIT:
			_hit()
		States.EAT:
			_eat()


func _idle(delta):
	update_input()
	if input.move_left or input.move_right:
		_walk(delta)
	else:
		velocity.x = 0
		$AnimatedSprite.play("idle")

func _walk(delta):
	update_input()
	if input.move_left:
		velocity.x -= WALK_SPEED
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk")
	elif input.move_right:
		velocity.x += WALK_SPEED
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")
	elif input.move_left and input.move_right:
		_idle(delta)
	movement(delta)

func _hit():
	pass

func _eat():
	pass

func movement(delta):
	var movement = velocity.normalized()*500*delta
	position += velocity * delta
	position.x = clamp(position.x, 25, screen_size.x-25)
	self.move_and_collide(movement)

func update_input():
	input = {
		move_left = Input.is_action_pressed("ui_left"),
		move_right = Input.is_action_pressed("ui_right")
	}




func _on_Player_body_entered(body):
	$AnimatedSprite.animation = "bomb"
	$AnimationTimer.start()
	#hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false

