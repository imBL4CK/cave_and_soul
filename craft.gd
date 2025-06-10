extends Node


var recipes = {
	"wood_plank": {"wood": 2},  
	"stone_pickaxe": {"wood": 1, "stone": 3}  
}


var inventory = {
	"wood": 5,
	"stone": 5
}


func can_craft(item_name: String) -> bool:
	if item_name in recipes:
		var required_items = recipes[item_name]
		for req_item in required_items:
			if inventory.get(req_item, 0) < required_items[req_item]:
				return false  
		return true
	return false  

func craft(item_name: String):
	if can_craft(item_name):
		var required_items = recipes[item_name]
		
		for req_item in required_items:
			inventory[req_item] -= required_items[req_item]
		
		inventory[item_name] = inventory.get(item_name, 0) + 1
		print("Crafted:", item_name)
	else:
		print("Não tem recursos suficientes para craftar", item_name)
