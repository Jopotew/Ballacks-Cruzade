extends Control

@export var sprite : Texture2D

@onready var description_label: Label = $DescriptionLabel
@onready var cost_label: Label = $CostLabel
@onready var dmg_label: Label = $DmgLabel
@onready var card_name_label: Label = $CardNameLabel
@onready var card_sprite: TextureRect = $CardSprite

var card_name : String
var card_description : String
var card_cost : int 
var card_image : Sprite2D
const CARD_SIZE := Vector2(150, 230)


func _ready() -> void:
    GlobalData.card_size = CARD_SIZE
    set_card_values(card_cost, card_name, card_description)
    visible = true
    
func  set_card_values(_cost:int, _name:String, _des:String):
    card_cost = _cost
    card_description = _des
    card_name = _name
    
    cost_label.set_text(str(_cost))
    card_name_label.set_text(_name)
    description_label.set_text(_des)
    card_sprite.set_texture(sprite)
    
    
    
