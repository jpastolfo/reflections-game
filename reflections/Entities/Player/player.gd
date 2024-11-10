extends CharacterBody2D

# Enum-like direction dictionary
const Axis := {
	LEFT = "ui_left", RIGHT = "ui_right", 
	ROT_LEFT = "ui_rleft", ROT_RIGHT = "ui_rright",
	JUMP = "ui_accept"
}


@export var speed = 300.0
@export var rotation_speed = 180
const JUMP_VELOCITY = -600.0
var screen_size
var current_rotation := 0.0
const n_rotation_points := 36
const rotation_step := 360 / n_rotation_points

func _ready() -> void:
	$AnimatedSprite2D.play()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed(Axis.JUMP) and is_on_floor():
		velocity.y = JUMP_VELOCITY
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis(Axis.LEFT, Axis.RIGHT)
	
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	else:
		$AnimatedSprite2D.animation = "still"
	
	var rotation_direction := Input.get_axis(Axis.ROT_LEFT, Axis.ROT_RIGHT)
	
	if rotation_direction:
		current_rotation += rotation_direction * rotation_speed * delta
		rotation_degrees = floor(current_rotation / rotation_step) * rotation_step


	move_and_slide()
