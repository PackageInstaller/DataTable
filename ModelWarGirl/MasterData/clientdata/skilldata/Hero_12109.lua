-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12109.lua

local Data = {
	cueFile = "33111",
	[1210901] = {
		bhEvent = "skill.1210901",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331110003,
						331111001
					}
				}
			},
			{
				boxId = 3311101,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331110004,
						331111002
					}
				}
			}
		}
	},
	[1210921] = {
		skillTarget = 1,
		bhEvent = "skill.1210921",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331110017,
						331110019,
						331110020,
						331110021,
						331111006
					}
				}
			},
			{
				targetArea = 1,
				state = {
					duration = 8,
					stateId = 1210901
				}
			},
			[1001] = {
				boxId = 3311121,
				targetArea = 1,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			}
		}
	},
	[1210959] = {
		actTime = 50,
		bhEvent = "skill.1210959",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331110009,
						331110010,
						331111003
					}
				}
			},
			{
				boxId = 3311151,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 3311103
				},
				hitCue = {
					cueList = {
						331110011,
						331111004
					}
				}
			},
			{
				state = {
					duration = 5,
					stateId = 1000003
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
