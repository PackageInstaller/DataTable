-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\BehaviorData\\Hero_15901.lua

local Data = {
	["skill.1590101"] = {
		stateName = "skill1590101",
		skillLength = 1.6,
		motion = {
			events = {
				effect1 = {
					intParameter = 1,
					functionName = "effect",
					time = 0.0006033618,
					stringParameter = "Effects/Heros/15002/efx_15002_battle_attack_basic_01_1.prefab",
					data = "Effects/Heros/15002/efx_15002_battle_attack_basic_01_1.prefab"
				},
				audio2 = {
					functionName = "audio",
					data = "Audios/SFX/Hero/hero_vocal_battle_15002_11_1.ogg",
					time = 0.04315353,
					stringParameter = "Audios/SFX/Hero/hero_vocal_battle_15002_11_1.ogg"
				},
				atk3 = {
					time = 0.9266621,
					functionName = "atk"
				},
				supercancel4 = {
					time = 1.359097,
					functionName = "supercancel"
				}
			}
		}
	},
	["skill.1590151"] = {
		stateName = "skill1590151",
		skillLength = 2,
		motion = {
			events = {
				atk1 = {
					intParameter = 100,
					time = 0.0556962,
					functionName = "atk"
				},
				VideoPause2 = {
					time = 0.5113924,
					functionName = "VideoPause"
				},
				atk3 = {
					intParameter = 1,
					time = 1.225316,
					functionName = "atk"
				}
			}
		}
	},
	["skill.1590121"] = {
		stateName = "skill1590121",
		skillLength = 2.166667,
		motion = {
			events = {
				atk1 = {
					intParameter = 100,
					time = 0.04388186,
					functionName = "atk"
				},
				atk2 = {
					intParameter = 1,
					time = 1.625049,
					functionName = "atk"
				}
			}
		}
	}
}

return Data
