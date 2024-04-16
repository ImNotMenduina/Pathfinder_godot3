extends TileMap

var start: Vector2
var goal: Vector2
var gray= []

var explored_s = []
var explored_g = []

var frontier_s = []
var frontier_g = [] 

var came_from_s : Dictionary = {}
var came_from_g : Dictionary = {}

func _ready():
	initialize()
	bid()
	pass

func initialize():
	gray = get_used_cells_by_id(0)
	start = get_used_cells_by_id(4)[0]
	goal = get_used_cells_by_id(5)[0]

func bid():
	#### BFS#1
	
	frontier_s.append(start)
	frontier_g.append(goal)
	
	while true:
		yield(get_tree(), "idle_frame")
		var node_s = frontier_s.pop_front()
		
		if node_s in frontier_g:
			tracePath(node_s)
			break
		
		explored_s.append(node_s)
		
		for child in get_neighborss(node_s):
			if !child in frontier_s and !child in explored_s:
				frontier_s.append(child)
				came_from_s[child] = node_s
				yield(get_tree().create_timer(0.03), "timeout")
				set_cellv(child, 2)
				
	#### BFS#2
		yield(get_tree(), "idle_frame")
		var node_g = frontier_g.pop_front()
		
		if node_g in frontier_s:
			tracePath(node_g)
			break
		
		explored_g.append(node_g)
		
		for child in get_neighborss(node_g):
			if !child in frontier_g and !child in explored_g:
				frontier_g.append(child)
				came_from_g[child] = node_g
				yield(get_tree().create_timer(0.03), "timeout")
				set_cellv(child, 2)
				
func get_neighborss(pos : Vector2): #helper function to get the neighbors
	var neighbors : Array = []
	for x in range(-1, 2):
		for y in range(-1, 2):
			if x == 0 and y == 0:
				continue
			if get_cellv(pos + Vector2(x, y)) != -1:
				var current = pos + Vector2(x,y)
				if !current in gray:
					neighbors.append(pos + Vector2(x, y))
	return neighbors

func tracePath(node):
	var node_path_g = node
	var node_path_s = node
	
	while node_path_g != goal:
		set_cellv(node_path_g, 3)
		node_path_g = came_from_g[node_path_g]
	
	while node_path_s != start:
		set_cellv(node_path_s, 3)
		node_path_s = came_from_s[node_path_s]

func _on_Menu_pressed():
	get_tree().change_scene("res://Menu.tscn")
