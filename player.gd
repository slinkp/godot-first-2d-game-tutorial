extends Area2D

# @export allows setting in the inspector, cool!
@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	# Allow pressing more than one key and add the results
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		# Normalizing fixes diagonals being faster.
		# more at https://docs.godotengine.org/en/stable/tutorials/math/vector_math.html#doc-vector-math
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		# No animation unless moving
		$AnimatedSprite2D.stop()

	position += velocity * delta

	# Don't allow going off screen!
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
