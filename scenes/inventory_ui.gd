extends Node2D

@onready var grid_container = $Control/GridContainer
var inventory = {
	"stone": 5,
}

var item_slot_scene = preload("res://ItemSlot.tscn")

func _ready():
	update_inventory()

func update_inventory():
	for child in grid_container.get_children():
		child.queue_free()
	
	for item_name in inventory.keys():
		var item_slot = item_slot_scene.instantiate()
		var texture_rect = item_slot.find_child("TextureRect", true)
		var label = item_slot.get_node("Label")
		
		texture_rect.texture = load("res://icons/" + item_name + ".png")
		
		label.text = str(inventory[item_name])
		
		grid_container.add_child(item_slot)
		
		print("ItemSlot filhos:", item_slot.get_children())
