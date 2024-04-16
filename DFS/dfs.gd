extends TileMap

var start : Vector2
var goal : Vector2
var explored = []
var gray = []

var is_finished : bool = false

func _ready():
	initialize()
	bfs()
	pass

func initialize(): #gets the start and the end
	start = get_used_cells_by_id(4)[0]
	goal =  get_used_cells_by_id(5)[0]
	gray.append_array(get_used_cells_by_id(0))

func bfs():
	var frontier = []
	frontier.append(start)
	var came_from : Dictionary = {}
	
	while !frontier.empty():
		yield(get_tree(), "idle_frame")
		var node = frontier.pop_back()
		
		if node == goal:
			node = goal
			var path = []
			while node != start:
				path.append(node)
				set_cellv(node, 3)
				node = came_from[node]
			path.append(start)
			path.invert()
	
			break
			
		explored.append(node)
		
		for child in get_neighborss(node):
			if !child in frontier and !child in explored:
				frontier.append(child)
				came_from[child] = node
				yield(get_tree().create_timer(0.1), "timeout")
				set_cellv(child, 2) #animate the search

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
