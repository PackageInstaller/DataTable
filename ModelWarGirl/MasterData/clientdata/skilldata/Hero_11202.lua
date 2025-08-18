-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11202.lua

local Data = {
	cueFile = "32104",
	[1120210] = {
		bhEvent = "skill.1120210",
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
				boxId = 1120209,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			}
		}
	},
	[1120229] = {
		bhEvent = "skill.1120229",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321040014,
						321040015
					}
				}
			},
			{
				boxId = 1120229,
				targetChoose = 2,
				state = {},
				hitCue = {
					cueList = {
						321040016
					}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1120230,
						hitCue = {
							cueList = {
								10000025
							}
						}
					},
					[3] = {
						boxId = 1120230,
						hitCue = {
							cueList = {
								10000025
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		}
	},
	[1120209] = {
		bhEvent = "skill.1120209",
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
				boxId = 1120209,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			}
		}
	},
	[1120259] = {
		skillTarget = 1,
		bhEvent = "skill.1120259",
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
					stateId = 1120201
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
