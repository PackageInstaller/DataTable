-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\BehaviorData\\Hero_10001.lua

local Data = {
	["skill.10001"] = {
		stateName = "skill10001",
		skillLength = 1.466667,
		motion = {
			events = {
				effect1 = {
					functionName = "effect",
					data = "Effects/Heros/10001/H001_battle_attack_basic_01.prefab",
					stringParameter = "Effects/Heros/10001/H001_battle_attack_basic_01.prefab"
				},
				atk2 = {
					time = 0.5696428,
					functionName = "atk"
				},
				supercancel3 = {
					time = 0.8413691,
					functionName = "supercancel"
				}
			}
		}
	},
	["skill.10002"] = {
		stateName = "skill10002",
		skillLength = 1.2,
		motion = {
			events = {
				effect1 = {
					functionName = "effect",
					data = "Effects/Heros/10001/H001_battle_attack_basic_02.prefab",
					stringParameter = "Effects/Heros/10001/H001_battle_attack_basic_02.prefab"
				},
				atk2 = {
					time = 0.4205357,
					functionName = "atk"
				},
				supercancel3 = {
					time = 0.9736608,
					functionName = "supercancel"
				}
			}
		}
	},
	["skill.10101"] = {
		stateName = "skill10101",
		skillLength = 6.666667,
		motion = {
			events = {
				offset1 = {
					floatParameter = 1,
					data = "start",
					functionName = "offset",
					stringParameter = "start"
				},
				atk2 = {
					intParameter = 1,
					functionName = "atk"
				},
				camera3 = {
					floatParameter = 25,
					data = "Camera/CameraCurvy/Heroes/10001/AnimationOffset.anim",
					functionName = "camera",
					stringParameter = "Camera/CameraCurvy/Heroes/10001/AnimationOffset.anim"
				},
				effect4 = {
					functionName = "effect",
					data = "Effects/Heros/10001/H001_battle_attack_ultra_01_1.prefab",
					time = 1.287554,
					stringParameter = "Effects/Heros/10001/H001_battle_attack_ultra_01_1.prefab"
				},
				atk5 = {
					time = 1.431605,
					functionName = "atk"
				},
				atk6 = {
					time = 1.813975,
					functionName = "atk"
				},
				atk7 = {
					intParameter = 10,
					time = 3.662375,
					functionName = "atk"
				},
				atk8 = {
					intParameter = 99,
					time = 3.908555,
					functionName = "atk"
				},
				atk9 = {
					intParameter = 11,
					time = 5.541462,
					functionName = "atk"
				},
				offset10 = {
					functionName = "offset",
					floatParameter = 1,
					time = 6.380543,
					stringParameter = "stop",
					data = "stop"
				},
				atk11 = {
					intParameter = 100,
					time = 6.666667,
					functionName = "atk"
				}
			}
		}
	}
}

return Data
