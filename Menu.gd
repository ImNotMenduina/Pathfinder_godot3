extends Node2D

func _on_DFS_pressed():
	get_tree().change_scene("res://DFS/dfs_mz.tscn")


func _on_BFS_pressed():
	get_tree().change_scene("res://BFS/bfs_mz.tscn")


func _on_BID_pressed():
	get_tree().change_scene("res://BID/bid_mz.tscn")
