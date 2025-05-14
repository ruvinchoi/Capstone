extends CharacterBody2D
#hello

const SPEED = 450.0
const JUMP_VELOCITY = -415.0
var onPlatform = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):

	handleGravity(delta)
	handleJump()
	var direction = Input.get_axis("a", "d")
	handlePlayerMovement(direction)

	move_and_slide()
	
	
	
func handleGravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func handleJump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
func handlePlayerMovement(direction):
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func _on_area_2d_area_entered(body):
	if body.is_in_group("platform"):
		onPlatform = true
		
