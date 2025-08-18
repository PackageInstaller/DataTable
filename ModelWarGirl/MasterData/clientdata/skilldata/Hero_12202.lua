-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12202.lua

local Data = {
	cueFile = "32104",
	[1220209] = {
		bhEvent = "skill.1220209",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321040011
					}
				}
			},
			{
				boxId = 1220209,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			}
		}
	},
	[1220210] = {
		bhEvent = "skill.1220210",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321040012
					}
				}
			},
			{
				boxId = 1220209,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			}
		}
	},
	[1220229] = {
		bhEvent = "skill.1220229",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321040017,
						321040018,
						321040019
					}
				}
			},
			{
				boxId = 1220229,
				targetChoose = 1,
				state = {},
				hitCue = {
					cueList = {
						321040020
					}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 5,
							stateId = 1220202
						}
					},
					[3] = {
						state = {
							duration = 5,
							stateId = 1220202
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		}
	},
	[1220259] = {
		skillTarget = 1,
		bhEvent = "skill.1220259",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321040021
					}
				}
			},
			{
				targetArea = 2,
				state = {
					duration = 8,
					stateId = 1220201
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
