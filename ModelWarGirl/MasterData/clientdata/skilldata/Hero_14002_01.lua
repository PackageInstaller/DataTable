-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14002_01.lua

local Data = {
	cueFile = "14002",
	[1620109] = {
		bhEvent = "skill.1620109",
		atkEvents = {
			[0] = {
				boxId = 1620109,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062,
						140021007
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140020010
					}
				}
			}
		}
	},
	[1620110] = {
		bhEvent = "skill.1620110",
		atkEvents = {
			[0] = {
				unitDelay = 0.08,
				boxId = 1620109,
				flyCueId = 90010002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140020001
					}
				}
			},
			[100] = {
				state = {}
			}
		}
	},
	[1620159] = {
		actTime = 46,
		bhEvent = "skill.1620159",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						140020011,
						140021008
					}
				}
			},
			[0] = {
				boxId = 1620159,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140020012
					}
				}
			},
			{
				boxId = 1620160,
				targetArea = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10006006
					}
				}
			}
		}
	},
	[1620160] = {
		actTime = 46,
		bhEvent = "skill.1620160",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140020011,
						140021008
					}
				}
			},
			[0] = {
				boxId = 1620161,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140020012
					}
				}
			},
			{
				boxId = 1620160,
				targetArea = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10006006
					}
				}
			}
		}
	}
}
local skillDefault = {}
local atkEventsDefault = {
	randomTargetNumber = 0,
	boxType = 0,
	flyCueId = 0,
	eventType = 0,
	delay = 0,
	stateCondition = 0,
	boxId = 0,
	eventProbId = 0
}

for k, skillData in pairs(Data) do
	if k ~= "cueFile" then
		setmetatable(skillData, {
			__index = skillDefault
		})

		for skillKey, skillInfo in pairs(skillData) do
			if skillKey == "atkEvents" then
				for eventsKey, event in pairs(skillInfo) do
					setmetatable(event, {
						__index = atkEventsDefault
					})
				end
			end
		end
	end
end

return Data
