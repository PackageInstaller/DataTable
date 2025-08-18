-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13107.lua

local Data = {
	cueFile = "33121",
	[1310701] = {
		bhEvent = "skill.1310701",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331210001,
						331211001
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 3312101,
				flyCueId = 331210002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062,
						331211002
					}
				}
			}
		}
	},
	[1310751] = {
		actTime = 50,
		bhEvent = "skill.1310751",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331210009,
						331211005
					}
				}
			},
			{
				boxId = 3312153,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331210010,
						331211006
					}
				}
			},
			{
				randomTargetNumber = 1,
				boxId = 3312153,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331210010,
						331211006
					}
				}
			},
			{
				randomTargetNumber = 1,
				boxId = 3312153,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331210010,
						331211006
					}
				}
			},
			{
				targetChoose = 7,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 3312153,
						randomTargetNumber = 1,
						eventType = 1,
						hitCue = {
							cueList = {
								331210010,
								331211006
							}
						}
					},
					[3] = {
						boxId = 3312153,
						randomTargetNumber = 1,
						eventType = 1,
						hitCue = {
							cueList = {
								331210010,
								331211006
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				targetChoose = 7,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						boxId = 3312153,
						randomTargetNumber = 1,
						eventType = 1,
						hitCue = {
							cueList = {
								331210010,
								331211006
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
	[1310721] = {
		bhEvent = "skill.1310721",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331210005,
						331211004
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 3312123,
				flyCueId = 331210006,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331210007
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
