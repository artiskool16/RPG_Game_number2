extends KinematicBody2D

export (int) var speed :int = 100
var velocity = Vector2.ZERO
var state = MOVE
enum {
	MOVE,
	SWORD_ATTACK
}

onready var animTree = $AnimationTree
onready var animState = animTree.get("parameters/playback")


func _physics_process(delta):
	match state :
		MOVE :
			MovePlayer()
		SWORD_ATTACK :
			SwordAttack()
	
func MovePlayer():
	var inputMovement = Vector2.ZERO
	
	inputMovement.x = Input.get_action_strength("MoveLeft") - Input.get_action_strength("MoveRight")
	inputMovement.y = Input.get_action_strength("MoveDown") - Input.get_action_strength("MoveUp")

	if inputMovement != Vector2.ZERO:
		animTree.set("parameters/Idle/blend_position", inputMovement)
		animTree.set("parameters/Walk/blend_position", inputMovement)
		animTree.set("parameters/Sword/blend_position", inputMovement)
		animState.travel("Walk")
		velocity += inputMovement * speed
		velocity = velocity.clamped(speed)
		
	else :
		animState.travel("Idle")
		velocity = Vector2.ZERO
	
	if Input.is_action_just_pressed("SwordAttack")	:
		state = SWORD_ATTACK
		
	move_and_slide(velocity)	
func SwordAttack():
	velocity = Vector2.ZERO
	animState.travel("Sword")

func SwordAttackFinished():
	state = MOVE 	
