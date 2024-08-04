extends CharacterBody2D

var speed = 50
var player_chase = false
var player = null

func _physics_process(delta):
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

