extends CharacterBody3D

const playerspeedn=4
const playerspeedsp=10
const jumpvelo=4.5
#cant jump too high
const sensitivity=.004
var gravity = 11 
#gravity more extreme because underwater
var speed
@onready var head= $head
@onready var camera=$head/Camera3D

func _ready() :
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	#mouse not in gameplay
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * sensitivity)
		camera.rotate_x(-event.relative.y*sensitivity)
		camera.rotation.x= clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))
	elif event.is_action_pressed("esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event is InputEventMouseButton and Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _physics_process(delta):
	if Input.is_action_pressed("shift"):
		speed=playerspeedsp
	else:
		speed=playerspeedn
	if not is_on_floor():
		velocity.y -= gravity*delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y=jumpvelo
	var directions= Input.get_vector("left","right", "up", "down")
	var movementdir= (head.transform.basis*Vector3(directions.x,0,directions.y)).normalized()
	if is_on_floor():	
		if movementdir:
			velocity.x=speed*movementdir.x
			velocity.z=speed*movementdir.z
		else:
			velocity.x= 0
			velocity.z= 0
		#snappier movement
	else:
		velocity.x=lerp(velocity.x, movementdir.x*speed, delta * 2)
		velocity.z=lerp(velocity.z, movementdir.z*speed, delta * 2)
		
			
	move_and_slide()
