-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12010.lua

local Data = {
	cueFile = "12008",
	[1201009] = {
		bhEvent = "skill.1201009",
		atkEvents = {
			{
				boxId = 1201009,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			}
		}
	},
	[1201059] = {
		actTime = 30,
		bhEvent = "skill.1201059",
		atkEvents = {
			{
				boxId = 1201059,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120080003
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 10,
							stateId = 1500101
						}
					},
					[4] = {
						state = {
							duration = 10,
							stateId = 1500101
						}
					},
					[5] = {},
					[6] = {}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120081006
					}
				}
			},
			[1001] = {
				targetChoose = 7,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = 15,
					stateId = 1201001
				},
				hitCue = {
					cueList = {
						120080001
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = -999,
							stateId = 1201001
						}
					},
					[4] = {
						state = {
							duration = -999,
							stateId = 1201001
						}
					},
					[5] = {},
					[6] = {}
				}
			},
			[5] = {
				boxId = 1201060,
				targetArea = 3,
				state = {}
			}
		}
	},
	[1201010] = {
		bhEvent = "skill.1201010",
		atkEvents = {
			{
				boxId = 1201009,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
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
