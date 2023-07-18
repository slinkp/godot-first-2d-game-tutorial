extends Area2D

signal player_hit

# @export allows setting in the inspector, cool!
@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()  # Don't show player when starting.
	
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

	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
	
	position += velocity * delta
	
	# Don't allow going off screen!
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)


func start(pos):
	# CUstom function to set up a player when we start.
	position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_body_entered(_body):
	hide() # Player disappears when hit. Could later replace with an explosion animation etc
	player_hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)
