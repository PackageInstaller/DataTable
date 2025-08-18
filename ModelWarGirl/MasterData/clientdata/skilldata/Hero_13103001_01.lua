-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13103001_01.lua

local Data = {
	cueFile = "13103",
	[1640109] = {
		skillTarget = 1,
		bhEvent = "skill.1640109",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						131030031
					}
				}
			},
			{
				randomTargetNumber = 1,
				flyCueId = 131030004,
				boxType = 1,
				targetChoose = 19,
				unitDelay = 0.2,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131030005
					}
				}
			}
		}
	},
	[1640110] = {
		skillTarget = 1,
		bhEvent = "skill.1640110",
		atkEvents = {
			[100] = {
				targetArea = 1,
				state = {},
				atkCue = {
					cueList = {
						131030032
					}
				}
			},
			{
				randomTargetNumber = 1,
				boxId = 1310309,
				unitDelay = 0.2,
				boxType = 1,
				eventType = 1,
				flyCueId = 131030007,
				targetChoose = 19,
				state = {},
				hitCue = {
					cueList = {
						131030008
					}
				}
			}
		}
	},
	[1640111] = {
		skillTarget = 1,
		bhEvent = "skill.1640111",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						131030010,
						131030011,
						131030033
					}
				}
			},
			{
				randomTargetNumber = 1,
				boxId = 1310309,
				unitDelay = 0.2,
				boxType = 1,
				eventType = 1,
				flyCueId = 131030012,
				targetChoose = 19,
				state = {},
				hitCue = {
					cueList = {
						131030013
					}
				}
			}
		}
	},
	[1640112] = {
		skillTarget = 1,
		bhEvent = "skill.1640112",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						131030015,
						131030016,
						131030034
					}
				}
			},
			{
				randomTargetNumber = 1,
				boxId = 1310309,
				unitDelay = 0.2,
				boxType = 1,
				eventType = 1,
				flyCueId = 131030017,
				targetChoose = 19,
				state = {},
				hitCue = {
					cueList = {
						131030018
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
