extends CharacterBody2D

var enemy_inattack_range = false
var enemy_attack_cooldown = true
var health = 100
var player_alive = true

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
	enemy_attack()

	if health <= 0:
		player_alive = false #go back to menu or respawn
		health = 0
		print("player has been killed")
		self.queue_free()

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

func player():
	pass

func _on_player_hitbox_body_entered(body:Node2D):
	if body.has_method("enemy"):
		enemy_inattack_range = true

func _on_player_hitbox_body_exited(body:Node2D):
	if body.has_method("enemy"):
		enemy_inattack_range = false
	
func enemy_attack():
	if enemy_inattack_range and enemy_attack_cooldown == true:
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)

func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true
