extends Node2D

@onready var wait = $wait
var within = false
var animPlaying = false

func _ready():
	pass 

func _physics_process(_delta):
	testanimate()

func testanimate():
	if Input.is_action_just_pressed("test") and within == true and $AnimationPlayer.is_playing() == false and animPlaying == false:
		$AnimationPlayer.play("out")
		animPlaying = true
		wait.start()
	#elif Input.is_action_just_pressed("shift"):
		#$AnimationPlayer.play("in")
	
func _on_wait_timeout():
	$AnimationPlayer.play("in")
	animPlaying = false

func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		within = true
		
func _on_area_2d_body_exited(body):
		if body.is_in_group("player"):
			within = false




