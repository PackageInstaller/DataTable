-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\PropBoard.lua

local math = math
local PropBoard = {}

PropBoard.PROP_RELATIONS = {
	e_atk = {
		"atk"
	},
	e_atk_percent = {
		"atk"
	},
	e_def = {
		"m_def",
		"p_def"
	},
	e_def_percent = {
		"m_def",
		"p_def"
	},
	e_m_def = {
		"m_def"
	},
	e_m_def_percent = {
		"m_def"
	},
	e_mhp = {
		"mhp"
	},
	e_mhp_percent = {
		"mhp"
	},
	e_p_def = {
		"p_def"
	},
	e_p_def_percent = {
		"p_def"
	},
	fProp_arp_percent = {
		"arp_percent"
	},
	fProp_assist_enhance = {
		"assist_enhance"
	},
	fProp_atk = {
		"atk"
	},
	fProp_atk_percent = {
		"atk"
	},
	fProp_attack_speed_up = {
		"attack_speed_up"
	},
	fProp_cri_dmg = {
		"cri_dmg"
	},
	fProp_cri_dmg_reduce = {
		"cri_dmg_reduce"
	},
	fProp_cri_rate = {
		"cri_rate"
	},
	fProp_cri_reduce = {
		"cri_reduce"
	},
	fProp_damage_percent = {
		"damage_percent"
	},
	fProp_damage_reduce_percent = {
		"damage_reduce_percent"
	},
	fProp_effect_hit = {
		"effect_hit"
	},
	fProp_effect_miss = {
		"effect_miss"
	},
	fProp_fire_damage = {
		"fire_damage"
	},
	fProp_fire_damage_reduce = {
		"fire_damage_reduce"
	},
	fProp_heal_effect = {
		"heal_effect"
	},
	fProp_heal_enhance_percent = {
		"heal_enhance_percent"
	},
	fProp_ice_damage = {
		"ice_damage"
	},
	fProp_ice_damage_reduce = {
		"ice_damage_reduce"
	},
	fProp_life_reply = {
		"life_reply"
	},
	fProp_m_def = {
		"m_def"
	},
	fProp_m_def_percent = {
		"m_def"
	},
	fProp_mana_gen = {
		"mana_gen"
	},
	fProp_mhp = {
		"mhp"
	},
	fProp_mhp_percent = {
		"mhp"
	},
	fProp_miss = {
		"miss"
	},
	fProp_p_def = {
		"p_def"
	},
	fProp_p_def_percent = {
		"p_def"
	},
	fProp_spp_percent = {
		"spp_percent"
	},
	sProp_arp_percent = {
		"arp_percent"
	},
	sProp_assist_enhance = {
		"assist_enhance"
	},
	sProp_atk = {
		"atk"
	},
	sProp_atk_percent = {
		"atk"
	},
	sProp_attack_speed_up = {
		"attack_speed_up"
	},
	sProp_cri_dmg = {
		"cri_dmg"
	},
	sProp_cri_dmg_reduce = {
		"cri_dmg_reduce"
	},
	sProp_cri_rate = {
		"cri_rate"
	},
	sProp_cri_reduce = {
		"cri_reduce"
	},
	sProp_damage_percent = {
		"damage_percent"
	},
	sProp_damage_reduce_percent = {
		"damage_reduce_percent"
	},
	sProp_effect_hit = {
		"effect_hit"
	},
	sProp_effect_miss = {
		"effect_miss"
	},
	sProp_fire_damage = {
		"fire_damage"
	},
	sProp_fire_damage_reduce = {
		"fire_damage_reduce"
	},
	sProp_heal_effect = {
		"heal_effect"
	},
	sProp_heal_enhance_percent = {
		"heal_enhance_percent"
	},
	sProp_hit_rate = {
		"hit_rate"
	},
	sProp_ice_damage = {
		"ice_damage"
	},
	sProp_ice_damage_reduce = {
		"ice_damage_reduce"
	},
	sProp_life_reply = {
		"life_reply"
	},
	sProp_m_def = {
		"m_def"
	},
	sProp_m_def_percent = {
		"m_def"
	},
	sProp_mana_gen = {
		"mana_gen"
	},
	sProp_mhp = {
		"mhp"
	},
	sProp_mhp_percent = {
		"mhp"
	},
	sProp_miss = {
		"miss"
	},
	sProp_p_def = {
		"p_def"
	},
	sProp_p_def_percent = {
		"p_def"
	},
	sProp_spp_percent = {
		"spp_percent"
	},
	star_atk_percent = {
		"atk"
	},
	star_mhp_percent = {
		"mhp"
	}
}
PropBoard.PROP_LEVELS = {
	mhp = 2,
	fProp_life_reply = 1,
	e_m_def_percent = 1,
	e_mhp_percent = 1,
	cri_dmg = 2,
	e_atk = 1,
	fProp_mana_gen = 1,
	fProp_effect_hit = 1,
	assist_enhance = 2,
	fProp_atk_percent = 1,
	fProp_m_def = 1,
	fProp_damage_percent = 1,
	fProp_fire_damage_reduce = 1,
	fProp_p_def_percent = 1,
	sProp_p_def = 1,
	m_def = 2,
	sProp_cri_rate = 1,
	fProp_m_def_percent = 1,
	fProp_spp_percent = 1,
	p_def = 2,
	effect_miss = 2,
	fProp_cri_reduce = 1,
	fProp_assist_enhance = 1,
	sProp_ice_damage_reduce = 1,
	arp_percent = 2,
	fProp_heal_enhance_percent = 1,
	e_atk_percent = 1,
	sProp_fire_damage_reduce = 1,
	damage_reduce_percent = 2,
	sProp_cri_dmg = 1,
	fProp_effect_miss = 1,
	sProp_cri_dmg_reduce = 1,
	atk = 2,
	mana_gen = 2,
	fProp_ice_damage_reduce = 1,
	sProp_damage_percent = 1,
	sProp_arp_percent = 1,
	sProp_effect_hit = 1,
	e_m_def = 1,
	fProp_cri_dmg = 1,
	e_def = 1,
	hit_rate = 2,
	sProp_effect_miss = 1,
	sProp_atk_percent = 1,
	sProp_heal_effect = 1,
	ice_damage_reduce = 2,
	fProp_cri_dmg_reduce = 1,
	sProp_heal_enhance_percent = 1,
	fProp_ice_damage = 1,
	fProp_arp_percent = 1,
	sProp_hit_rate = 1,
	heal_effect = 2,
	e_def_percent = 1,
	sProp_ice_damage = 1,
	sProp_assist_enhance = 1,
	sProp_m_def = 1,
	fProp_p_def = 1,
	life_reply = 2,
	fProp_mhp = 1,
	damage_percent = 2,
	sProp_m_def_percent = 1,
	e_p_def = 1,
	sProp_mana_gen = 1,
	fProp_attack_speed_up = 1,
	sProp_mhp_percent = 1,
	sProp_mhp = 1,
	sProp_fire_damage = 1,
	sProp_cri_reduce = 1,
	star_atk_percent = 1,
	sProp_p_def_percent = 1,
	sProp_life_reply = 1,
	sProp_spp_percent = 1,
	spp_percent = 2,
	fProp_fire_damage = 1,
	e_mhp = 1,
	fProp_mhp_percent = 1,
	star_mhp_percent = 1,
	e_p_def_percent = 1,
	heal_enhance_percent = 2,
	cri_rate = 2,
	ice_damage = 2,
	fProp_atk = 1,
	sProp_damage_reduce_percent = 1,
	miss = 2,
	sProp_atk = 1,
	cri_dmg_reduce = 2,
	fire_damage_reduce = 2,
	fire_damage = 2,
	fProp_miss = 1,
	fProp_damage_reduce_percent = 1,
	attack_speed_up = 2,
	sProp_miss = 1,
	sProp_attack_speed_up = 1,
	effect_hit = 2,
	cri_reduce = 2,
	fProp_heal_effect = 1,
	fProp_cri_rate = 1
}
PropBoard.PROP_TOTAL_LEVEL = 2

