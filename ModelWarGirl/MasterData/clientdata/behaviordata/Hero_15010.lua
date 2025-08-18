-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\BehaviorData\\Hero_15010.lua

local Data = {
	["skill.1501009"] = {
		stateName = "skill1501009",
		skillLength = 1.5,
		motion = {
			events = {
				atk1 = {
					intParameter = 100,
					functionName = "atk"
				},
				audio2 = {
					intParameter = 100,
					functionName = "audio",
					time = 0.03515625,
					stringParameter = "Audios/SFX/Hero/hero_vocal_battle_14007_11_1.ogg",
					data = "Audios/SFX/Hero/hero_vocal_battle_14007_11_1.ogg"
				},
				atk3 = {
					time = 0.7379209,
					functionName = "atk"
				},
				supercancel4 = {
					intParameter = 100,
					time = 1.274153,
					functionName = "supercancel"
				}
			}
		}
	},
	["skill.1501059"] = {
		stateName = "skill1501059",
		skillLength = 1.833333,
		motion = {
			events = {
				atk1 = {
					intParameter = 10,
					functionName = "atk"
				},
				atk2 = {
					intParameter = 2,
					time = 1.519278,
					functionName = "atk"
				}
			}
		}
	},
	["skill.1501021"] = {
		stateName = "skill1501021",
		skillLength = 1,
		motion = {
			events = {
				atk1 = {
					intParameter = 10,
					functionName = "atk"
				},
				atk2 = {
					intParameter = 1,
					time = 0.2974523,
					functionName = "atk"
				},
				atk3 = {
					intParameter = 2,
					time = 0.5005015,
					functionName = "atk"
				}
			}
		}
	}
}

return Data
