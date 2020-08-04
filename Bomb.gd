extends RigidBody2D

var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Visibility.connect("screen_exited", self, "_on_Visibility_screen_exited")
	set_contact_monitor(true)
	set_max_contacts_reported(1)

func _on_Visibility_screen_exited():
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var coliBodies = get_colliding_bodies()
    #coliBodies will always have an empty index of 0, the 0 index is assinged to the first colliding body, then adds another empty index.
    #so we check if the size is > 0
    #empty may not be proper term
	if coliBodies.size() > 0:
		print(coliBodies[0])
		print(coliBodies.size())
		count += 1
		print(count)
		

