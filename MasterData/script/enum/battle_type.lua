local var_0_0 = {
	obj_side = {
		enemy = -1,
		player = 1,
		opposite = function(arg_1_0)
			if arg_1_0 == 1 then
				return -1
			end

			if arg_1_0 == -1 then
				return 1
			end
		end
	},
	fight_type = {
		plot_main = 99,
		maneuver = 3,
		abyss = 10,
		push = 12,
		strike = 8,
		climb_tower = 5,
		abyss_2 = 11,
		ocean_attack = 6,
		sixth = 4,
		war_concerto_play = 9,
		campaign = 2,
		score = 14,
		seventh = 13,
		main = 1,
		eighth = 15,
		war_concerto = 7,
		ninth = 17
	},
	ship_state = {
		normal = {
			value = 1,
			min = 0.5,
			addition = 1,
			max = 1
		},
		middle_break = {
			value = 2,
			min = 0.25,
			addition = 0.6,
			max = 0.5
		},
		big_break = {
			value = 3,
			min = 0,
			addition = 0.3,
			max = 0.25
		}
	},
	battle_event_type = {
		character = {
			name = "character",
			event = {
				normal_attack = "normal_attack",
				open_torpedo_attack = "open_torpedo_attack",
				normal_attack2 = "normal_attack2",
				buff = "buff_step",
				register = "register",
				torpedo_attack = "torpedo_attack",
				night_missile_attack = "night_missile_attack",
				open_missile_attack = "open_missile_attack",
				open_antisub_attack = "open_antisub_attack",
				aircraft_attack = "aircraft_attack",
				night_mix_attack = "night_mix_attack",
				night_antisub_attack = "night_antisub_attack",
				night_torpedo_attack = "night_torpedo_attack",
				night_normal_attack = "night_normal_attack",
				close_missile_attack = "close_missile_attack"
			}
		},
		aircraft = {
			name = "aircraft",
			event = {
				register = "register"
			}
		},
		bomb = {
			name = "bomb",
			event = {
				register = "register"
			}
		},
		projectile = {
			name = "projectile",
			event = {
				register = "register"
			}
		},
		depthcharge = {
			name = "depthcharge",
			event = {
				register = "register"
			}
		},
		missile = {
			name = "missile",
			event = {
				register = "register"
			}
		},
		booster = {
			name = "booster",
			event = {
				register = "register"
			}
		},
		torpedo = {
			name = "torpedo",
			event = {
				register = "register",
				exhaust = "exhaust",
				hit = "hit",
				dispose = "dispose"
			}
		}
	},
	support_attack_type = {
		water_attack = 3,
		cannon_attack = 1,
		bombs_attack = 2
	},
	air_control_type = {
		supremacy = {
			value = 1,
			hit_rate = 0.1,
			r2 = 1,
			opposite = 5,
			r1 = 0.9,
			damage_rate = 1.1
		},
		advantage = {
			value = 2,
			hit_rate = 0.05,
			r2 = 0.9,
			opposite = 4,
			r1 = 0.7,
			damage_rate = 1.05
		},
		equl = {
			value = 3,
			hit_rate = 0,
			r2 = 0.7,
			opposite = 3,
			r1 = 0.3,
			damage_rate = 1
		},
		weakness = {
			value = 4,
			hit_rate = -0.05,
			r2 = 0.3,
			opposite = 2,
			r1 = 0.1,
			damage_rate = 0.95
		},
		loss = {
			value = 5,
			hit_rate = -0.1,
			r2 = 0.1,
			opposite = 1,
			r1 = 0,
			damage_rate = 0.9
		}
	},
	air_control_rule = {
		{
			num2 = 0,
			num1 = 0
		}
	},
	equip_type = {
		anti_sub = 14,
		bullet = 10,
		module = 9,
		main_gun = 1,
		air_defense_missile_launcher = 33,
		anti_ship_missile = 34,
		torpedo = 3,
		air_defense_missile = 35,
		spy_plane = 7,
		bomber = 6,
		torpedo_plane = 4,
		anti_ship_missile_launcher = 32,
		sub_gun = 2,
		aagun = 11,
		fighter = 5,
		special_torpedo = 12,
		repairs = 13,
		radar = 8
	},
	equip_bore_type = {
		repairman = 13,
		enhanced_components_general = 9,
		sonar = 18,
		main_gun_8_inches = 23,
		torpedo_submarine = 22,
		enhanced_components_large_armor = 20,
		for_npc = 15,
		torpedo_machine_by_heavy_air_ship = 29,
		main_gun_medium_caliber = 16,
		enhanced_components_submarine = 37,
		air_defense_missile_launcher = 33,
		shell_only_big_ship = 26,
		enhanced_components_air_ship = 28,
		shell = 10,
		main_gun_by_ship_type = 40,
		anti_ship_missile = 34,
		air_defense_machine_gun = 11,
		shell_special_for_heavy_patrol = 27,
		auxiliary_gun = 2,
		enhanced_components_by_air = 30,
		fighter_by_ship_type = 36,
		special_torpedo = 12,
		main_gun_small_bore = 1,
		radar = 8,
		anti_submarine_equipment = 14,
		enhanced_components_medium_armor = 19,
		air_defense_missile_system = 39,
		torpedo_machine = 4,
		main_gun_submarine_only = 24,
		smoke_bomb = 21,
		radar_by_ship_type = 31,
		torpedo = 3,
		air_defense_missile = 35,
		main_gun_large_caliber = 17,
		bomber = 6,
		bomber_air_combat_cruise_available = 25,
		anti_ship_missile_launcher = 32,
		heavy_air_defense_missile = 38,
		fighter = 5,
		reconnaissance_aircraft = 7
	},
	equip_attribute_type = {
		"hp",
		"atk",
		"torpedo",
		"aircraft_atk",
		"air_def",
		"antisub",
		"radar",
		"hit",
		"range",
		"miss",
		"luck",
		"missile_hit",
		"missile_tmd",
		"def",
		"air_def_correct",
		"ap"
	},
	equip_special_effect_type = {
		reduce_enemy_aircraft_hit = 12,
		aircraft_normal_hit = 10,
		aircraft_attack_bomber = 5,
		torpedo_plane_hit = 7,
		reduce_enemy_missile_hit = 9,
		aircraft_attack_torpedo = 16,
		reduce_enemy_torpedo_plane_hit = 13,
		torpedo_attack_hit = 11,
		normal_attack_atk_rate = 4,
		ap = 3
	},
	skil_attribute_type = {
		"hp",
		"atk",
		"def",
		"torpedo",
		"miss",
		"air_def",
		nil,
		nil,
		"antisub",
		"speed",
		"radar",
		"range",
		"luck",
		"hit_repair",
		"miss_repair",
		"crit_repair",
		"hit",
		"now_hp",
		"ship_air_def"
	},
	character_attribute_type = {
		"hp",
		"atk",
		"def",
		"miss",
		"capacity",
		"speed",
		"range",
		"torpedo",
		"air_def",
		"antisub",
		"radar",
		"hit",
		"luck",
		"air_def_correct",
		"aircraft_atk",
		"crit",
		"now_hp",
		"hit_repair",
		"miss_repair",
		"crit_repair"
	},
	enemy_attribute_type = {
		"hp",
		"atk",
		"def",
		"torpedo",
		"hit",
		"miss",
		"air_def",
		"antisub",
		"speed",
		"radar",
		"range",
		"luck",
		"hit_repair",
		"miss_repair",
		"crit_repair"
	},
	effect_attribute_type = {
		"air_air_def",
		"aircraft_atk",
		"airtorpedo_atk",
		"aircraft_hit",
		"airtorpedo_hit",
		"hp",
		"atk",
		"def",
		"torpedo",
		"miss",
		"air_def",
		"antisub",
		"speed",
		"radar",
		"range",
		"luck",
		"crit",
		"crited",
		"hit",
		"exp",
		"crit_hurt",
		"hurt_rate",
		"hurt",
		"defNum",
		"hurted_rate",
		"air_control",
		"miss_rate",
		"atked_weight"
	},
	tower_attribute_type = {
		"hp",
		"atk",
		"def",
		"torpedo",
		"miss",
		"air_def",
		"capacity",
		"capacity_slot",
		"antisub",
		"speed",
		"radar",
		"range",
		"luck",
		"hit_repair",
		"miss_repair",
		"crit_repair",
		"hit"
	},
	ship_ton_type = {
		small = {
			value = 1,
			add_rate = 600,
			mul_rate = 2,
			hit_rate = 0.5
		},
		middle = {
			value = 2,
			add_rate = 150,
			mul_rate = 0.8,
			hit_rate = 0.75
		},
		big = {
			value = 3,
			add_rate = 60,
			mul_rate = 0.2,
			hit_rate = 1
		}
	},
	attribute_name_cn = {
		now_hp = "当前耐久",
		def = "装甲",
		crit_hurt = "暴击伤害",
		hurt = "耐久",
		crited = "被暴击",
		atked_weight = "被攻击权重",
		ship_air_def = "裸防空",
		capacity_slot = "搭载",
		torpedo = "鱼雷",
		hurted_rate = "受到伤害",
		capacity = "搭载",
		atk = "火力",
		air_air_def = "战斗机对空",
		air_control = "制空值",
		aircraft_hit = "轰炸机命中",
		crit = "暴击",
		miss_rate = "闪避率",
		range = "射程",
		crit_repair = "暴击补正",
		airtorpedo_atk = "鱼雷机威力",
		speed = "航速",
		luck = "幸运",
		hp = "最大耐久",
		miss = "闪避",
		antisub = "对潜",
		hit_repair = "命中补正",
		radar = "索敌",
		miss_repair = "闪避补正",
		exp = "经验",
		airtorpedo_hit = "鱼雷机命中",
		air_def_correct = "对空补正",
		hit = "命中",
		hurt_rate = "最终伤害",
		aircraft_atk = "爆装",
		air_def = "防空",
		defNum = "穿甲百分比"
	},
	ship_type_name_cn = {
		"航母",
		"轻母",
		"装母",
		"战列",
		"航战",
		"战巡",
		"重巡",
		"航巡",
		"雷巡",
		"轻巡",
		"重炮",
		"驱逐",
		"导潜",
		"潜艇",
		"炮潜",
		"补给",
		"要塞",
		"机场",
		"港口",
		"商船",
		"登陆",
		"海盗",
		"通驱",
		"防驱",
		"雷巡",
		"大巡",
		"导弹战列舰",
		"航巡",
		"防空导弹巡洋舰",
		"导弹巡洋舰",
		"防战",
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		nil,
		"协调舰",
		"未知",
		"旗舰"
	},
	ship_ton_name_cn = {
		"小型船",
		"中型船",
		"大型船"
	},
	trigger_type_name_cn = {
		[0] = "全阶段",
		"被动",
		"航空战阶段",
		"开幕反潜阶段",
		"开幕鱼雷阶段",
		"炮击战阶段",
		"闭幕鱼雷阶段",
		"夜战阶段",
		"开幕导弹阶段",
		"首轮炮击战阶段",
		"次轮炮击战阶段",
		"战斗结束后",
		"昼战阶段",
		"远征阶段",
		"演习阶段",
		"闭幕导弹阶段",
		[101] = "支援攻击阶段",
		[100] = "buff阶段"
	},
	radra_correct = {
		success = {
			value = true,
			hit_rate = 0.05,
			miss_rate = 0.05
		},
		fail = {
			value = false,
			hit_rate = 0,
			miss_rate = 0
		}
	},
	formation_type = {},
	formation_type_rule = {
		single = {
			double_air_def_correct = 1,
			value = 1,
			crited_rate = 0,
			crit_rate = 0,
			normal_attack = {
				power_addition = 1,
				hit_addition = 1.1,
				miss_addition = 0.9
			},
			missile_attack = {
				power_addition = 1,
				hit_addition = 1.1,
				miss_addition = 0.9
			},
			torpedo_attack = {
				power_addition = 1,
				hit_addition = 1,
				miss_addition = 0.9
			},
			antisub_attack = {
				power_addition = 1,
				hit_addition = 1,
				miss_addition = 0.8
			},
			aircraft_attack = {
				power_addition = 1,
				hit_addition = 1,
				miss_addition = 0.8
			},
			night_attack = {
				power_addition = 1.1,
				hit_addition = 1,
				miss_addition = 1
			}
		},
		double = {
			double_air_def_correct = 1.2,
			value = 2,
			crited_rate = 0,
			crit_rate = 0,
			normal_attack = {
				power_addition = 0.8,
				hit_addition = 1,
				miss_addition = 1.2
			},
			missile_attack = {
				power_addition = 0.8,
				hit_addition = 1,
				miss_addition = 1.2
			},
			torpedo_attack = {
				power_addition = 0.9,
				hit_addition = 1.1,
				miss_addition = 1.2
			},
			antisub_attack = {
				power_addition = 1,
				hit_addition = 1,
				miss_addition = 1
			},
			aircraft_attack = {
				power_addition = 1,
				hit_addition = 1,
				miss_addition = 1
			},
			night_attack = {
				power_addition = 0.9,
				hit_addition = 1.1,
				miss_addition = 1.1
			}
		},
		wheel = {
			double_air_def_correct = 1.6,
			value = 3,
			crited_rate = 0,
			crit_rate = 0,
			normal_attack = {
				power_addition = 0.75,
				hit_addition = 0.9,
				miss_addition = 0.9
			},
			missile_attack = {
				power_addition = 0.75,
				hit_addition = 0.9,
				miss_addition = 0.9
			},
			torpedo_attack = {
				power_addition = 0.8,
				hit_addition = 0.9,
				miss_addition = 0.9
			},
			antisub_attack = {
				power_addition = 1,
				hit_addition = 1,
				miss_addition = 1.2
			},
			aircraft_attack = {
				power_addition = 1,
				hit_addition = 1,
				miss_addition = 1.2
			},
			night_attack = {
				power_addition = 1,
				hit_addition = 1,
				miss_addition = 0.9
			}
		},
		trapezoidal = {
			double_air_def_correct = 1,
			value = 4,
			crited_rate = 0.25,
			crit_rate = 0.25,
			normal_attack = {
				power_addition = 1,
				hit_addition = 1.2,
				miss_addition = 0.8
			},
			missile_attack = {
				power_addition = 1,
				hit_addition = 1.2,
				miss_addition = 0.8
			},
			torpedo_attack = {
				power_addition = 1,
				hit_addition = 1.2,
				miss_addition = 0.8
			},
			antisub_attack = {
				power_addition = 1,
				hit_addition = 1,
				miss_addition = 0.8
			},
			aircraft_attack = {
				power_addition = 1,
				hit_addition = 1,
				miss_addition = 0.8
			},
			night_attack = {
				power_addition = 1,
				hit_addition = 1.2,
				miss_addition = 1
			}
		},
		single_cross = {
			double_air_def_correct = 1,
			value = 5,
			crited_rate = -0.1,
			crit_rate = 0,
			normal_attack = {
				power_addition = 0.8,
				hit_addition = 0.75,
				miss_addition = 1.3
			},
			missile_attack = {
				power_addition = 0.8,
				hit_addition = 0.75,
				miss_addition = 1.3
			},
			torpedo_attack = {
				power_addition = 0.8,
				hit_addition = 0.5,
				miss_addition = 1.3
			},
			antisub_attack = {
				power_addition = 1,
				hit_addition = 1,
				miss_addition = 0.9
			},
			aircraft_attack = {
				power_addition = 1,
				hit_addition = 1,
				miss_addition = 0.9
			},
			night_attack = {
				power_addition = 1,
				hit_addition = 1,
				miss_addition = 1.2
			}
		}
	},
	equip_carry_type = {
		plane = 2,
		missile = 3,
		normal = 1
	},
	range_type = {
		very_long = 4,
		short = 1,
		long = 3,
		middle = 2,
		none = 0
	},
	ship_type = {},
	ship_type_rule = {
		aircraft_carrier = {
			normal_attack = true,
			night_attack = false,
			aircraft_attack = true,
			normal2_antisub_attack = false,
			value = 1,
			torpedo_attack = false,
			normal_aircraft_attack = true,
			open_missile_attack = false,
			antisub_attack = false,
			close_missile_attack = false,
			night_antisub_attack = false,
			normal_antisub_attack = false,
			is_guard = false,
			open_torpedo_attack = false,
			guard_type = 1,
			speed = {
				value = 10,
				type = "class1"
			}
		},
		light_aircraft_carrier = {
			normal_attack = true,
			night_attack = false,
			antisub_attack = true,
			normal2_antisub_attack = true,
			value = 2,
			guard_type = 2,
			aircraft_attack = true,
			normal_antisub_attack = true,
			is_guard = true,
			normal_aircraft_attack = true,
			speed = {
				value = 10,
				type = "class1"
			}
		},
		seaplane_tender = {
			normal_attack = true,
			aircraft_attack = true,
			night_attack = false,
			guard_type = 1,
			value = 3,
			normal_aircraft_attack = true,
			speed = {
				value = 10,
				type = "class1"
			}
		},
		battle_ship = {
			night_attack = true,
			normal_attack = true,
			guard_type = 1,
			value = 4,
			speed = {
				value = 10,
				type = "class1"
			}
		},
		aviation_battle_ship = {
			normal_attack = true,
			night_attack = true,
			aircraft_attack = true,
			normal2_antisub_attack = true,
			value = 5,
			normal_antisub_attack = false,
			guard_type = 1,
			speed = {
				value = 10,
				type = "class1"
			}
		},
		battle_cruiser = {
			night_attack = true,
			normal_attack = true,
			guard_type = 1,
			value = 6,
			speed = {
				value = 10,
				type = "class1"
			}
		},
		heavy_cruiser = {
			normal_attack = true,
			night_attack = true,
			is_guard = true,
			guard_type = 2,
			value = 7,
			torpedo_attack = true,
			speed = {
				value = 10,
				type = "class2"
			}
		},
		aviation_cruiser = {
			normal_attack = true,
			night_attack = true,
			aircraft_attack = true,
			normal2_antisub_attack = true,
			value = 8,
			torpedo_attack = true,
			guard_type = 2,
			antisub_attack = true,
			night_antisub_attack = true,
			normal_antisub_attack = true,
			is_guard = true,
			speed = {
				value = 10,
				type = "class2"
			}
		},
		torpedo_cruiser = {
			normal_attack = true,
			night_attack = true,
			guard_type = 2,
			normal2_antisub_attack = true,
			value = 9,
			torpedo_attack = true,
			night_antisub_attack = true,
			normal_antisub_attack = true,
			is_guard = true,
			open_torpedo_attack = true,
			speed = {
				value = 10,
				type = "class2"
			}
		},
		light_cruiser = {
			normal_attack = true,
			night_attack = true,
			guard_type = 2,
			normal2_antisub_attack = true,
			value = 10,
			torpedo_attack = true,
			antisub_attack = true,
			night_antisub_attack = true,
			normal_antisub_attack = true,
			is_guard = true,
			speed = {
				value = 10,
				type = "class2"
			}
		},
		monitor = {
			normal_attack = true,
			night_attack = true,
			guard_type = 2,
			value = 11,
			is_guard = true,
			speed = {
				value = 10,
				type = "class2"
			}
		},
		destroyer = {
			normal_attack = true,
			night_attack = true,
			guard_type = 2,
			normal2_antisub_attack = true,
			value = 12,
			torpedo_attack = true,
			antisub_attack = true,
			night_antisub_attack = true,
			normal_antisub_attack = true,
			is_guard = true,
			speed = {
				value = 10,
				type = "class2"
			}
		},
		submarine_strategic_carrier = {
			normal_attack = false,
			night_attack = true,
			is_guard = false,
			guard_type = 1,
			value = 13,
			torpedo_attack = true,
			open_torpedo_attack = true,
			speed = {
				value = 10,
				type = "class3"
			}
		},
		submarine = {
			normal_attack = false,
			night_attack = true,
			is_guard = true,
			guard_type = 2,
			value = 14,
			torpedo_attack = true,
			open_torpedo_attack = true,
			speed = {
				value = 10,
				type = "class3"
			}
		},
		heavy_bomb_submarine = {
			normal_attack = true,
			night_attack = true,
			is_guard = true,
			guard_type = 2,
			value = 15,
			torpedo_attack = true,
			speed = {
				value = 10,
				type = "class3"
			}
		},
		support = {
			normal_attack = true,
			night_attack = true,
			guard_type = 2,
			value = 16,
			is_guard = true,
			speed = {
				value = 10,
				type = "class2"
			}
		},
		fortress = {
			normal_attack = true,
			night_attack = true,
			aircraft_attack = true,
			guard_type = 1,
			value = 17,
			speed = {
				value = 10,
				type = "class1"
			}
		},
		airport = {
			normal_attack = true,
			night_attack = true,
			aircraft_attack = true,
			guard_type = 1,
			value = 18,
			normal_aircraft_attack = true,
			speed = {
				value = 10,
				type = "class1"
			}
		},
		port = {
			normal_attack = true,
			night_attack = true,
			aircraft_attack = true,
			guard_type = 1,
			value = 19,
			speed = {
				value = 10,
				type = "class1"
			}
		},
		merchant_ships = {
			normal_attack = false,
			value = 20,
			guard_type = 2,
			speed = {
				value = 10,
				type = "class2"
			}
		},
		landing_ship = {
			normal_attack = false,
			value = 21,
			guard_type = 2,
			speed = {
				value = 10,
				type = "class1"
			}
		},
		pirates = {
			normal_attack = false,
			value = 22,
			guard_type = 2,
			speed = {
				value = 10,
				type = "class1"
			}
		},
		asdg = {
			normal_attack = true,
			night_attack = true,
			guard_type = 1,
			value = 23,
			open_missile_attack = true,
			speed = {
				value = 10,
				type = "class1"
			}
		},
		aadg = {
			normal_attack = true,
			night_attack = true,
			guard_type = 2,
			normal2_antisub_attack = true,
			value = 24,
			antisub_attack = true,
			night_antisub_attack = false,
			normal_antisub_attack = true,
			close_missile_attack = true,
			speed = {
				value = 10,
				type = "class1"
			}
		},
		hmc = {
			normal_attack = true,
			night_attack = true,
			guard_type = 2,
			normal2_antisub_attack = true,
			value = 25,
			torpedo_attack = true,
			night_antisub_attack = true,
			normal_antisub_attack = true,
			is_guard = true,
			open_torpedo_attack = false,
			speed = {
				value = 10,
				type = "class2"
			}
		},
		cbg = {
			normal_attack = true,
			night_attack = true,
			guard_type = 1,
			value = 26,
			close_missile_attack = true,
			speed = {
				value = 10,
				type = "class1"
			}
		},
		bbg = {
			normal_attack = true,
			night_attack = true,
			guard_type = 1,
			value = 27,
			open_missile_attack = true,
			speed = {
				value = 10,
				type = "class1"
			}
		},
		aviation_cruiser_can_air = {
			normal_attack = true,
			night_attack = true,
			aircraft_attack = true,
			normal2_antisub_attack = true,
			value = 28,
			torpedo_attack = true,
			guard_type = 2,
			antisub_attack = true,
			night_antisub_attack = true,
			normal_antisub_attack = true,
			is_guard = true,
			speed = {
				value = 10,
				type = "class2"
			}
		},
		cg = {
			normal_attack = true,
			night_attack = true,
			guard_type = 1,
			value = 29,
			close_missile_attack = true,
			speed = {
				value = 10,
				type = "class1"
			}
		},
		kp = {
			normal_attack = true,
			night_attack = true,
			guard_type = 1,
			value = 30,
			open_missile_attack = true,
			speed = {
				value = 10,
				type = "class1"
			}
		},
		bg = {
			normal_attack = true,
			night_attack = true,
			guard_type = 1,
			value = 31,
			close_missile_attack = true,
			speed = {
				value = 10,
				type = "class1"
			}
		},
		na = {
			aircraft_attack = true,
			normal_attack = false,
			guard_type = 2,
			value = 98,
			speed = {
				value = 10,
				type = "class1"
			}
		},
		flag_ship = {
			normal_attack = true,
			aircraft_attack = true,
			night_attack = true,
			guard_type = 1,
			value = 99,
			torpedo_attack = true,
			speed = {
				value = 10,
				type = "class1"
			}
		},
		Coordination_ship = {
			normal_attack = true,
			night_attack = true,
			aircraft_attack = true,
			normal2_antisub_attack = true,
			value = 97,
			torpedo_attack = true,
			close_missile_attack = true,
			open_missile_attack = true,
			antisub_attack = true,
			normal_or_aircraft_by_have_aircraft = true,
			night_antisub_attack = true,
			normal_antisub_attack = true,
			guard_type = 1,
			open_torpedo_attack = true,
			speed = {
				value = 10,
				type = "class1"
			}
		}
	},
	player_pos = {
		{
			z = -0.86,
			x = -5.65,
			y = -3.5
		},
		{
			z = 0,
			x = -7.94,
			y = -2.79
		},
		{
			z = 0.8,
			x = -5.66,
			y = -1.28
		},
		{
			z = 1.11,
			x = -8.05,
			y = -0.25
		},
		{
			z = 2.49,
			x = -4.69,
			y = 0.76
		},
		{
			z = 2.63,
			x = -6.9,
			y = 1.35
		}
	},
	submarine_position = {
		player = {
			{
				z = -0.145,
				x = -5.37,
				y = 10.51
			},
			{
				z = 0.96,
				x = -9.14,
				y = 11.75
			},
			{
				z = 1.55,
				x = -5.92,
				y = 14.08
			},
			{
				z = 1.69,
				x = -9.35,
				y = 15.35
			},
			{
				z = 1.89,
				x = -4.36,
				y = 17.14
			},
			{
				z = 1.8,
				x = -7.52,
				y = 17.55
			}
		},
		enemy = {
			{
				z = -0.145,
				x = 5.37,
				y = 10.51
			},
			{
				z = 0.96,
				x = 9.14,
				y = 11.75
			},
			{
				z = 1.55,
				x = 5.92,
				y = 14.08
			},
			{
				z = 1.69,
				x = 9.35,
				y = 15.35
			},
			{
				z = 1.89,
				x = 4.36,
				y = 17.14
			},
			{
				z = 1.8,
				x = 7.52,
				y = 17.55
			}
		}
	},
	enemy_pos = {
		{
			z = -0.86,
			x = 5.65,
			y = -3.5
		},
		{
			z = 0,
			x = 7.94,
			y = -2.79
		},
		{
			z = 0.8,
			x = 5.66,
			y = -1.28
		},
		{
			z = 1.11,
			x = 8.05,
			y = -0.25
		},
		{
			z = 2.49,
			x = 4.69,
			y = 0.76
		},
		{
			z = 2.63,
			x = 6.9,
			y = 1.35
		}
	},
	damage_type = {
		kill = 4,
		normal = 1,
		crit = 3,
		miss = 2,
		recover = 0
	},
	hp_ratio_type = {
		medhp = 0.5,
		lowhp = 0.25
	},
	crit_multiplier = {
		value = function(arg_2_0)
			if arg_2_0 then
				return 1.5
			else
				return 1
			end
		end
	},
	ammunition_addition = {
		0,
		0.2,
		0.4,
		0.6,
		0.8,
		1,
		1,
		1,
		1,
		1,
		1
	},
	plane_attack_type = {
		throw_bomb = 2,
		throw_torpedo = 3,
		throw_depthcharge = 4,
		none = 1
	},
	night_attack_type = {
		normal = 1,
		missile = 4,
		torpedo = 2,
		mix = 3,
		none = 0
	},
	normal_attack_type = {
		aircraft = 2,
		torpedo = 3,
		normal = 1
	},
	attack_round = {
		default = 0,
		normal = 2,
		aircraft_torpedo = 5,
		torpedo = 3,
		antisub = 6,
		missile = 4,
		aircraft = 1
	},
	attack_round_type = {
		normal = 5,
		torpedo = 6,
		antisub = 2,
		night = 4,
		missile = 3,
		aircraft = 1
	},
	day_or_night = {
		night = 2,
		day = 1
	},
	cookbuff_type = {
		exp = 1,
		night_attack_damage = 3,
		normal_attack_damage = 2,
		torpedo_attack_damage = 4,
		attr_by_ship = 5,
		attr_by_fleet = 6
	},
	cookbuff_damage_attr = {
		normal_attack = 2,
		night_attack = 3,
		torpedo_attack = 4
	},
	country_type = {
		soviet = 7,
		france = 6,
		italy = 5,
		germany = 2,
		japan = 1,
		british = 3,
		all = 0,
		china = 8,
		genera = 99,
		america = 4
	},
	buff_type = {
		down = 2,
		up = 1,
		none = 0
	},
	course_type_rule = {
		same = {
			value = 1,
			power_effect = 1,
			opposite = 1
		},
		reversal = {
			value = 2,
			power_effect = 0.8,
			opposite = 2
		},
		t_advantage = {
			value = 3,
			power_effect = 1.15,
			opposite = 4
		},
		t_disadvantage = {
			value = 4,
			power_effect = 0.65,
			opposite = 3
		}
	},
	skill_type = {
		passive = 1,
		buff = 2
	},
	trigger_type = {
		normal_attack = 5,
		air_attack = 2,
		close_torpedo_attack = 6,
		buff = 100,
		expedition = 13,
		close_missile_attack = 15,
		passive = 1,
		exercise = 14,
		support = 101,
		open_torpedo_attack = 4,
		night_war = 7,
		first_normal_attack = 9,
		battle_after = 11,
		all_step = 0,
		open_missile_attack = 8,
		open_antisub_attack = 3,
		second_normal_attack = 10,
		day_war = 12
	},
	condition_type = {
		take_attack = {
			value = 1
		},
		take_damage = {
			value = 2
		},
		more_than_hp_damage = {
			value = 3,
			must = {
				"num"
			}
		},
		after_take_attack = {
			value = 4
		},
		take_attack_not_less_than_some_attribute = {
			value = 5,
			must = {
				"attribute"
			}
		},
		attack = {
			value = 6
		},
		after_attack = {
			value = 7
		},
		attack_crit = {
			value = 8
		},
		attack_not_crit = {
			value = 9
		},
		attack_not_more_than_some_attribute = {
			value = 10,
			must = {
				"attribute"
			}
		},
		attack_more_than_some_attribute = {
			value = 11
		},
		attack_some_ship = {
			value = 12,
			may = {
				"ship_types",
				"ship_tons"
			}
		},
		attack_some_attribute_more_then_num = {
			value = 13,
			must = {
				"attribute",
				"num"
			}
		},
		attack_some_attribute_less_then_num = {
			value = 14,
			must = {
				"attribute",
				"num"
			}
		},
		attack_not_full_hp = {
			value = 15
		},
		attack_opposite_same_pos = {
			value = 16
		},
		attack_flag = {
			value = 17
		},
		attack_not_flag = {
			value = 18
		},
		open_torpedo = {
			value = 19
		},
		no_harm = {
			value = 20
		},
		middle_break = {
			value = 21
		},
		not_big_break = {
			value = 22
		},
		not_middle_break = {
			value = 23
		},
		not_middle_big_break = {
			value = 24
		},
		hp_more_then_nun = {
			value = 25,
			must = {
				"num"
			}
		},
		flag = {
			value = 26
		},
		not_flag = {
			value = 27
		},
		some_ship_type_is_flag = {
			value = 28,
			must = {
				"shipTypes"
			}
		},
		some_ship_type_is_not_flag = {
			value = 29,
			must = {
				"shipTypes"
			}
		},
		chapter_six_of_the_war = {
			value = 30
		},
		t_advantage = {
			value = 31
		},
		reversal_aviation_battle_ship = {
			value = 32
		},
		same_aviation_battle_ship = {
			value = 33
		},
		t_disadvantage = {
			value = 34
		},
		radar_success_and_falg = {
			value = 35
		},
		rate_trigger = {
			value = 36
		},
		ship_count_nlt_num = {
			value = 37,
			must = {
				"num"
			}
		},
		ship_type_nlt_num_in_config = {
			value = 38,
			must = {
				"shipTypes",
				"num"
			}
		},
		ship_type_lt_num_in_config = {
			value = 39,
			must = {
				"shipTypes",
				"num"
			}
		},
		ship_count_nlt_num_in_config = {
			value = 40,
			must = {
				"shipCids",
				"num"
			}
		},
		ship_type_nmt_enemy = {
			value = 41,
			must = {
				"shipTypes"
			}
		},
		ship_type_more_than_enemy = {
			value = 42,
			must = {
				"shipTypes"
			}
		},
		no_ship_type_in_config_without_self = {
			value = 43,
			must = {
				"shipTypes"
			}
		},
		nlt_num2_ship_count_of_some_attribute_nlt_num = {
			value = 44,
			must = {
				"attribute",
				"num",
				"num2"
			}
		},
		more_effect_more_death = {
			value = 45
		},
		more_effect_more_count_in_config = {
			value = 46,
			must = {
				"cardCids"
			}
		},
		some_type_ship_count_mul_effect_in_config = {
			value = 47,
			may = {
				"shipTypes",
				"shipTons",
				"guardTypes",
				"shipCids"
			}
		},
		some_country_ship_count_mul_effect_in_config = {
			value = 48,
			must = {
				"country"
			},
			may = {
				"shipTypes",
				"shipTons",
				"guardTypes"
			}
		},
		not_some_country_ship_count_mul_effect = {
			value = 49,
			must = {
				"country"
			}
		},
		some_speed_nlt_num_ship_count_mul_effect_in_config = {
			value = 50,
			must = {
				"ship_types",
				"num"
			}
		},
		some_attribute_nlt_num_nul_effect = {
			value = 51,
			must = {
				"attribute",
				"num"
			}
		},
		some_attribute_sum_of_other_ships_div_num_mul_effect = {
			value = 52,
			must = {
				"attribute",
				"num"
			}
		},
		some_attribute_sum_of_ships_div_num_mul_effect = {
			value = 53,
			must = {
				"attribute",
				"num"
			}
		},
		distance_of_combat_to_start_mul_effect = {
			value = 54
		},
		distance_of_combat_to_end_mul_effect = {
			value = 55
		},
		severity_of_injury_nul_effect = {
			value = 56
		},
		speed_div_num_mul_effect = {
			value = 57,
			must = {
				"num"
			}
		},
		some_type_ship_count_mul_effect_in_config_when_U_submarine_flag = {
			value = 58,
			must = {
				"ship_types"
			}
		},
		ships_count_of_map_mul_effect = {
			value = 59
		},
		gofight_count_div_num_mul_effect = {
			value = 60,
			must = {
				"num"
			}
		},
		add_attribute_by_enemy_loss_hp_percent = {
			value = 61,
			must = {
				"num"
			}
		},
		self_loss_hp_div_num_mul_effect = {
			value = 62,
			must = {
				"num"
			}
		},
		take_attack_count_nul_effect = {
			value = 63
		},
		hit_count_mul_effect = {
			value = 64
		},
		level_div_num_mul_effect = {
			value = 65,
			must = {
				"num"
			}
		},
		torpedo_plane_count_more_than_bomber = {
			value = 66
		},
		bomber_count_more_than_torpedo_plane = {
			value = 67
		},
		our_single = {
			value = 68
		},
		our_trapezoidal = {
			value = 69
		},
		have_some_ship_of_enemy = {
			value = 70,
			must = {
				"ship_types",
				"num"
			}
		},
		some_average_attribute_of_enemy_lt_self = {
			value = 71,
			must = {
				"attribute"
			}
		},
		some_average_attribute_of_enemy_mt_self = {
			value = 72,
			must = {
				"attribute"
			}
		},
		after_loss_hp_percent = {
			value = 73,
			must = {
				"num"
			}
		},
		air_control_type_equi = {
			value = 74
		},
		air_control_type_advantage = {
			value = 75
		},
		air_control_type_supremancy = {
			value = 76
		},
		hp_less_than_num_by_percent = {
			value = 77
		},
		shiptype_by_num = {
			value = 78
		},
		greater_than_average_attr = {
			value = 79
		},
		less_than_average_attr = {
			value = 80
		},
		less_than_num_by_cid = {
			value = 81
		},
		greater_than_num_and_greater_than_attr = {
			value = 82
		},
		greater_than_num_and_less_than_attr = {
			value = 83
		},
		greater_than_num_and_equal_to_attr = {
			value = 84
		},
		our_double = {
			value = 85
		},
		have_not_ship_by_cid = {
			value = 86,
			must = {
				"shipCids"
			}
		},
		is_flag_by_cid = {
			value = 87,
			must = {
				"shipCids"
			}
		},
		self_flag_opposite_no_flag = {
			value = 88
		},
		except_self_ship_count_mul_effect_in_config = {
			value = 89,
			may = {
				"shipTypes",
				"shipTons",
				"guardTypes"
			}
		},
		t_disadvantage_self_flag = {
			value = 90
		},
		hight_speed_ship_by_shiptype_by_num = {
			value = 91
		},
		ememy_num_greater_than_num = {
			value = 92
		},
		ememy_num_less_than_num = {
			value = 93
		},
		num_by_ship_type = {
			value = 94
		},
		num_by_flag_ship = {
			value = 95
		},
		opposite_no_flag = {
			value = 96
		},
		opposite_has_alive_submarine = {
			value = 97
		},
		radar_success = {
			value = 98
		},
		country_shipnum_greater_or_equal = {
			value = 99
		},
		country_shipnum_less = {
			value = 100,
			must = {
				"country"
			}
		},
		no_ship_type_in_config_country_without_self = {
			value = 101,
			must = {
				"country"
			}
		},
		no_ship_type_in_config_shipCids_without_self = {
			value = 102,
			must = {
				"shipCids"
			}
		},
		country_shipTypes_greater_or_equal = {
			value = 103
		},
		country_shipTypes_less = {
			value = 104
		},
		more_effect_more_country_count_in_config = {
			value = 105
		},
		some_ship_country_is_flag = {
			value = 106
		},
		self_loss_hp_div_num_mul_effect_no_max = {
			value = 107,
			must = {
				"num"
			}
		},
		only_country_in_config = {
			value = 108,
			must = {
				"country"
			}
		},
		skill_type_nlt_num_in_config = {
			value = 109,
			must = {
				"skillTypes",
				"num"
			}
		}
	},
	action_type = {
		change_damage_by_attr_by_num = 126,
		change_atk_by_radom_by_attr = 124,
		couple_attack_by_shipcid = 183,
		set_hit_num_in_normal_atk = 115,
		ridicule_by_ship_type = 8,
		num_of_beat_back_with_fix_damage = 148,
		action_44 = 44,
		self_change_attr_by_shiptype_by_stage_by_percent = 133,
		action_30 = 30,
		add_attr_with_attr = 73,
		add_attr_by_target_alive = 152,
		add_attr_by_special_ship = 102,
		change_damage_by_special_ship = 92,
		change_damage_less_than_num = 88,
		action_39 = 39,
		action_41 = 41,
		equip_attribute_add_attr = 50,
		change_damage_greater_than_num = 87,
		can_not_hit_or_be_hit = 114,
		action_25 = 25,
		is_hit_unit_never_attack = 64,
		can_not_crit = 77,
		modify_other_attribute_percent = 5,
		action_34 = 34,
		carry_equip_toghter_other_attribute = 54,
		action_36 = 36,
		change_plane_damage_by_level = 130,
		air_disadvantage_set_aircraft_damage = 60,
		action_48 = 48,
		attack_cause_damage = 68,
		change_air_control = 96,
		dec_hit_by_type = 19,
		hit_complex_target = 16,
		self_change_attr_by_shiptype_by_stage_by_attack = 135,
		ship_attack_type_ignore_damaged = 168,
		no_crit = 1,
		change_drop_air_def_by_shiptype = 165,
		action_24 = 24,
		target_change_attr_by_shiptype_by_stage = 127,
		damage_recover_life = 62,
		sure_to_crit = 10,
		lock_hp_by_num = 107,
		action_45 = 45,
		ship_henshin_skill = 166,
		action_47 = 47,
		action_32 = 32,
		change_attr_by_atk_type_by_percent = 74,
		team_average_speed_small_owner_speed = 58,
		action_33 = 33,
		hit_by_fixed_demage_attr_by_percent = 121,
		first_hit_by_type_by_num = 136,
		carry_equip_toghter_other_equip = 53,
		add_damage_by_now_hp_greater_than_num = 139,
		add_attr_by_num_bu_lost_hp = 156,
		team_average_speed_large_owner_speed = 57,
		change_final_be_damage_can_overly = 145,
		set_atk_by_attr = 111,
		change_attr_by_hp = 147,
		hit_by_fixed_demage_by_ship_type = 120,
		back_hit_to_random_target_by_attr = 113,
		first_hit_by_type = 22,
		action_37 = 37,
		phase_no_damage_by_phase_attack = 149,
		action_38 = 38,
		double_hit_by_crit = 150,
		team_average_speed_equal_owner_speed = 59,
		change_plane_damage = 103,
		self_change_attr_by_shiptype_by_stage = 134,
		one_more_attack_and_not_shout_by_stage = 155,
		ship_can_no_antisub_submarine = 169,
		add_fix_damage_by_index = 153,
		ignore_rate_by_armor_in_crit = 101,
		copy_target_skill = 162,
		after_lost_hp_by_percent_immune_by_num = 157,
		immune_num_of_speed_and_shipTons_atk = 159,
		fire_support_by_speed = 131,
		action_29 = 29,
		probability_triggering = 99,
		can_not_shout_and_shout_with_teammate = 140,
		add_attr_without_equip = 158,
		sure_to_hit = 9,
		change_crit_hurt_by_ship_type = 119,
		action_28 = 28,
		equip_carry_attribute_add_attr = 51,
		ignore_rate_by_armor_in_is_flag = 89,
		hit_target_hp_to_broke = 112,
		ship_henshin_cutin_skill = 167,
		change_damage_by_is_flag_with_num = 84,
		action_27 = 27,
		dec_target_attribute = 14,
		sure_to_hit_by_index = 154,
		first_hit_min_attr = 174,
		ship_antisub_ignore_broken_hp = 176,
		set_atk_by_percent = 118,
		action_26 = 26,
		change_atked_weight = 90,
		sure_to_hit_by_shiptype = 177,
		change_crit_hurt_by_hp = 146,
		change_final_be_damage_by_be_hit = 178,
		change_be_crit_rate = 85,
		action_43 = 43,
		can_not_effect_by_course = 137,
		can_attack_in_broken = 180,
		immune_damage_by_buff = 181,
		up_crit_hurt = 71,
		buff_couple_cutin = 182,
		skill_attack_stage_wihtout_bullet = 173,
		action_42 = 42,
		add_attr_by_special_ship_by_percent = 75,
		change_be_crit_rate_by_be_hit = 122,
		make_other_demage_by_special_ship_by_num = 95,
		modify_attribute = 3,
		can_not_hit_in_this_stage_by_not_flag = 117,
		modify_attribute_percent = 4,
		armor_penetration = 63,
		hited_effect = 100,
		target_change_attr_by_shiptype_by_stage_by_percent = 128,
		equip_carry_type_attribute_add_attr = 52,
		change_attr_by_be_atk_type = 97,
		ignore_middile_break = 132,
		action_23 = 23,
		add_damage_by_now_hp_less_than_num = 138,
		ignore_battle_damage_in_crit = 78,
		hit_by_other_demage = 12,
		dec_target_attribute_percent = 15,
		add_attr_contrast_target_by_percent = 72,
		change_final_be_damage = 91,
		creat_shield_in_hurt = 86,
		change_attr_by_radom_by_attr = 125,
		can_not_shout_in_crit_by_stage = 142,
		replace_target_damage = 2,
		hit_adjacent_complex_target = 17,
		reduce_loss_by_fight = 55,
		modify_by_loss_hp_to_attribute_percent = 7,
		change_be_damage_by_num = 104,
		modify_attribute_to_zero = 6,
		change_damage_by_index = 82,
		damage_of_float = 56,
		change_damage_greater_than_num_by_num = 105,
		double_hit = 18,
		add_damage_with_lose_hp = 161,
		change_damage_less_than_attr = 81,
		can_not_hit_in_this_stage_by_be_hit = 116,
		carry_equip_add_attr = 49,
		change_damage_by_is_flag_with_percnet = 106,
		change_final_damage = 70,
		hit_by_hp_percent = 11,
		make_other_demage_by_num = 93,
		action_40 = 40,
		action_31 = 31,
		num_of_beat_back_wihtout_hp_state = 143,
		can_night_attack = 179,
		immune_damage = 67,
		ignore_rate_by_armor_in_special_ship = 79,
		change_atked_weight_can_overly = 144,
		change_attr_by_atk_type = 76,
		sure_to_crit_by_num = 108,
		couple_by_shipcid = 151,
		show_special_cutin_and_animation = 110,
		change_damage_by_hp_not_full = 83,
		target_change_attr_by_shiptype_by_percent_in_now_hit = 129,
		change_range = 94,
		change_crit_hurt_greater_than_attr = 80,
		air_disadvantage_set_aircraft_add_damage = 61,
		hit_by_fixed_demage = 13,
		owner_attribute_change_buff_target_attr = 65,
		damage_of_beat_back = 69,
		cancel_reversal_course = 184,
		set_immune_in_atk_by_shiptype = 163,
		can_not_shout_by_stage_before_shout = 98,
		add_target_crit_in_be_atk_by_shiptype = 164
	},
	syncytium_skill_rate = {
		0.6,
		0.7,
		0.8
	},
	target_type = {
		after_some_pos = 14,
		before_by_ship_type_by_num = 3,
		some_type_by_country = 12,
		some_ship = 9,
		all_this_side_without_self = 19,
		adjacent_upsea_ships = 18,
		self = 7,
		all_this_side__by_ship_type_by_num = 20,
		high_speed_ship_but_self = 24,
		opposite_ship_by_flag = 56,
		random_opposite_some_ships_repeat = 57,
		some_pos_ships = 25,
		opposite_same_pos_upsea = 52,
		all_opposite_side = 50,
		opposite_some_ships_except_flag = 55,
		flag_ship = 17,
		low_speed_ship_but_self = 23,
		adjacent_ship = 2,
		opposite_speed_ship = 53,
		before_some_pos = 4,
		some_type = 11,
		all_type_but_target_type = 22,
		some_shiptype_except_self = 16,
		random_opposite_some_ships = 54,
		not_higher_27_speed_ship = 58,
		some_country = 10,
		some_speed_ship = 15,
		all_this_side = 8,
		opposite_some_ships = 51,
		speed_greater_than_27 = 21,
		after_all = 5,
		adjacent_pos = 1,
		before_all = 6,
		after_by_ship_type_by_num = 13
	},
	tactics_type = {
		torpedo_learning = {
			value = 10000174,
			func_name = "on_torpedo_damage_aircraftcarrier"
		},
		block_fire = {
			value = 10000374,
			func_name = "on_artillery_battle_enemy_destroyer"
		},
		sea_sentry = {
			value = 10000474,
			func_name = "on_torpedo_support_enemy_destroyer"
		},
		wear = {
			value = 10000674,
			func_name = "on_artillery_support_enemy_battle_ship"
		},
		wide_angle_avoidance = {
			value = 10000774,
			func_name = "on_artillery_immune_one_attack"
		},
		shoot = {
			value = 10000974,
			func_name = "on_artillery_enemy_battle_ship"
		},
		bounce_attack = {
			value = 10001174,
			func_name = "on_aircraft_enemy_destroyer"
		},
		hardened_armor = {
			value = 10001274,
			func_name = "on_artillery_support_enemy_battle_cruiser"
		},
		aa_barrage = {
			value = 10001474,
			func_name = "on_aircraft_support_enemy_aircraft_carrier"
		},
		interactive_shooting = {
			value = 10001574,
			func_name = "on_artillery_beat_back"
		},
		turret_backup = {
			value = 10001774,
			func_name = "on_supply_owner"
		},
		aerial_bombs = {
			value = 10001874,
			func_name = "on_aircraft_owner_enemy_battle_ship"
		},
		armour_grenade = {
			value = 10002074,
			func_name = "on_artillery_owner_enemy_battle_cruiser"
		},
		searchlight_alert = {
			value = 10002174,
			func_name = "on_night_support_enemy_heavy_cruiser"
		},
		armored_deck = {
			value = 10002374,
			func_name = "on_aircraft_support_enemy_light_carrier"
		},
		air_warning = {
			value = 10002674,
			func_name = "on_aircraft_owner_immune_one_attack"
		}
	},
	tactics_special_type = {
		normal_learning = {
			value = 10000274,
			func_name = "on_team_have_battle_cruiser"
		},
		outpost_strikers = {
			value = 10000574,
			func_name = "on_team_have_heavy_tour"
		},
		data_interaction = {
			value = 10001074,
			func_name = "on_team_have_battle_ship"
		},
		formation_strikers = {
			value = 10001374,
			func_name = "on_team_have_battle_cruiser"
		},
		hard_by_cap = {
			value = 10001674,
			func_name = "on_team_have_battle_ship"
		},
		full_deck_assault = {
			value = 10001974,
			func_name = "on_team_have_aircraft_carrier"
		},
		escort_strikers = {
			value = 10002274,
			func_name = "on_team_have_battle_ship"
		},
		improved_cap_shot = {
			value = 10002474,
			func_name = "on_team_have_battle_cruiser"
		},
		flare_correction = {
			value = 10002574,
			func_name = "on_owner_to_battle"
		},
		echelon_torpedo = {
			value = 10000874,
			func_name = "on_close_torpedo_more_launch"
		}
	},
	tactics_const = {
		rate_max = 100
	},
	enemy_type = {
		robot = 2,
		monster = 1,
		player = 3
	},
	reduce_injury_type = {
		antisubmarine_rate = 2,
		aircraft_bomber_rate = 2,
		night_antisub_rate = 0.2,
		night_mix_attack_rate = 0.8,
		lac_damage_rate = 10,
		torpedo_rate = 1,
		aircraft_normal_rate = 1,
		normal_battle_rate = 0.6,
		normal_battle_aircraft_rate = 1
	},
	sixth_buff_type = {
		increase_some_fleet_ship_attrs = 2,
		increase_some_ship_attrs = 4,
		increase_attack_ship_power = 9,
		increase_some_country_ship_attrs = 3,
		reduce_some_stage_power = 8,
		increase_all_ship_attrs = 1,
		reduce_attack_my_ship_power = 10,
		increase_ship_power = 11,
		increase_this_side_ship_power = 5,
		increase_some_stage_power = 7,
		reduce_this_ship_damage = 6,
		reduce_ship_damage = 12
	},
	seventh_buff_type = {
		increase_some_fleet_ship_attrs = 2,
		increase_some_ship_attrs = 4,
		increase_attack_ship_power = 9,
		increase_some_country_ship_attrs = 3,
		reduce_some_stage_power = 8,
		increase_all_ship_attrs = 1,
		reduce_attack_my_ship_power = 10,
		increase_ship_power = 11,
		increase_this_side_ship_power = 5,
		increase_some_stage_power = 7,
		reduce_this_ship_damage = 6,
		reduce_ship_damage = 12
	},
	eighth_buff_type = {
		increase_some_fleet_ship_attrs = 2,
		increase_all_ship_attrs = 1,
		increase_some_ship_attrs = 4,
		reduce_this_ship_damage = 6,
		increase_some_country_ship_attrs = 3,
		enemy_ship_stage_hit_enhance = 105,
		enemy_ship_range_enhance = 102,
		enemy_ship_night_fight = 107,
		increase_this_side_ship_power = 5,
		enemy_ship_stage_hit_reduce = 106,
		increase_ship_power = 11,
		enemy_ship_broken_fight = 108,
		every_enemy_ship_add_attr = 111,
		reduce_ship_damage = 12,
		reduce_attack_my_ship_power = 10,
		enemy_flag_ship_add_attr = 112,
		increase_attack_ship_power = 9,
		reduce_some_stage_power = 8,
		enemy_ship_attr_enhance = 101,
		enemy_ship_must_hit = 110,
		enemy_ship_open_torpedo = 109,
		increase_some_stage_power = 7,
		enemy_ship_hit_enhance = 103,
		enemy_ship_hit_reduce = 104
	},
	adjutant_buff_type = {
		enhance_damage = 2,
		get_ship = 3,
		strategy_point = 1
	},
	increase_power_attr = {
		nil,
		"aircraft_attack",
		"antisub_attack",
		"open_torpedo_power",
		"normal_attack",
		"torpedo_attack",
		"night_attack",
		"open_missile_power"
	},
	decrease_power_attr = {
		nil,
		"decrease_aircraft_injured",
		"decrease_antisub_injured",
		"decrease_open_torpedo_injured",
		"decrease_normal_injured",
		"decrease_close_torpedo_injured",
		"decrease_night_injured",
		"decrease_open_missile_injured"
	},
	sixth_buffs_once_type = {
		team_by_ship_attr_enhance = 4,
		team_by_ship_type_rate_attr_enhance = 5,
		team_by_ship_type_attr_enhance = 2,
		team_by_country_attr_enhance = 3,
		team_by_ship_type_rate_attr_reduce = 6,
		all_team_attr_enhance = 1
	},
	sixth_buffs_twice_type = {
		team_by_stage_rate_attr_enhance = 7,
		owner_ship_rate_attr_enhance = 11,
		owner_ship_rate_attr_reduce = 12,
		team_by_enemy_rate_attr_reduce = 10,
		team_by_enemy_rate_attr_enhance = 9,
		team_by_stage_rate_attr_reduce = 8
	},
	main_fight_buff_type = {
		team_by_country_attr_enhance = 19,
		enemy_ship_broken_fight = 108,
		enemy_ship_stage_hit_enhance = 105,
		every_enemy_ship_add_attr = 111,
		team_by_ship_type_attr_reduce = 10,
		enemy_ship_range_enhance = 102,
		team_by_country_attr_reduce = 20,
		enemy_ship_stage_hit_reduce = 106,
		team_by_ship_type_attr_enhance = 9,
		all_team_attr_reduce = 8,
		enemy_flag_ship_add_attr = 112,
		enemy_ship_attr_enhance = 101,
		all_team_attr_enhance = 7,
		enemy_ship_must_hit = 110,
		enemy_ship_open_torpedo = 109,
		enemy_ship_night_fight = 107,
		enemy_ship_hit_enhance = 103,
		enemy_ship_hit_reduce = 104
	},
	buff_data_orgin_type = {
		normal_type = 1,
		repeat_type = 2
	},
	night_enemy_type_by_buff = {
		aircraft_carrier = 1,
		seaplane_tender = 3,
		light_aircraft_carrier = 2
	},
	broken_enemy_type_by_buff = {
		aircraft_carrier = 1,
		seaplane_tender = 3,
		airport = 18,
		light_aircraft_carrier = 2
	},
	skill_add_attr_type = {
		special_type_ship_target_add_attr = 9,
		special_type_ship_add_attr = 1,
		add_attr_of_attacked_data_1 = 5,
		special_guard_ship_add_attr = 3,
		special_guard_ship_target_add_attr = 11,
		special_tons_ship_add_attr = 2,
		special_tons_ship_target_add_attr = 10,
		add_attr_with_attr = 8,
		add_attr_of_attacked_data_2 = 6,
		add_attr_contrast_target_data = 4,
		add_attr_of_attacked_data_3 = 7
	},
	tower_stone_buffs_type = {
		special_atk_as_zero = 14,
		change_range = 20,
		attack_infallible = 5,
		sure_to_crit_by_ship_type_by_stage = 32,
		aircraft_attr_enhance = 6,
		hit_rate_enhance = 21,
		reduce_damage = 19,
		ship_range_limit = 9,
		our_add_atk = 13,
		back_attack = 35,
		add_attr_by_have_ship_type = 37,
		ship_other_attr_enhance = 24,
		add_extra_damage = 16,
		one_more_attack_in_kill_ship = 34,
		team_hit_rate_reduce = 30,
		priority_attack = 4,
		attend_night_fight = 22,
		hit_reset_zero = 7,
		ship_attr_enhance = 26,
		rate_of_ignore_armor = 15,
		all_ship_attr_enhance = 28,
		first_hit_to_miss = 10,
		change_formation = 17,
		ignore_armor_in_normal_attack = 12,
		hit_rate_reduce = 25,
		all_ship_hit_rate_reduce = 29,
		excute_open_torpedo = 2,
		hit_rate_reduce_by_ship_type = 33,
		back_attack_wihtout_hurt = 36,
		add_attr_by_ship_number = 31,
		attend_fight_by_broken = 23,
		kill_target_immediate = 3,
		enemy_hit_reduce = 27,
		ignore_armor_in_open_torpedo_attack = 18,
		evade_hit = 8,
		any_formation_can_antisub = 11,
		player_user_cost = 1
	},
	abyss_broken_buffs_type = {
		any_formation_can_antisub = 14,
		del_attack_weight_in_flage = 26,
		immune_damage_in_first_hit = 24,
		can_be_hurt_by_range = 25,
		del_damage_by_num = 23,
		del_damage_by_stage = 22,
		seckill_by_not_flage = 17,
		add_attr_by_country = 5,
		all_ship_del_attr = 2,
		can_attack_in_borken = 13,
		can_support_in_boss_point = 27,
		del_damage_by_not_flag = 33,
		can_be_open_torpedo = 8,
		limited_attack_by_flag = 19,
		one_more_attack_in_kill_ship = 10,
		open_airattack_damage_up = 18,
		add_attr_by_ship_type = 3,
		all_ship_add_attr = 1,
		change_range_by_ship_type = 15,
		sure_to_crit_by_ship_type = 9,
		add_attr_by_is_boss = 30,
		del_attr_by_country = 6,
		del_attr_by_ship_type = 4,
		limited_attack_by_not_flag = 20,
		miss_attack_by_ship_type = 21,
		back_attack_wihtout_hurt = 12,
		del_attr_by_is_boss = 31,
		can_be_hurt_by_range_by_is_boss = 28,
		can_night_fight_by_ship_type = 16,
		add_auxiliary_calculus_value = 29,
		add_damage_by_flag = 32,
		back_attack = 11,
		add_attr_by_have_ship_type = 7
	},
	ocean_cia_buffs_type = {
		add_attr_by_country = 202,
		minus_attr_by_country = 102,
		add_attr_for_all_ship = 201,
		add_attr_by_shiptype = 203,
		add_attr_by_flag = 209,
		minus_attr_for_all_ship = 101,
		minus_attr_by_shiptype = 103,
		minus_attr_by_flag = 120
	},
	war_concerto_buffs_type = {
		change_range_by_ship_type = 2,
		minus_be_damage_by_ship_type = 4,
		can_excute_open_torpedo = 9,
		minus_be_damage_by_stage = 6,
		add_attr_by_ship_type = 1,
		can_fight_in_night_by_shiptypes = 7,
		can_fight_in_broke_by_shiptypes = 8,
		add_damage_by_stage = 5,
		add_damage_by_ship_type = 3
	},
	push_map_buffs_type = {
		add_all_ship_attr = 1,
		ignore_damage_by_percent = 3,
		ignore_loss_by_percent = 4,
		add_attr_by_ship_type = 2
	},
	solid_strike_buffs_type = {
		add_attr_by_country = 19,
		minus_attr_by_country = 20,
		minus_attr_for_all_ship = 8,
		can_not_be_effect = 31,
		add_attr_for_all_ship = 7,
		minus_attr_by_shiptype = 10,
		add_attr_by_shiptype = 9
	},
	score_push_buffs_type = {
		score_attr_add_num = 1,
		score_attacked_stage_reduce_damage_percent = 4,
		score_open_torpedo = 8,
		score_attr_add_percent = 2,
		score_attack_stage_wihtout_bullet = 6,
		score_attack_stage_add_damage = 3,
		score_attack_infallible = 7,
		score_attack_stage_wihtout_hurt = 5
	},
	ninth_push_buffs_type = {
		ninth_get_support_attack = 11,
		ninth_attack_stage_wihtout_bullet = 6,
		ninth_get_ships_num_add_attr = 10,
		ninth_attr_add_num = 1,
		ninth_open_torpedo = 8,
		ninth_attack_infallible = 7,
		ninth_attacked_stage_reduce_damage_percent = 4,
		ninth_attack_stage_add_damage = 3,
		ninth_attr_add_percent = 2,
		ninth_open_antisub_attack = 9,
		ninth_attack_stage_wihtout_hurt = 5
	},
	push_buffs_type = {
		push_attack_infallible = 7,
		push_attr_add_percent = 2,
		push_attacked_stage_reduce_damage_percent = 4,
		push_attr_add_num = 1,
		push_attack_stage_wihtout_hurt = 5,
		push_attack_stage_add_damage = 3,
		push_open_torpedo = 8,
		push_attack_stage_wihtout_bullet = 6
	},
	strike_score_buffs_type = {
		strike_score_attacked_stage_reduce_damage_percent = 4,
		strike_score_attr_add_num = 1,
		strike_score_attack_stage_wihtout_bullet = 6,
		strike_score_attack_stage_wihtout_hurt = 5,
		strike_score_attack_infallible = 7,
		strike_score_open_torpedo = 8,
		strike_score_attr_add_percent = 2,
		strike_score_attack_stage_add_damage = 3
	},
	rank_buffs_type = {
		rank_attacked_four = 4,
		rank_attr_two = 2,
		rank_attack_add_damage = 6,
		rank_attr_one = 1,
		rank_attakc_open = 8,
		rank_attack_seven = 7,
		rank_attack_three = 3,
		rank_attack_fire = 5
	},
	equip_entire_buffs_type = {
		equip_entire_buffs_lfgj = 10037221,
		equip_entire_buffs_nfl = 10048021,
		equip_entire_buffs_air_down = 7,
		equip_entire_buffs_tbm = 10034221,
		equip_entire_buffs_adswy = 10050421,
		equip_entire_buffs_fsd = 10043921
	},
	equip_entire_buffs_enemy_type = {
		enemy_equip_entire_buffs_air_down = 7,
		enemy_equip_entire_buffs_lfgj = 10037221,
		enemy_equip_entire_buffs_nfl = 10048021,
		enemy_equip_entire_buffs_fsd = 10043921,
		enemy_equip_entire_buffs_tbm = 10034221,
		enemy_equip_entire_buffs_adswy = 10050421
	},
	exclusive_equip_type = {
		add_hit = 6,
		add_damage = 3,
		add_percent_penetrate = 5,
		add_miss = 7,
		decrease_damage = 4,
		add_air_suppression = 8,
		add_attr_percent = 2,
		add_attr_num = 1,
		add_attack = 9
	},
	exclusive_equip_stage = {
		air = 2,
		antisubmarine = 3,
		all = 0,
		start_missile = 8,
		day_fight = 12,
		night_fire = 7,
		end_missile = 15,
		normal_fire = 5,
		end_torpedo = 6,
		first_fire = 9,
		expedition = 13,
		after_fight = 11,
		manoeuvre = 14,
		start_torpedo = 4,
		second = 10,
		passivity = 1
	},
	calculate_def_type = {
		normal_attack = 1
	},
	ignore_tactics_maps = {
		"101",
		"102",
		"103",
		"104",
		"105",
		"201",
		"202",
		"203",
		"204",
		"301",
		"302",
		"303",
		"304",
		"401",
		"402",
		"403",
		"404"
	},
	ignore_tactics_battle_point = {
		"9597",
		"9598",
		"9599",
		"9600",
		"9601"
	},
	ignore_tactics_score_maps = {
		"10201",
		"10202",
		"10203",
		"10204",
		"10209",
		"10210",
		"10211",
		"10212",
		"10213",
		"10214",
		"10221",
		"10222",
		"10223",
		"10224",
		"10225",
		"10226"
	},
	ignore_tactics_ninth_maps = {
		"10501",
		"10502",
		"10503",
		"10504",
		"10505",
		"10511",
		"10512",
		"10513",
		"10514",
		"10515"
	},
	work_type = {
		add_attribute = 1,
		add_car_time = 7,
		down_shelling_damage = 12,
		up_battle_core_probability = 5,
		add_resources = 4,
		add_intensify_exp = 9,
		add_shelling_damage = 11,
		add_exp_drill = 3,
		add_cook_time = 6,
		reduce_repair_time = 8,
		add_exp_fight = 2,
		add_torpedo_damage = 10
	}
}

