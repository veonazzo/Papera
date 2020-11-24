extends RigidBody2D

signal eat
var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$VisibilityApple.connect("screen_exited", self, "_on_Visibility_screen_exited")
	
	set_contact_monitor(true)
	set_max_contacts_reported(1)

func _on_Visibility_screen_exited():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#	var coliBodies = get_colliding_bodies()
#	if coliBodies.size() > 0:
#		emit_signal("eat")


func _on_Apple_body_entered(body):
	if body.get_name() == "Player":
		emit_signal("eat")
		queue_free()
