extends Node2D

@onready var card: Control = $Card
@export var card_data : Resource 

@onready var card_sprite: Sprite2D = $CardSprite

func _ready() -> void:
    card.set_card_values(card_data.cost, card_data.name, card_data.description)
    card.visible= true
    
