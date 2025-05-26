extends CharacterBody2D
#hello
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var coyote_timer = $coyoteTimer
@onready var respawn_loc = global_position

const SPEED = 1200.0
const JUMP_VELOCITY = -2000
var onPlatform = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):

	handleGravity(delta)
	handleJump()
	var direction = Input.get_axis("a", "d")
	handlePlayerMovement(direction)
	updateAnimation(direction)
	var wasOnFloor = is_on_floor()
	move_and_slide()
	var justLeftFloor = wasOnFloor and not is_on_floor() and velocity.y >= 0
	if justLeftFloor:
		coyote_timer.start()
	
	
func handleGravity(delta):
	if not is_on_floor() or coyote_timer.time_left > 0.0:
		velocity.y += gravity * delta

func handleJump():
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			velocity.y = JUMP_VELOCITY
		
func handlePlayerMovement(direction):
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func _on_area_2d_area_entered(body):
	if body.is_in_group("platform"):
		onPlatform = true
		
func updateAnimation(input_axis):
	if input_axis != 0:
		animated_sprite_2d.flip_h = (input_axis<0)
		animated_sprite_2d.play("run")
	else:
		animated_sprite_2d.play("idle")
	if not is_on_floor():
		animated_sprite_2d.play("jump")

func respawn(respawnLoc):
	position = respawnLoc


func _on_hazard_detector_area_entered(area):
	if area.is_in_group("hazard"):
		global_position = respawn_loc
	elif  area.is_in_group("checkpoint"):
		respawn_loc = global_position
		print("spawn set")
