extends CharacterBody3D
 

var move: int=5
var move_speed: int=5
var direction=-1
var starting=global_transform.origin
func _ready() -> void:
	pass
	


func _process(delta: float) -> void:
	var block = global_transform.origin
	block.z += direction*move_speed*delta
	global_transform.origin = block 
	
	if abs(block.z - starting.z) > move:
		direction=direction*-1
	
	
