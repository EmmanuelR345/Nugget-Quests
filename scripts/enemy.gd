extends CharacterBody2D

var speed = 50
var player_chase = false
var player = null

var health = 100
var player_inattack_zone = false


func _physics_process(delta):

	deal_with_damage()

	if player_chase:
		position += (player.position - position)/speed
		
        
		if(player.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("Right_side_idle")

	move_and_collide(Vector2(0,0))




func _on_detection_area_body_entered(body:Node2D):
	player = body
	player_chase = true



func _on_detection_area_body_exited(body:Node2D):
	player = null
	player_chase = false

func enemy():
	pass

func _on_enemy_hitbox_body_entered(body:Node2D):
	if body.has_method("player"):
		player_inattack_zone = true

func _on_enemy_hitbox_body_exited(body:Node2D):
	if body.has_method("player"):
		player_inattack_zone = true

func deal_with_damage():
	if player_inattack_zone and global.player_current_attack == true:
		health = health - 20
		print("nugget enemy health = ", health)
		if health <= 0:
			self.queue_free()