for iter_0_0, iter_0_1 in pairs(var_0_0.ship_type_rule) do
	var_0_0.ship_type[iter_0_0] = iter_0_1.value
end

for iter_0_2, iter_0_3 in pairs(var_0_0.formation_type_rule) do
	var_0_0.formation_type[iter_0_2] = iter_0_3.value
end

function var_0_0.change_table_data(arg_3_0, arg_3_1)
	local var_3_0 = {}

	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		var_3_0[iter_3_1] = iter_3_0
	end

	return var_3_0
end

function var_0_0.get_ship_state_by_value(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = var_0_0.ship_state.normal.value
	local var_4_1 = 1

	for iter_4_0, iter_4_1 in pairs(var_0_0.ship_state) do
		if arg_4_1 / arg_4_2 < iter_4_1.max and arg_4_1 / arg_4_2 >= iter_4_1.min then
			var_4_0 = iter_4_1.value
			var_4_1 = iter_4_1.addition
		end
	end

	return var_4_0, var_4_1
end

function var_0_0.get_ammo_addition(arg_5_0, arg_5_1)
	local var_5_0 = var_0_0.ammunition_addition[1]

	for iter_5_0, iter_5_1 in pairs(var_0_0.ammunition_addition) do
		if arg_5_1 == iter_5_0 - 1 then
			var_5_0 = iter_5_1
		end
	end

	return (arg_5_1 > 6 or nil) and 1
end

function var_0_0.is_aircraft_attack_type(arg_6_0, arg_6_1)
	local var_6_0 = false

	for iter_6_0, iter_6_1 in pairs(var_0_0.ship_type_rule) do
		if iter_6_1.value == arg_6_1 then
			var_6_0 = iter_6_1.aircraft_attack
		end
	end

	return var_6_0
end

function var_0_0.is_open_antisub_attack_type(arg_7_0, arg_7_1)
	local var_7_0 = false

	for iter_7_0, iter_7_1 in pairs(var_0_0.ship_type_rule) do
		if iter_7_1.value == arg_7_1 then
			var_7_0 = iter_7_1.antisub_attack
		end
	end

	return var_7_0
end

function var_0_0.is_normal_attack_type(arg_8_0, arg_8_1)
	local var_8_0 = false

	for iter_8_0, iter_8_1 in pairs(var_0_0.ship_type_rule) do
		if iter_8_1.value == arg_8_1 then
			var_8_0 = iter_8_1.normal_attack
		end
	end

	return var_8_0
end

function var_0_0.is_normal_antisub_type(arg_9_0, arg_9_1)
	local var_9_0 = false

	for iter_9_0, iter_9_1 in pairs(var_0_0.ship_type_rule) do
		if iter_9_1.value == arg_9_1 then
			var_9_0 = iter_9_1.normal_antisub_attack
		end
	end

	return var_9_0
end

function var_0_0.is_normal2_antisub_type(arg_10_0, arg_10_1)
	local var_10_0 = false

	for iter_10_0, iter_10_1 in pairs(var_0_0.ship_type_rule) do
		if iter_10_1.value == arg_10_1 then
			var_10_0 = iter_10_1.normal2_antisub_attack
		end
	end

	return var_10_0
end

function var_0_0.is_normal_aircraft_attack_type(arg_11_0, arg_11_1)
	local var_11_0 = false

	for iter_11_0, iter_11_1 in pairs(var_0_0.ship_type_rule) do
		if iter_11_1.value == arg_11_1 then
			var_11_0 = iter_11_1.normal_aircraft_attack
		end
	end

	return var_11_0
end

function var_0_0.is_normal_or_aircraft_by_have_aircraft(arg_12_0, arg_12_1)
	local var_12_0 = false

	for iter_12_0, iter_12_1 in pairs(var_0_0.ship_type_rule) do
		if iter_12_1.value == arg_12_1 then
			var_12_0 = iter_12_1.normal_or_aircraft_by_have_aircraft
		end
	end

	return var_12_0
end

function var_0_0.is_open_torpedo_attack(arg_13_0, arg_13_1)
	local var_13_0 = false

	for iter_13_0, iter_13_1 in pairs(var_0_0.ship_type_rule) do
		if iter_13_1.value == arg_13_1 then
			var_13_0 = iter_13_1.open_torpedo_attack
		end
	end

	return var_13_0
end

function var_0_0.is_torpedo_attack_type(arg_14_0, arg_14_1)
	local var_14_0 = false

	for iter_14_0, iter_14_1 in pairs(var_0_0.ship_type_rule) do
		if iter_14_1.value == arg_14_1 then
			var_14_0 = iter_14_1.torpedo_attack
		end
	end

	return var_14_0
end

function var_0_0.is_open_missile_attack_type(arg_15_0, arg_15_1)
	local var_15_0 = false

	for iter_15_0, iter_15_1 in pairs(var_0_0.ship_type_rule) do
		if iter_15_1.value == arg_15_1 then
			var_15_0 = iter_15_1.open_missile_attack
		end
	end

	return var_15_0
end

function var_0_0.is_close_missile_attack_type(arg_16_0, arg_16_1)
	local var_16_0 = false

	for iter_16_0, iter_16_1 in pairs(var_0_0.ship_type_rule) do
		if iter_16_1.value == arg_16_1 then
			var_16_0 = iter_16_1.close_missile_attack
		end
	end

	return var_16_0
end

function var_0_0.can_antisub(arg_17_0, arg_17_1)
	local var_17_0 = false

	for iter_17_0, iter_17_1 in pairs(var_0_0.ship_type_rule) do
		if arg_17_1 == iter_17_1.value then
			var_17_0 = iter_17_1.antisub_attack
		end
	end

	return var_17_0
end

function var_0_0.can_night_antisub(arg_18_0, arg_18_1)
	local var_18_0 = false

	for iter_18_0, iter_18_1 in pairs(var_0_0.ship_type_rule) do
		if arg_18_1 == iter_18_1.value then
			var_18_0 = iter_18_1.night_antisub_attack
		end
	end

	return var_18_0
end

function var_0_0.can_night_attack(arg_19_0, arg_19_1)
	local var_19_0 = false

	for iter_19_0, iter_19_1 in pairs(var_0_0.ship_type_rule) do
		if arg_19_1 == iter_19_1.value then
			var_19_0 = iter_19_1.night_attack
		end
	end

	return var_19_0
end

function var_0_0.get_ton_airdef(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = var_0_0.ship_ton_type.small.add_rate

	arg_20_2 = arg_20_2 or "add"
	arg_20_2 = arg_20_2 .. "_rate"

	for iter_20_0, iter_20_1 in pairs(var_0_0.ship_ton_type) do
		if iter_20_1.value == arg_20_1 then
			var_20_0 = iter_20_1[arg_20_2]
		end
	end

	return var_20_0
end

function var_0_0.get_air_control_type(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = var_0_0.air_control_type.equl.value
	local var_21_1 = var_0_0.air_control_type.equl.value

	if arg_21_2 < arg_21_1 then
		if arg_21_1 / arg_21_2 > 3 then
			var_21_0 = var_0_0.air_control_type.supremacy.value
			var_21_1 = var_0_0.air_control_type.supremacy.opposite
		elseif arg_21_1 / arg_21_2 > 1.5 then
			var_21_0 = var_0_0.air_control_type.advantage.value
			var_21_1 = var_0_0.air_control_type.advantage.opposite
		else
			var_21_0 = var_0_0.air_control_type.equl.value
			var_21_1 = var_0_0.air_control_type.equl.opposite
		end
	elseif arg_21_2 / arg_21_1 > 3 then
		var_21_1 = var_0_0.air_control_type.supremacy.value
		var_21_0 = var_0_0.air_control_type.supremacy.opposite
	elseif arg_21_2 / arg_21_1 > 1.5 then
		var_21_1 = var_0_0.air_control_type.advantage.value
		var_21_0 = var_0_0.air_control_type.advantage.opposite
	else
		var_21_1 = var_0_0.air_control_type.equl.value
		var_21_0 = var_0_0.air_control_type.equl.opposite
	end

	return var_21_0, var_21_1
end

function var_0_0.get_air_control_rate(arg_22_0, arg_22_1)
	local var_22_0 = var_0_0.air_control_type.equl.hit_rate
	local var_22_1 = var_0_0.air_control_type.equl.damage_rate

	for iter_22_0, iter_22_1 in pairs(var_0_0.air_control_type) do
		if arg_22_1 == iter_22_1.value then
			var_22_0 = iter_22_1.hit_rate
			var_22_1 = iter_22_1.damage_rate
		end
	end

	return var_22_0, var_22_1
end

function var_0_0.get_drop_rate(arg_23_0, arg_23_1)
	local var_23_0 = var_0_0.air_control_type.equl.r1
	local var_23_1 = var_0_0.air_control_type.equl.r2

	for iter_23_0, iter_23_1 in pairs(var_0_0.air_control_type) do
		if arg_23_1 == iter_23_1.value then
			var_23_0 = iter_23_1.r1
			var_23_1 = iter_23_1.r2
		end
	end

	return var_23_0, var_23_1
end

function var_0_0.get_trigger_type(arg_24_0, arg_24_1)
	local var_24_0 = "all_step"

	for iter_24_0, iter_24_1 in pairs(var_0_0.trigger_type) do
		if iter_24_1 == arg_24_1 then
			var_24_0 = iter_24_0
		end
	end

	return var_24_0
end

function var_0_0.get_attr_name_cn(arg_25_0, arg_25_1)
	if arg_25_1 == nil then
		return ""
	end

	return var_0_0.attribute_name_cn[arg_25_1] or tostring(arg_25_1)
end

function var_0_0.get_ship_type_name_cn(arg_26_0, arg_26_1)
	if arg_26_1 == nil then
		return ""
	end

	return var_0_0.ship_type_name_cn[arg_26_1] or tostring(arg_26_1)
end

function var_0_0.get_ship_ton_name_cn(arg_27_0, arg_27_1)
	if arg_27_1 == nil then
		return ""
	end

	return var_0_0.ship_ton_name_cn[arg_27_1] or tostring(arg_27_1)
end

function var_0_0.get_stage_name_cn(arg_28_0, arg_28_1)
	if arg_28_1 == nil then
		return ""
	end

	if type(arg_28_1) == "table" then
		local var_28_0 = {}

		for iter_28_0, iter_28_1 in pairs(arg_28_1) do
			table.insert(var_28_0, var_0_0.trigger_type_name_cn[iter_28_1] or tostring(iter_28_1))
		end

		return table.concat(var_28_0, "、")
	end

	return var_0_0.trigger_type_name_cn[arg_28_1] or tostring(arg_28_1)
end

function var_0_0.get_condition_type(arg_29_0, arg_29_1)
	local var_29_0 = "default"

	for iter_29_0, iter_29_1 in pairs(var_0_0.condition_type) do
		if iter_29_1.value == arg_29_1 then
			var_29_0 = iter_29_0
		end
	end

	return var_29_0
end

function var_0_0.get_condition_config(arg_30_0, arg_30_1)
	local var_30_0 = {}
	local var_30_1 = {}

	for iter_30_0, iter_30_1 in pairs(var_0_0.condition_type) do
		if iter_30_1.value == arg_30_1 then
			var_30_0 = iter_30_1.must or {}
			var_30_1 = iter_30_1.may or {}
		end
	end

	return var_30_0, var_30_1
end

function var_0_0.get_action_type(arg_31_0, arg_31_1)
	local var_31_0 = "default"

	for iter_31_0, iter_31_1 in pairs(var_0_0.action_type) do
		if iter_31_1 == arg_31_1 then
			var_31_0 = iter_31_0
		end
	end

	return var_31_0
end

function var_0_0.get_action_target_type(arg_32_0, arg_32_1)
	local var_32_0 = "default"

	for iter_32_0, iter_32_1 in pairs(var_0_0.target_type) do
		if iter_32_1 == arg_32_1 then
			var_32_0 = iter_32_0
		end
	end

	return var_32_0
end

function var_0_0.get_direction_addition(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = 1

	for iter_33_0, iter_33_1 in pairs(var_0_0.course_type_rule) do
		if iter_33_1.value == arg_33_1 then
			var_33_0 = iter_33_1.power_effect
		end
	end

	return var_33_0
end

function var_0_0.get_formation_addition(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = {
		crited_rate = 0,
		power_addition = 1,
		crit_rate = 0,
		hit_addition = 0,
		miss_addition = 0
	}

	for iter_34_0, iter_34_1 in pairs(var_0_0.formation_type_rule) do
		if iter_34_1.value == arg_34_1 and iter_34_1[arg_34_2] then
			var_34_0.power_addition = iter_34_1[arg_34_2].power_addition
			var_34_0.hit_addition = iter_34_1[arg_34_2].hit_addition
			var_34_0.miss_addition = iter_34_1[arg_34_2].miss_addition
			var_34_0.crit_rate = iter_34_1.crit_rate
			var_34_0.crited_rate = iter_34_1.crited_rate
		end
	end

	return var_34_0
end

function var_0_0.get_tower_stone_buffs_type(arg_35_0, arg_35_1)
	local var_35_0 = "no_type"

	for iter_35_0, iter_35_1 in pairs(var_0_0.tower_stone_buffs_type) do
		if iter_35_1 == arg_35_1 then
			var_35_0 = iter_35_0

			break
		end
	end

	return var_35_0
end

function var_0_0.get_pve_ocean_cia_buffs_type(arg_36_0, arg_36_1)
	local var_36_0 = "no_type"

	for iter_36_0, iter_36_1 in pairs(var_0_0.ocean_cia_buffs_type) do
		if iter_36_1 == arg_36_1 then
			var_36_0 = iter_36_0

			break
		end
	end

	return var_36_0
end

function var_0_0.get_war_concerto_buffs_type(arg_37_0, arg_37_1)
	local var_37_0 = "no_type"

	for iter_37_0, iter_37_1 in pairs(var_0_0.war_concerto_buffs_type) do
		if iter_37_1 == arg_37_1 then
			var_37_0 = iter_37_0

			break
		end
	end

	return var_37_0
end

function var_0_0.get_solid_strike_buffs_type(arg_38_0, arg_38_1)
	local var_38_0 = "no_type"

	for iter_38_0, iter_38_1 in pairs(var_0_0.solid_strike_buffs_type) do
		if iter_38_1 == arg_38_1 then
			var_38_0 = iter_38_0

			break
		end
	end

	return var_38_0
end

function var_0_0.get_avg_speed_class(arg_39_0, arg_39_1)
	local var_39_0 = var_0_0.ship_type_rule.aircraft_carrier.speed.type
	local var_39_1 = var_0_0.ship_type_rule.aircraft_carrier.speed.value

	for iter_39_0, iter_39_1 in pairs(var_0_0.ship_type_rule) do
		if arg_39_1 == iter_39_1.value then
			var_39_0 = iter_39_1.speed.type
			var_39_1 = iter_39_1.speed.value
		end
	end

	return var_39_0, var_39_1
end

function var_0_0.get_ship_is_guard(arg_40_0, arg_40_1)
	local var_40_0 = false

	for iter_40_0, iter_40_1 in pairs(var_0_0.ship_type_rule) do
		if arg_40_1 == iter_40_1.value then
			var_40_0 = iter_40_1.is_guard
		end
	end

	return var_40_0
end

function var_0_0.get_ship_guard_type(arg_41_0, arg_41_1)
	local var_41_0 = 2

	for iter_41_0, iter_41_1 in pairs(var_0_0.ship_type_rule) do
		var_41_0 = arg_41_1 == iter_41_1.value and iter_41_1.guard_type or var_41_0
	end

	return var_41_0
end

function var_0_0.get_six_ship_level_dmg_rate(arg_42_0, arg_42_1)
	if not arg_42_1 or type(arg_42_1) ~= "number" then
		return
	end

	if arg_42_1 == 1 then
		return 0.1
	elseif arg_42_1 == 2 then
		return 0.25
	elseif arg_42_1 == 3 then
		return 0.5
	else
		return 0
	end
end

function var_0_0.get_abyss_power_level(arg_43_0, arg_43_1)
	if arg_43_1 > 0 and arg_43_1 < 30 then
		return 1
	elseif arg_43_1 >= 30 and arg_43_1 < 50 then
		return 2
	elseif arg_43_1 >= 50 and arg_43_1 < 70 then
		return 3
	elseif arg_43_1 >= 70 and arg_43_1 < 85 then
		return 4
	elseif arg_43_1 >= 85 and arg_43_1 < 100 then
		return 5
	elseif arg_43_1 >= 100 then
		return 6
	end
end

return var_0_0
