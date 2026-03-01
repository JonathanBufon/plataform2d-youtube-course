extends CharacterBody2D
@onready var animatedSprite2d: AnimatedSprite2D = $AnimatedSprite2D


const SPEED = 80.0
const JUMP_VELOCITY = -300.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if is_on_floor():
		if direction > 0:
			animatedSprite2d.flip_h = false
			animatedSprite2d.play("walk")
		elif direction < 0:
			animatedSprite2d.flip_h = true
			animatedSprite2d.play("walk")		
		else:
			animatedSprite2d.play("idle")	
	else:
		animatedSprite2d.play("jump")		

	move_and_slide()
