-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12108001_01.lua

local Data = {
	cueFile = "12108",
	[1620709] = {
		bhEvent = "skill.1620709",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121080020,
						121081003
					}
				}
			},
			{
				unitDelay = 0.14,
				subEventType = 1,
				flyCueId = 121080022,
				boxType = 1,
				boxId = 1620709,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						121080021,
						121081008
					}
				}
			},
			{
				targetChoose = 15,
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1210820
				},
				hitCue = {
					cueList = {
						121080025
					}
				}
			},
			{
				subEventId = 1001,
				targetChoose = 7,
				subEventSkill = 1620709,
				state = {}
			},
			[1001] = {
				boxId = 1620710,
				eventCondition = "1,2,1210811",
				unitDelay = 0.14,
				boxType = 1,
				eventType = 1,
				flyCueId = 121080022,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						121080021
					}
				}
			}
		}
	},
	[1620729] = {
		bhEvent = "skill.1620729",
		atkEvents = {
			[100] = {
				state = {}
			},
			[11] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						121086002
					}
				}
			},
			[12] = {
				targetChoose = 23,
				state = {}
			},
			[1001] = {
				targetChoose = 15,
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1210823
				}
			},
			[1003] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						121080008,
						121081005
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
