extends Node3D

@export var target_path: NodePath
@onready var target: Node3D = get_node(target_path)
@onready var nav_agent: NavigationAgent3D = $NavigationAgent3D

func _ready():
	var map_rid = nav_agent.get_navigation_map()

	var enemy_pos = global_transform.origin
	var player_pos = target.global_transform.origin

	var enemy_closest = NavigationServer3D.map_get_closest_point(map_rid, enemy_pos)
	var player_closest = NavigationServer3D.map_get_closest_point(map_rid, player_pos)

	var enemy_in_navmesh = enemy_closest.distance_to(enemy_pos) < 0.5
	var player_in_navmesh = player_closest.distance_to(player_pos) < 0.5

	print("--- NAVIGATION DEBUG ---")
	print("Enemy position:", enemy_pos)
	print("Closest NavMesh point to enemy:", enemy_closest)
	print("Enemy is inside navmesh:", enemy_in_navmesh)

	print("Player position:", player_pos)
	print("Closest NavMesh point to player:", player_closest)
	print("Player is inside navmesh:", player_in_navmesh)
