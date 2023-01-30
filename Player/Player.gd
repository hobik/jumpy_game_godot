extends KinematicBody2D

var motion = Vector2(0,0)
const SPEED = 1000
const GRAVITY = 300

const UP = Vector2(0,-1) # negative -1 is up in godot
const JUMP_SPEED = 3000

func _physics_process(delta: float) -> void:
	apply_gravity()
	jump()
	move()
	


	

func apply_gravity():
	if  is_on_floor():
		motion.y = 0			
	else:
		motion.y += GRAVITY	
func jump():
		if Input.is_action_just_pressed("jump") and is_on_floor():
			motion.y -= JUMP_SPEED
func move():
	if Input.is_action_pressed("left") and not  Input.is_action_pressed("right"):
		motion.x = -SPEED
	elif Input.is_action_pressed("right") and not  Input.is_action_pressed("left"):
		motion.x = SPEED
	else:
		motion.x = 0	
	move_and_slide(motion, UP)		
