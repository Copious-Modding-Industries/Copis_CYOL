dofile_once("data/scripts/lib/utilities.lua")
dofile_once("data/scripts/gun/procedural/gun_action_utils.lua")

function get_random_from( target )
	local rnd = Random(1, #target)
	
	return tostring(target[rnd])
end

function spell_action()
	local spell = tonumber(ModSettingGet("Copis_CYOL.secondary_spell"))
	if(spell == 1) then return "BOMB"
	elseif(spell == 2) then return "DYNAMITE"
	elseif(spell == 3) then return "MINE"
	elseif(spell == 4) then return "ROCKET"
	elseif(spell == 5) then return "GRENADE"
	end
end

local entity_id = GetUpdatedEntityID()
local x, y = EntityGetTransform( entity_id )
SetRandomSeed( x-1, y )

local ability_comp = EntityGetFirstComponent( entity_id, "AbilityComponent" )

local gun = { }
gun.name = 						{"Bomb Wand"}
gun.deck_capacity = 			1
gun.actions_per_round = 		1
gun.reload_time = 				tonumber(ModSettingGet("Copis_CYOL.secondary_reload_time"))
gun.shuffle_deck_when_empty = 	1
gun.fire_rate_wait = 			tonumber(ModSettingGet("Copis_CYOL.secondary_fire_rate_wait"))
gun.spread_degrees = 			0
gun.speed_multiplier = 			1
gun.mana_charge_speed = 		tonumber(ModSettingGet("Copis_CYOL.secondary_mana_charge_speed"))
gun.mana_max = 					tonumber(ModSettingGet("Copis_CYOL.secondary_mana_max"))


ComponentSetValue( ability_comp, "ui_name", 										get_random_from( gun.name ) )
ComponentObjectSetValue( ability_comp, "gun_config", "reload_time", 				gun.reload_time )
ComponentObjectSetValue( ability_comp, "gunaction_config", "fire_rate_wait", 		gun.fire_rate_wait )
ComponentSetValue( ability_comp, "mana_charge_speed", 								gun.mana_charge_speed )
ComponentObjectSetValue( ability_comp, "gun_config", "actions_per_round", 			gun.actions_per_round )
ComponentObjectSetValue( ability_comp, "gun_config", "deck_capacity",				gun.deck_capacity )
ComponentObjectSetValue( ability_comp, "gun_config", "shuffle_deck_when_empty", 	gun.shuffle_deck_when_empty )
ComponentObjectSetValue( ability_comp, "gunaction_config", "spread_degrees",		gun.spread_degrees )
ComponentObjectSetValue( ability_comp, "gunaction_config", "speed_multiplier", 		gun.speed_multiplier )
ComponentSetValue( ability_comp, "mana_max", 										gun.mana_max )
ComponentSetValue( ability_comp, "mana", 											gun.mana_max )

for i=1,1 do
	--AddGunActionPermanent( entity_id, gun_action )
	AddGunAction( entity_id, spell_action() )
end



