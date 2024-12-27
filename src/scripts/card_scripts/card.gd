extends Node2D
class_name Card


@export var card_name : String
@export var card_description : String
@export var card_cost : int 
@export var card_image : Sprite2D



@onready var cost_lbl : Label = $CostDisplay/CostLabel
@onready var name_lbl : Label = $CardName/CardNameLabel
@onready var description_lbl : Label = $DescriptionLabel


func _ready() -> void:
    set_card_values(card_cost, card_name, card_description)
    visible = false
    
func  set_card_values(_cost:int, _name:String, _des:String):
    card_cost = _cost
    card_description = _des
    card_name = _name
    
    cost_lbl.set_text(str(_cost))
    name_lbl.set_text(_name)
    description_lbl.set_text(_des)
