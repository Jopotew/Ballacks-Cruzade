extends CharacterBody2D
class_name Player

var stats : CharacterStats 

func load_stats(character_stats : CharacterStats) -> void:
    stats = character_stats

func _ready():
    print("Hello")
    
