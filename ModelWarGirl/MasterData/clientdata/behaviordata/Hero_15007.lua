-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\BehaviorData\\Hero_15007.lua

local Data = {
	["skill.1500709"] = {
		stateName = "skill1500709",
		skillLength = 1.233333,
		motion = {
			events = {
				effect1 = {
					functionName = "effect",
					data = "Effects/Heros/13007/efx_13007_battle_attack_basic_01_hand.prefab",
					stringParameter = "Effects/Heros/13007/efx_13007_battle_attack_basic_01_hand.prefab"
				},
				audio2 = {
					intParameter = 1,
					functionName = "audio",
					time = 0.03854167,
					stringParameter = "Audios/SFX/Hero/hero_vocal_battle_13007_11_1.ogg",
					data = "Audios/SFX/Hero/hero_vocal_battle_13007_11_1.ogg"
				},
				atk3 = {
					intParameter = 1,
					time = 0.4809566,
					functionName = "atk"
				},
				supercancel4 = {
					intParameter = 1,
					time = 0.9826432,
					functionName = "supercancel"
				}
			}
		}
	},
	["skill.1500729"] = {
		stateName = "skill1500729",
		skillLength = 0.9333334,
		motion = {
			events = {
				atk1 = {
					intParameter = 100,
					time = 0.03391004,
					functionName = "atk"
				},
				effect2 = {
					functionName = "effect",
					data = "Effects/Heros/11008/efx_11008_battle_attack_passive_01.prefab",
					time = 0.3164468,
					stringParameter = "Effects/Heros/11008/efx_11008_battle_attack_passive_01.prefab"
				},
				atk3 = {
					intParameter = 1,
					time = 0.4879668,
					functionName = "atk"
				}
			}
		}
	},
	["skill.1500759"] = {
		stateName = "skill1500759",
		skillLength = 1.533333,
		motion = {
			events = {
				atk1 = {
					intParameter = 10,
					functionName = "atk"
				},
				atk2 = {
					intParameter = 1,
					time = 0.7995253,
					functionName = "atk"
				},
				supercancel3 = {
					intParameter = 1,
					time = 1.285142,
					functionName = "supercancel"
				}
			}
		}
	}
}

return Data
