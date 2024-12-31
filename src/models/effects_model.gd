extends Resource
class_name EffectRes

## Tipo: "buff", "debuff", "status_effect"
@export var effect_type: String
## Objetivo: "self", "enemy", "aoe"
@export var target: String 
## Duración en turnos
@export var duration: int = 0 
## Daño por turno (si aplica)
@export var damage_per_turn: int = 0 
## Cambios de estadísticas (opcional) {healing = 5, dexterity = -5}
@export var stat_changes: Dictionary
    
