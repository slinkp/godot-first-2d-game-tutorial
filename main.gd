extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func game_over():
	print("Game over!!!")
	$ScoreTimer.stop()
	$MobTimer.stop()

func new_game():
	print("Starting new game")
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get ready...")
	$Player.start($StartPositionMarker.position)
	$StartTimer.start()


func _on_score_timer_timeout():
	score += 1

func _on_start_timer_timeout():
	print("Start timer timed out")
	$MobTimer.start()
	$ScoreTimer.start()

func _on_mob_timer_timeout():
	print("Mob timer timed out")
	# Create a new enemy
	var mob = mob_scene.instantiate()
	
	# Choose a random location along the path
	var mob_spawn_location = get_node("MobSpawnPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	
	# Set the mob's direction perpendicular to the path at spawn point
	var direction = mob_spawn_location.rotation + PI / 2
	
	# Set the mob's position to a random location
	mob.position  = mob_spawn_location.position
	
	# Randomize direction
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction
	
	# Velocity for this mob
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	# Spawn the mob by adding to Main scene
	add_child(mob)



