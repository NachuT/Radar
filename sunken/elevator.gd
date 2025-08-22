extends CharacterBody3D
 

var move: int=14
var move_speed: int=2
var direction=1
var starting=global_transform.origin
func _ready() -> void:
	pass
	


func _process(delta: float) -> void:
	var block = global_transform.origin
	block.y += direction*move_speed*delta
	global_transform.origin = block 
	
	if (abs(block.y - starting.y)>move or global_transform.origin.y<=0) :
		direction=direction*-1
	
	
