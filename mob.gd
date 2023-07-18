extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	# Make a random type of animation.
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	var mob_type = mob_types[randi() % mob_types.size()]
	print("Got mob type %s" % mob_type)
	$AnimatedSprite2D.play(mob_type)
	$VisibleOnScreenNotifier2D.screen_exited.connect(_on_visible_on_screen_notifier_2d_screen_exited)


func _on_visible_on_screen_notifier_2d_screen_exited():
	# They did not explain what queue_free() does
	queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
