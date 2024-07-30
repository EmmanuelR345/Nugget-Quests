extends CharacterBody2D

#velocity of the character sliding
const SPEED = 200
#variable to store the current direction of the player
var current_dir = "none"

#calls frame for physic related movement
#handles player movement
#move the character based on current velocity
func _physics_process(delta):
	player_movement(delta)
	move_and_slide()

#what is up
func player_movement(delta):
	if Input.is_action_pressed("ui_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = SPEED
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -SPEED
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		play_anim(1, true)
		velocity.x = 0
		velocity.y = SPEED
	elif Input.is_action_pressed("ui_up"):
		play_anim(1, true)
		velocity.x = 0
		velocity.y = -SPEED
	else:
		play_anim(0)
		velocity.x = 0
		velocity.y = 0

func play_anim(movement, vertical=false):
	var dir = current_dir
	var anim = $AnimatedSprite2D

	if dir == "right" or (vertical and current_dir == "right"):
		anim.flip_h = false
		if movement == 1:
			anim.play("Right_idle_walk")
		elif movement == 0:
			anim.play("Right_idle_walk")

	if dir == "left" or (vertical and current_dir == "left"):
		anim.flip_h = false
		if movement == 1:
			anim.play("Left_idle_walk")
		elif movement == 0:
			anim.play("Left_idle_walk")
