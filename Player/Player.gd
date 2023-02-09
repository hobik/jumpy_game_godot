extends KinematicBody2D

var motion = Vector2(0,0)
const SPEED = 1500
const GRAVITY = 150

const UP = Vector2(0,-1) # negative -1 is up in godot
const JUMP_SPEED = 3000

signal animate 
const WORLD_LIMIT = 4000 # +y down -y up
const BOOST_MULTIPLIES = 1
#var lives = 3




func _physics_process(delta: float) -> void:
	apply_gravity()
	jump()
	move()
	animate()
	move_and_slide(motion, UP)		



func apply_gravity():
	if position.y > WORLD_LIMIT:
		get_tree().call_group("Gamestate","end_game")
	if  is_on_floor() and motion.y > 0:
		motion.y = 0	
	elif is_on_ceiling():
		motion.y = 1				
	else:
		motion.y += GRAVITY	
func jump():
		if Input.is_action_pressed("jump") and is_on_floor():
			motion.y -= JUMP_SPEED
			$JumpSFX.play()
func move():
	if Input.is_action_pressed("left") and not  Input.is_action_pressed("right"):
		motion.x = -SPEED
	elif Input.is_action_pressed("right") and not  Input.is_action_pressed("left"):
		motion.x = SPEED
	else:
		motion.x = 0	

func animate():
	emit_signal("animate",motion)

#
func end_game():
	get_tree().change_scene("res://Levels/GameOver.tscn")	

func hurt():
	position.y = -1
	yield(get_tree(),"idle_frame")
	motion.y = -JUMP_SPEED
#	lives -= 1
	$PainSFX.play()
#	if lives < 0:
#		end_game()
func boost():
	motion.y -= JUMP_SPEED * BOOST_MULTIPLIES
	position.y = -1
	yield(get_tree(),"idle_frame")
func _on_Player_animate() -> void:
	pass # Replace with function body.
