extends Area2D

# @export allows setting in the inspector, cool!
@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