function PropBoard._calc_arp_percent(owner)
	owner.arp_percent = owner.fixedProp:getProp("fProp_arp_percent", 0) / 10000 + owner.stateGroup:getProp("sProp_arp_percent", 0) / 10000
end

function PropBoard._calc_assist_enhance(owner)
	owner.assist_enhance = owner.fixedProp:getProp("fProp_assist_enhance", 0) / 10000 + owner.stateGroup:getProp("sProp_assist_enhance", 0) / 10000
end

function PropBoard._calc_atk(owner)
	owner.atk = (owner.fixedProp:getProp("fProp_atk", 0) * (1 + owner.fixedProp:getProp("fProp_atk_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("star_atk_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("e_atk_percent", 0) / 10000) + owner.fixedProp:getProp("e_atk", 0)) * (1 + owner.stateGroup:getProp("sProp_atk_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_atk", 0)
end

function PropBoard._calc_attack_speed_up(owner)
	owner.attack_speed_up = 1 + (owner.fixedProp:getProp("fProp_attack_speed_up", 0) + owner.stateGroup:getProp("sProp_attack_speed_up", 0)) / 10000
end

function PropBoard._calc_cri_dmg(owner)
	owner.cri_dmg = 1.5 + owner.fixedProp:getProp("fProp_cri_dmg", 0) / 10000 + owner.stateGroup:getProp("sProp_cri_dmg", 0) / 10000
end

function PropBoard._calc_cri_dmg_reduce(owner)
	owner.cri_dmg_reduce = owner.fixedProp:getProp("fProp_cri_dmg_reduce", 0) / 10000 + owner.stateGroup:getProp("sProp_cri_dmg_reduce", 0) / 10000
end

function PropBoard._calc_cri_rate(owner)
	owner.cri_rate = owner.fixedProp:getProp("fProp_cri_rate", 0) / 10000 + owner.stateGroup:getProp("sProp_cri_rate", 0) / 10000
end

function PropBoard._calc_cri_reduce(owner)
	owner.cri_reduce = owner.fixedProp:getProp("fProp_cri_reduce", 0) / 10000 + owner.stateGroup:getProp("sProp_cri_reduce", 0) / 10000
end

function PropBoard._calc_damage_percent(owner)
	owner.damage_percent = owner.fixedProp:getProp("fProp_damage_percent", 0) / 10000 + owner.stateGroup:getProp("sProp_damage_percent", 0) / 10000
end

function PropBoard._calc_damage_reduce_percent(owner)
	owner.damage_reduce_percent = owner.fixedProp:getProp("fProp_damage_reduce_percent", 0) / 10000 + owner.stateGroup:getProp("sProp_damage_reduce_percent", 0) / 10000
end

function PropBoard.update_e_atk(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("e_atk")
	else
		owner.atk = (owner.fixedProp:getProp("fProp_atk", 0) * (1 + owner.fixedProp:getProp("fProp_atk_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("star_atk_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("e_atk_percent", 0) / 10000) + owner.fixedProp:getProp("e_atk", 0)) * (1 + owner.stateGroup:getProp("sProp_atk_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_atk", 0)
	end
end

function PropBoard.update_e_atk_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("e_atk_percent")
	else
		owner.atk = (owner.fixedProp:getProp("fProp_atk", 0) * (1 + owner.fixedProp:getProp("fProp_atk_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("star_atk_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("e_atk_percent", 0) / 10000) + owner.fixedProp:getProp("e_atk", 0)) * (1 + owner.stateGroup:getProp("sProp_atk_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_atk", 0)
	end
end

function PropBoard.update_e_def(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("e_def")
	else
		owner.m_def = (owner.fixedProp:getProp("fProp_m_def", 0) * (1 + owner.fixedProp:getProp("fProp_m_def_percent", 0) / 10000) * (1 + (owner.fixedProp:getProp("e_m_def_percent", 0) + owner.fixedProp:getProp("e_def_percent", 0)) / 10000) + owner.fixedProp:getProp("e_m_def", 0) + owner.fixedProp:getProp("e_def", 0)) * (1 + owner.stateGroup:getProp("sProp_m_def_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_m_def", 0)
		owner.p_def = (owner.fixedProp:getProp("fProp_p_def", 0) * (1 + owner.fixedProp:getProp("fProp_p_def_percent", 0) / 10000) * (1 + (owner.fixedProp:getProp("e_p_def_percent", 0) + owner.fixedProp:getProp("e_def_percent", 0)) / 10000) + owner.fixedProp:getProp("e_p_def", 0) + owner.fixedProp:getProp("e_def", 0)) * (1 + owner.stateGroup:getProp("sProp_p_def_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_p_def", 0)
	end
end

function PropBoard.update_e_def_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("e_def_percent")
	else
		owner.m_def = (owner.fixedProp:getProp("fProp_m_def", 0) * (1 + owner.fixedProp:getProp("fProp_m_def_percent", 0) / 10000) * (1 + (owner.fixedProp:getProp("e_m_def_percent", 0) + owner.fixedProp:getProp("e_def_percent", 0)) / 10000) + owner.fixedProp:getProp("e_m_def", 0) + owner.fixedProp:getProp("e_def", 0)) * (1 + owner.stateGroup:getProp("sProp_m_def_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_m_def", 0)
		owner.p_def = (owner.fixedProp:getProp("fProp_p_def", 0) * (1 + owner.fixedProp:getProp("fProp_p_def_percent", 0) / 10000) * (1 + (owner.fixedProp:getProp("e_p_def_percent", 0) + owner.fixedProp:getProp("e_def_percent", 0)) / 10000) + owner.fixedProp:getProp("e_p_def", 0) + owner.fixedProp:getProp("e_def", 0)) * (1 + owner.stateGroup:getProp("sProp_p_def_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_p_def", 0)
	end
end

function PropBoard.update_e_m_def(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("e_m_def")
	else
		owner.m_def = (owner.fixedProp:getProp("fProp_m_def", 0) * (1 + owner.fixedProp:getProp("fProp_m_def_percent", 0) / 10000) * (1 + (owner.fixedProp:getProp("e_m_def_percent", 0) + owner.fixedProp:getProp("e_def_percent", 0)) / 10000) + owner.fixedProp:getProp("e_m_def", 0) + owner.fixedProp:getProp("e_def", 0)) * (1 + owner.stateGroup:getProp("sProp_m_def_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_m_def", 0)
	end
end

function PropBoard.update_e_m_def_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("e_m_def_percent")
	else
		owner.m_def = (owner.fixedProp:getProp("fProp_m_def", 0) * (1 + owner.fixedProp:getProp("fProp_m_def_percent", 0) / 10000) * (1 + (owner.fixedProp:getProp("e_m_def_percent", 0) + owner.fixedProp:getProp("e_def_percent", 0)) / 10000) + owner.fixedProp:getProp("e_m_def", 0) + owner.fixedProp:getProp("e_def", 0)) * (1 + owner.stateGroup:getProp("sProp_m_def_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_m_def", 0)
	end
end

function PropBoard.update_e_mhp(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("e_mhp")
	else
		owner.mhp = (owner.fixedProp:getProp("fProp_mhp", 0) * (1 + owner.fixedProp:getProp("fProp_mhp_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("star_mhp_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("e_mhp_percent", 0) / 10000) + owner.fixedProp:getProp("e_mhp", 0)) * (1 + owner.stateGroup:getProp("sProp_mhp_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_mhp", 0)
	end
end

function PropBoard.update_e_mhp_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("e_mhp_percent")
	else
		owner.mhp = (owner.fixedProp:getProp("fProp_mhp", 0) * (1 + owner.fixedProp:getProp("fProp_mhp_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("star_mhp_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("e_mhp_percent", 0) / 10000) + owner.fixedProp:getProp("e_mhp", 0)) * (1 + owner.stateGroup:getProp("sProp_mhp_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_mhp", 0)
	end
end

function PropBoard.update_e_p_def(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("e_p_def")
	else
		owner.p_def = (owner.fixedProp:getProp("fProp_p_def", 0) * (1 + owner.fixedProp:getProp("fProp_p_def_percent", 0) / 10000) * (1 + (owner.fixedProp:getProp("e_p_def_percent", 0) + owner.fixedProp:getProp("e_def_percent", 0)) / 10000) + owner.fixedProp:getProp("e_p_def", 0) + owner.fixedProp:getProp("e_def", 0)) * (1 + owner.stateGroup:getProp("sProp_p_def_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_p_def", 0)
	end
end

function PropBoard.update_e_p_def_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("e_p_def_percent")
	else
		owner.p_def = (owner.fixedProp:getProp("fProp_p_def", 0) * (1 + owner.fixedProp:getProp("fProp_p_def_percent", 0) / 10000) * (1 + (owner.fixedProp:getProp("e_p_def_percent", 0) + owner.fixedProp:getProp("e_def_percent", 0)) / 10000) + owner.fixedProp:getProp("e_p_def", 0) + owner.fixedProp:getProp("e_def", 0)) * (1 + owner.stateGroup:getProp("sProp_p_def_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_p_def", 0)
	end
end

function PropBoard._calc_effect_hit(owner)
	owner.effect_hit = math.min(1, owner.fixedProp:getProp("fProp_effect_hit", 0) / 10000 + owner.stateGroup:getProp("sProp_effect_hit", 0) / 10000)
end

function PropBoard._calc_effect_miss(owner)
	owner.effect_miss = owner.fixedProp:getProp("fProp_effect_miss", 0) / 10000 + owner.stateGroup:getProp("sProp_effect_miss", 0) / 10000
end

function PropBoard.update_fProp_arp_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_arp_percent")
	else
		owner.arp_percent = owner.fixedProp:getProp("fProp_arp_percent", 0) / 10000 + owner.stateGroup:getProp("sProp_arp_percent", 0) / 10000
	end
end

function PropBoard.update_fProp_assist_enhance(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_assist_enhance")
	else
		owner.assist_enhance = owner.fixedProp:getProp("fProp_assist_enhance", 0) / 10000 + owner.stateGroup:getProp("sProp_assist_enhance", 0) / 10000
	end
end

function PropBoard.update_fProp_atk(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_atk")
	else
		owner.atk = (owner.fixedProp:getProp("fProp_atk", 0) * (1 + owner.fixedProp:getProp("fProp_atk_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("star_atk_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("e_atk_percent", 0) / 10000) + owner.fixedProp:getProp("e_atk", 0)) * (1 + owner.stateGroup:getProp("sProp_atk_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_atk", 0)
	end
end

function PropBoard.update_fProp_atk_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_atk_percent")
	else
		owner.atk = (owner.fixedProp:getProp("fProp_atk", 0) * (1 + owner.fixedProp:getProp("fProp_atk_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("star_atk_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("e_atk_percent", 0) / 10000) + owner.fixedProp:getProp("e_atk", 0)) * (1 + owner.stateGroup:getProp("sProp_atk_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_atk", 0)
	end
end

function PropBoard.update_fProp_attack_speed_up(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_attack_speed_up")
	else
		owner.attack_speed_up = 1 + (owner.fixedProp:getProp("fProp_attack_speed_up", 0) + owner.stateGroup:getProp("sProp_attack_speed_up", 0)) / 10000
	end
end

function PropBoard.update_fProp_cri_dmg(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_cri_dmg")
	else
		owner.cri_dmg = 1.5 + owner.fixedProp:getProp("fProp_cri_dmg", 0) / 10000 + owner.stateGroup:getProp("sProp_cri_dmg", 0) / 10000
	end
end

function PropBoard.update_fProp_cri_dmg_reduce(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_cri_dmg_reduce")
	else
		owner.cri_dmg_reduce = owner.fixedProp:getProp("fProp_cri_dmg_reduce", 0) / 10000 + owner.stateGroup:getProp("sProp_cri_dmg_reduce", 0) / 10000
	end
end

function PropBoard.update_fProp_cri_rate(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_cri_rate")
	else
		owner.cri_rate = owner.fixedProp:getProp("fProp_cri_rate", 0) / 10000 + owner.stateGroup:getProp("sProp_cri_rate", 0) / 10000
	end
end

function PropBoard.update_fProp_cri_reduce(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_cri_reduce")
	else
		owner.cri_reduce = owner.fixedProp:getProp("fProp_cri_reduce", 0) / 10000 + owner.stateGroup:getProp("sProp_cri_reduce", 0) / 10000
	end
end

function PropBoard.update_fProp_damage_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_damage_percent")
	else
		owner.damage_percent = owner.fixedProp:getProp("fProp_damage_percent", 0) / 10000 + owner.stateGroup:getProp("sProp_damage_percent", 0) / 10000
	end
end

function PropBoard.update_fProp_damage_reduce_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_damage_reduce_percent")
	else
		owner.damage_reduce_percent = owner.fixedProp:getProp("fProp_damage_reduce_percent", 0) / 10000 + owner.stateGroup:getProp("sProp_damage_reduce_percent", 0) / 10000
	end
end

function PropBoard.update_fProp_effect_hit(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_effect_hit")
	else
		owner.effect_hit = math.min(1, owner.fixedProp:getProp("fProp_effect_hit", 0) / 10000 + owner.stateGroup:getProp("sProp_effect_hit", 0) / 10000)
	end
end

function PropBoard.update_fProp_effect_miss(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_effect_miss")
	else
		owner.effect_miss = owner.fixedProp:getProp("fProp_effect_miss", 0) / 10000 + owner.stateGroup:getProp("sProp_effect_miss", 0) / 10000
	end
end

function PropBoard.update_fProp_fire_damage(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_fire_damage")
	else
		owner.fire_damage = owner.fixedProp:getProp("fProp_fire_damage", 0) / 10000 + owner.stateGroup:getProp("sProp_fire_damage", 0) / 10000
	end
end

function PropBoard.update_fProp_fire_damage_reduce(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_fire_damage_reduce")
	else
		owner.fire_damage_reduce = owner.fixedProp:getProp("fProp_fire_damage_reduce", 0) / 10000 + owner.stateGroup:getProp("sProp_fire_damage_reduce", 0) / 10000
	end
end

function PropBoard.update_fProp_heal_effect(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_heal_effect")
	else
		owner.heal_effect = 1 + owner.fixedProp:getProp("fProp_heal_effect", 0) / 10000 + owner.stateGroup:getProp("sProp_heal_effect", 0) / 10000
	end
end

function PropBoard.update_fProp_heal_enhance_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_heal_enhance_percent")
	else
		owner.heal_enhance_percent = 1 + owner.fixedProp:getProp("fProp_heal_enhance_percent", 0) / 10000 + owner.stateGroup:getProp("sProp_heal_enhance_percent", 0) / 10000
	end
end

function PropBoard.update_fProp_ice_damage(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_ice_damage")
	else
		owner.ice_damage = owner.fixedProp:getProp("fProp_ice_damage", 0) / 10000 + owner.stateGroup:getProp("sProp_ice_damage", 0) / 10000
	end
end

function PropBoard.update_fProp_ice_damage_reduce(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_ice_damage_reduce")
	else
		owner.ice_damage_reduce = owner.fixedProp:getProp("fProp_ice_damage_reduce", 0) / 10000 + owner.stateGroup:getProp("sProp_ice_damage_reduce", 0) / 10000
	end
end

function PropBoard.update_fProp_life_reply(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_life_reply")
	else
		owner.life_reply = owner.fixedProp:getProp("fProp_life_reply", 0) + owner.stateGroup:getProp("sProp_life_reply", 0)
	end
end

function PropBoard.update_fProp_m_def(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_m_def")
	else
		owner.m_def = (owner.fixedProp:getProp("fProp_m_def", 0) * (1 + owner.fixedProp:getProp("fProp_m_def_percent", 0) / 10000) * (1 + (owner.fixedProp:getProp("e_m_def_percent", 0) + owner.fixedProp:getProp("e_def_percent", 0)) / 10000) + owner.fixedProp:getProp("e_m_def", 0) + owner.fixedProp:getProp("e_def", 0)) * (1 + owner.stateGroup:getProp("sProp_m_def_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_m_def", 0)
	end
end

function PropBoard.update_fProp_m_def_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_m_def_percent")
	else
		owner.m_def = (owner.fixedProp:getProp("fProp_m_def", 0) * (1 + owner.fixedProp:getProp("fProp_m_def_percent", 0) / 10000) * (1 + (owner.fixedProp:getProp("e_m_def_percent", 0) + owner.fixedProp:getProp("e_def_percent", 0)) / 10000) + owner.fixedProp:getProp("e_m_def", 0) + owner.fixedProp:getProp("e_def", 0)) * (1 + owner.stateGroup:getProp("sProp_m_def_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_m_def", 0)
	end
end

function PropBoard.update_fProp_mana_gen(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_mana_gen")
	else
		owner.mana_gen = owner.fixedProp:getProp("fProp_mana_gen", 0) + owner.stateGroup:getProp("sProp_mana_gen", 0)
	end
end

function PropBoard.update_fProp_mhp(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_mhp")
	else
		owner.mhp = (owner.fixedProp:getProp("fProp_mhp", 0) * (1 + owner.fixedProp:getProp("fProp_mhp_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("star_mhp_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("e_mhp_percent", 0) / 10000) + owner.fixedProp:getProp("e_mhp", 0)) * (1 + owner.stateGroup:getProp("sProp_mhp_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_mhp", 0)
	end
end

function PropBoard.update_fProp_mhp_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_mhp_percent")
	else
		owner.mhp = (owner.fixedProp:getProp("fProp_mhp", 0) * (1 + owner.fixedProp:getProp("fProp_mhp_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("star_mhp_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("e_mhp_percent", 0) / 10000) + owner.fixedProp:getProp("e_mhp", 0)) * (1 + owner.stateGroup:getProp("sProp_mhp_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_mhp", 0)
	end
end

function PropBoard.update_fProp_miss(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_miss")
	else
		owner.miss = owner.fixedProp:getProp("fProp_miss", 0) / 10000 + owner.stateGroup:getProp("sProp_miss", 0) / 10000
	end
end

function PropBoard.update_fProp_p_def(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_p_def")
	else
		owner.p_def = (owner.fixedProp:getProp("fProp_p_def", 0) * (1 + owner.fixedProp:getProp("fProp_p_def_percent", 0) / 10000) * (1 + (owner.fixedProp:getProp("e_p_def_percent", 0) + owner.fixedProp:getProp("e_def_percent", 0)) / 10000) + owner.fixedProp:getProp("e_p_def", 0) + owner.fixedProp:getProp("e_def", 0)) * (1 + owner.stateGroup:getProp("sProp_p_def_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_p_def", 0)
	end
end

function PropBoard.update_fProp_p_def_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_p_def_percent")
	else
		owner.p_def = (owner.fixedProp:getProp("fProp_p_def", 0) * (1 + owner.fixedProp:getProp("fProp_p_def_percent", 0) / 10000) * (1 + (owner.fixedProp:getProp("e_p_def_percent", 0) + owner.fixedProp:getProp("e_def_percent", 0)) / 10000) + owner.fixedProp:getProp("e_p_def", 0) + owner.fixedProp:getProp("e_def", 0)) * (1 + owner.stateGroup:getProp("sProp_p_def_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_p_def", 0)
	end
end

function PropBoard.update_fProp_spp_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("fProp_spp_percent")
	else
		owner.spp_percent = owner.fixedProp:getProp("fProp_spp_percent", 0) / 10000 + owner.stateGroup:getProp("sProp_spp_percent", 0) / 10000
	end
end

function PropBoard._calc_fire_damage(owner)
	owner.fire_damage = owner.fixedProp:getProp("fProp_fire_damage", 0) / 10000 + owner.stateGroup:getProp("sProp_fire_damage", 0) / 10000
end

function PropBoard._calc_fire_damage_reduce(owner)
	owner.fire_damage_reduce = owner.fixedProp:getProp("fProp_fire_damage_reduce", 0) / 10000 + owner.stateGroup:getProp("sProp_fire_damage_reduce", 0) / 10000
end

function PropBoard._calc_heal_effect(owner)
	owner.heal_effect = 1 + owner.fixedProp:getProp("fProp_heal_effect", 0) / 10000 + owner.stateGroup:getProp("sProp_heal_effect", 0) / 10000
end

function PropBoard._calc_heal_enhance_percent(owner)
	owner.heal_enhance_percent = 1 + owner.fixedProp:getProp("fProp_heal_enhance_percent", 0) / 10000 + owner.stateGroup:getProp("sProp_heal_enhance_percent", 0) / 10000
end

function PropBoard._calc_hit_rate(owner)
	owner.hit_rate = 1 + owner.stateGroup:getProp("sProp_hit_rate", 0) / 10000
end

function PropBoard._calc_ice_damage(owner)
	owner.ice_damage = owner.fixedProp:getProp("fProp_ice_damage", 0) / 10000 + owner.stateGroup:getProp("sProp_ice_damage", 0) / 10000
end

function PropBoard._calc_ice_damage_reduce(owner)
	owner.ice_damage_reduce = owner.fixedProp:getProp("fProp_ice_damage_reduce", 0) / 10000 + owner.stateGroup:getProp("sProp_ice_damage_reduce", 0) / 10000
end

function PropBoard._calc_life_reply(owner)
	owner.life_reply = owner.fixedProp:getProp("fProp_life_reply", 0) + owner.stateGroup:getProp("sProp_life_reply", 0)
end

function PropBoard._calc_m_def(owner)
	owner.m_def = (owner.fixedProp:getProp("fProp_m_def", 0) * (1 + owner.fixedProp:getProp("fProp_m_def_percent", 0) / 10000) * (1 + (owner.fixedProp:getProp("e_m_def_percent", 0) + owner.fixedProp:getProp("e_def_percent", 0)) / 10000) + owner.fixedProp:getProp("e_m_def", 0) + owner.fixedProp:getProp("e_def", 0)) * (1 + owner.stateGroup:getProp("sProp_m_def_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_m_def", 0)
end

function PropBoard._calc_mana_gen(owner)
	owner.mana_gen = owner.fixedProp:getProp("fProp_mana_gen", 0) + owner.stateGroup:getProp("sProp_mana_gen", 0)
end

function PropBoard._calc_mhp(owner)
	owner.mhp = (owner.fixedProp:getProp("fProp_mhp", 0) * (1 + owner.fixedProp:getProp("fProp_mhp_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("star_mhp_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("e_mhp_percent", 0) / 10000) + owner.fixedProp:getProp("e_mhp", 0)) * (1 + owner.stateGroup:getProp("sProp_mhp_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_mhp", 0)
end

function PropBoard._calc_miss(owner)
	owner.miss = owner.fixedProp:getProp("fProp_miss", 0) / 10000 + owner.stateGroup:getProp("sProp_miss", 0) / 10000
end

function PropBoard._calc_p_def(owner)
	owner.p_def = (owner.fixedProp:getProp("fProp_p_def", 0) * (1 + owner.fixedProp:getProp("fProp_p_def_percent", 0) / 10000) * (1 + (owner.fixedProp:getProp("e_p_def_percent", 0) + owner.fixedProp:getProp("e_def_percent", 0)) / 10000) + owner.fixedProp:getProp("e_p_def", 0) + owner.fixedProp:getProp("e_def", 0)) * (1 + owner.stateGroup:getProp("sProp_p_def_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_p_def", 0)
end

function PropBoard.update_sProp_arp_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_arp_percent")
	else
		owner.arp_percent = owner.fixedProp:getProp("fProp_arp_percent", 0) / 10000 + owner.stateGroup:getProp("sProp_arp_percent", 0) / 10000
	end
end

function PropBoard.update_sProp_assist_enhance(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_assist_enhance")
	else
		owner.assist_enhance = owner.fixedProp:getProp("fProp_assist_enhance", 0) / 10000 + owner.stateGroup:getProp("sProp_assist_enhance", 0) / 10000
	end
end

function PropBoard.update_sProp_atk(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_atk")
	else
		owner.atk = (owner.fixedProp:getProp("fProp_atk", 0) * (1 + owner.fixedProp:getProp("fProp_atk_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("star_atk_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("e_atk_percent", 0) / 10000) + owner.fixedProp:getProp("e_atk", 0)) * (1 + owner.stateGroup:getProp("sProp_atk_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_atk", 0)
	end
end

function PropBoard.update_sProp_atk_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_atk_percent")
	else
		owner.atk = (owner.fixedProp:getProp("fProp_atk", 0) * (1 + owner.fixedProp:getProp("fProp_atk_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("star_atk_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("e_atk_percent", 0) / 10000) + owner.fixedProp:getProp("e_atk", 0)) * (1 + owner.stateGroup:getProp("sProp_atk_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_atk", 0)
	end
end

function PropBoard.update_sProp_attack_speed_up(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_attack_speed_up")
	else
		owner.attack_speed_up = 1 + (owner.fixedProp:getProp("fProp_attack_speed_up", 0) + owner.stateGroup:getProp("sProp_attack_speed_up", 0)) / 10000
	end
end

function PropBoard.update_sProp_cri_dmg(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_cri_dmg")
	else
		owner.cri_dmg = 1.5 + owner.fixedProp:getProp("fProp_cri_dmg", 0) / 10000 + owner.stateGroup:getProp("sProp_cri_dmg", 0) / 10000
	end
end

function PropBoard.update_sProp_cri_dmg_reduce(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_cri_dmg_reduce")
	else
		owner.cri_dmg_reduce = owner.fixedProp:getProp("fProp_cri_dmg_reduce", 0) / 10000 + owner.stateGroup:getProp("sProp_cri_dmg_reduce", 0) / 10000
	end
end

function PropBoard.update_sProp_cri_rate(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_cri_rate")
	else
		owner.cri_rate = owner.fixedProp:getProp("fProp_cri_rate", 0) / 10000 + owner.stateGroup:getProp("sProp_cri_rate", 0) / 10000
	end
end

function PropBoard.update_sProp_cri_reduce(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_cri_reduce")
	else
		owner.cri_reduce = owner.fixedProp:getProp("fProp_cri_reduce", 0) / 10000 + owner.stateGroup:getProp("sProp_cri_reduce", 0) / 10000
	end
end

function PropBoard.update_sProp_damage_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_damage_percent")
	else
		owner.damage_percent = owner.fixedProp:getProp("fProp_damage_percent", 0) / 10000 + owner.stateGroup:getProp("sProp_damage_percent", 0) / 10000
	end
end

function PropBoard.update_sProp_damage_reduce_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_damage_reduce_percent")
	else
		owner.damage_reduce_percent = owner.fixedProp:getProp("fProp_damage_reduce_percent", 0) / 10000 + owner.stateGroup:getProp("sProp_damage_reduce_percent", 0) / 10000
	end
end

function PropBoard.update_sProp_effect_hit(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_effect_hit")
	else
		owner.effect_hit = math.min(1, owner.fixedProp:getProp("fProp_effect_hit", 0) / 10000 + owner.stateGroup:getProp("sProp_effect_hit", 0) / 10000)
	end
end

function PropBoard.update_sProp_effect_miss(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_effect_miss")
	else
		owner.effect_miss = owner.fixedProp:getProp("fProp_effect_miss", 0) / 10000 + owner.stateGroup:getProp("sProp_effect_miss", 0) / 10000
	end
end

function PropBoard.update_sProp_fire_damage(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_fire_damage")
	else
		owner.fire_damage = owner.fixedProp:getProp("fProp_fire_damage", 0) / 10000 + owner.stateGroup:getProp("sProp_fire_damage", 0) / 10000
	end
end

function PropBoard.update_sProp_fire_damage_reduce(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_fire_damage_reduce")
	else
		owner.fire_damage_reduce = owner.fixedProp:getProp("fProp_fire_damage_reduce", 0) / 10000 + owner.stateGroup:getProp("sProp_fire_damage_reduce", 0) / 10000
	end
end

function PropBoard.update_sProp_heal_effect(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_heal_effect")
	else
		owner.heal_effect = 1 + owner.fixedProp:getProp("fProp_heal_effect", 0) / 10000 + owner.stateGroup:getProp("sProp_heal_effect", 0) / 10000
	end
end

function PropBoard.update_sProp_heal_enhance_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_heal_enhance_percent")
	else
		owner.heal_enhance_percent = 1 + owner.fixedProp:getProp("fProp_heal_enhance_percent", 0) / 10000 + owner.stateGroup:getProp("sProp_heal_enhance_percent", 0) / 10000
	end
end

function PropBoard.update_sProp_hit_rate(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_hit_rate")
	else
		owner.hit_rate = 1 + owner.stateGroup:getProp("sProp_hit_rate", 0) / 10000
	end
end

function PropBoard.update_sProp_ice_damage(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_ice_damage")
	else
		owner.ice_damage = owner.fixedProp:getProp("fProp_ice_damage", 0) / 10000 + owner.stateGroup:getProp("sProp_ice_damage", 0) / 10000
	end
end

function PropBoard.update_sProp_ice_damage_reduce(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_ice_damage_reduce")
	else
		owner.ice_damage_reduce = owner.fixedProp:getProp("fProp_ice_damage_reduce", 0) / 10000 + owner.stateGroup:getProp("sProp_ice_damage_reduce", 0) / 10000
	end
end

function PropBoard.update_sProp_life_reply(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_life_reply")
	else
		owner.life_reply = owner.fixedProp:getProp("fProp_life_reply", 0) + owner.stateGroup:getProp("sProp_life_reply", 0)
	end
end

function PropBoard.update_sProp_m_def(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_m_def")
	else
		owner.m_def = (owner.fixedProp:getProp("fProp_m_def", 0) * (1 + owner.fixedProp:getProp("fProp_m_def_percent", 0) / 10000) * (1 + (owner.fixedProp:getProp("e_m_def_percent", 0) + owner.fixedProp:getProp("e_def_percent", 0)) / 10000) + owner.fixedProp:getProp("e_m_def", 0) + owner.fixedProp:getProp("e_def", 0)) * (1 + owner.stateGroup:getProp("sProp_m_def_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_m_def", 0)
	end
end

function PropBoard.update_sProp_m_def_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_m_def_percent")
	else
		owner.m_def = (owner.fixedProp:getProp("fProp_m_def", 0) * (1 + owner.fixedProp:getProp("fProp_m_def_percent", 0) / 10000) * (1 + (owner.fixedProp:getProp("e_m_def_percent", 0) + owner.fixedProp:getProp("e_def_percent", 0)) / 10000) + owner.fixedProp:getProp("e_m_def", 0) + owner.fixedProp:getProp("e_def", 0)) * (1 + owner.stateGroup:getProp("sProp_m_def_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_m_def", 0)
	end
end

function PropBoard.update_sProp_mana_gen(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_mana_gen")
	else
		owner.mana_gen = owner.fixedProp:getProp("fProp_mana_gen", 0) + owner.stateGroup:getProp("sProp_mana_gen", 0)
	end
end

function PropBoard.update_sProp_mhp(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_mhp")
	else
		owner.mhp = (owner.fixedProp:getProp("fProp_mhp", 0) * (1 + owner.fixedProp:getProp("fProp_mhp_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("star_mhp_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("e_mhp_percent", 0) / 10000) + owner.fixedProp:getProp("e_mhp", 0)) * (1 + owner.stateGroup:getProp("sProp_mhp_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_mhp", 0)
	end
end

function PropBoard.update_sProp_mhp_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_mhp_percent")
	else
		owner.mhp = (owner.fixedProp:getProp("fProp_mhp", 0) * (1 + owner.fixedProp:getProp("fProp_mhp_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("star_mhp_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("e_mhp_percent", 0) / 10000) + owner.fixedProp:getProp("e_mhp", 0)) * (1 + owner.stateGroup:getProp("sProp_mhp_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_mhp", 0)
	end
end

function PropBoard.update_sProp_miss(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_miss")
	else
		owner.miss = owner.fixedProp:getProp("fProp_miss", 0) / 10000 + owner.stateGroup:getProp("sProp_miss", 0) / 10000
	end
end

function PropBoard.update_sProp_p_def(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_p_def")
	else
		owner.p_def = (owner.fixedProp:getProp("fProp_p_def", 0) * (1 + owner.fixedProp:getProp("fProp_p_def_percent", 0) / 10000) * (1 + (owner.fixedProp:getProp("e_p_def_percent", 0) + owner.fixedProp:getProp("e_def_percent", 0)) / 10000) + owner.fixedProp:getProp("e_p_def", 0) + owner.fixedProp:getProp("e_def", 0)) * (1 + owner.stateGroup:getProp("sProp_p_def_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_p_def", 0)
	end
end

function PropBoard.update_sProp_p_def_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_p_def_percent")
	else
		owner.p_def = (owner.fixedProp:getProp("fProp_p_def", 0) * (1 + owner.fixedProp:getProp("fProp_p_def_percent", 0) / 10000) * (1 + (owner.fixedProp:getProp("e_p_def_percent", 0) + owner.fixedProp:getProp("e_def_percent", 0)) / 10000) + owner.fixedProp:getProp("e_p_def", 0) + owner.fixedProp:getProp("e_def", 0)) * (1 + owner.stateGroup:getProp("sProp_p_def_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_p_def", 0)
	end
end

function PropBoard.update_sProp_spp_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("sProp_spp_percent")
	else
		owner.spp_percent = owner.fixedProp:getProp("fProp_spp_percent", 0) / 10000 + owner.stateGroup:getProp("sProp_spp_percent", 0) / 10000
	end
end

function PropBoard._calc_spp_percent(owner)
	owner.spp_percent = owner.fixedProp:getProp("fProp_spp_percent", 0) / 10000 + owner.stateGroup:getProp("sProp_spp_percent", 0) / 10000
end

function PropBoard.update_star_atk_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("star_atk_percent")
	else
		owner.atk = (owner.fixedProp:getProp("fProp_atk", 0) * (1 + owner.fixedProp:getProp("fProp_atk_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("star_atk_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("e_atk_percent", 0) / 10000) + owner.fixedProp:getProp("e_atk", 0)) * (1 + owner.stateGroup:getProp("sProp_atk_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_atk", 0)
	end
end

function PropBoard.update_star_mhp_percent(owner)
	if owner.prop_delay_mode then
		owner.update_prop_delayed("star_mhp_percent")
	else
		owner.mhp = (owner.fixedProp:getProp("fProp_mhp", 0) * (1 + owner.fixedProp:getProp("fProp_mhp_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("star_mhp_percent", 0) / 10000) * (1 + owner.fixedProp:getProp("e_mhp_percent", 0) / 10000) + owner.fixedProp:getProp("e_mhp", 0)) * (1 + owner.stateGroup:getProp("sProp_mhp_percent", 0) / 10000) + owner.stateGroup:getProp("sProp_mhp", 0)
	end
end

function PropBoard.set_default_props(owner)
	owner.e_atk_percent = 0
	owner.e_p_def_percent = 0
	owner.e_def = 0
	owner.arp_percent = 0
	owner.fProp_spp_percent = 0
	owner.fProp_p_def_percent = 0
	owner.fProp_mhp_percent = 0
	owner.atk = 0
	owner.fProp_damage_percent = 0
	owner.fProp_m_def = 0
	owner.attack_speed_up = 0
	owner.fProp_effect_hit = 0
	owner.mana_gen = 0
	owner.fProp_heal_enhance_percent = 0
	owner.fProp_mhp = 0
	owner.fProp_fire_damage = 0
	owner.fire_damage_reduce = 0
	owner.miss = 0
	owner.effect_miss = 0
	owner.ice_damage = 0
	owner.effect_hit = 0
	owner.damage_percent = 0
	owner.e_mhp = 0
	owner.fProp_cri_reduce = 0
	owner.fProp_cri_dmg_reduce = 0
	owner.e_m_def_percent = 0
	owner.fProp_p_def = 0
	owner.fProp_m_def_percent = 0
	owner.assist_enhance = 0
	owner.fProp_cri_dmg = 0
	owner.fProp_ice_damage_reduce = 0
	owner.fProp_life_reply = 0
	owner.m_def = 0
	owner.spp_percent = 0
	owner.heal_effect = 0
	owner.fProp_cri_rate = 0
	owner.e_atk = 0
	owner.cri_reduce = 0
	owner.cri_dmg_reduce = 0
	owner.fProp_mana_gen = 0
	owner.e_mhp_percent = 0
	owner.e_def_percent = 0
	owner.damage_reduce_percent = 0
	owner.fProp_fire_damage_reduce = 0
	owner.fProp_ice_damage = 0
	owner.p_def = 0
	owner.fProp_effect_miss = 0
	owner.fProp_heal_effect = 0
	owner.fProp_atk = 0
	owner.fProp_arp_percent = 0
	owner.cri_rate = 0
	owner.ice_damage_reduce = 0
	owner.cri_dmg = 0
	owner.e_p_def = 0
	owner.fProp_attack_speed_up = 0
	owner.star_mhp_percent = 0
	owner.fire_damage = 0
	owner.fProp_damage_reduce_percent = 0
	owner.life_reply = 0
	owner.e_m_def = 0
	owner.fProp_assist_enhance = 0
	owner.fProp_miss = 0
	owner.fProp_atk_percent = 0
	owner.star_atk_percent = 0
	owner.heal_enhance_percent = 0
	owner.hit_rate = 0
	owner.mhp = 0
end

function PropBoard.init_props(owner)
	for name, lv in pairs(PropBoard.PROP_LEVELS) do
		if lv > 1 then
			local func = PropBoard["_calc_" .. name]

			if func then
				func(owner)
			end
		end
	end
end

return PropBoard
