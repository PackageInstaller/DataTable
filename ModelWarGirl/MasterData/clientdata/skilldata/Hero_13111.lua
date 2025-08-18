-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13111.lua

local Data = {
	cueFile = "33116",
	[1311101] = {
		bhEvent = "skill.1311101",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						331160001,
						331161001
					}
				}
			},
			{
				flyCueId = 331160002,
				boxId = 3311601,
				unitDelay = 0.2,
				boxType = 1,
				subEventId = 1001,
				eventType = 1,
				subEventSkill = 1311101,
				state = {},
				hitCue = {
					cueList = {
						10000062,
						331161002
					}
				}
			},
			[1001] = {
				boxId = 3311602,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			}
		}
	},
	[1311121] = {
		bhEvent = "skill.1311121",
		atkEvents = {
			[100] = {
				state = {}
			},
			[1001] = {
				boxId = 3311621,
				targetChoose = 4,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331160010
					}
				}
			}
		}
	},
	[1311159] = {
		actTime = 46,
		bhEvent = "skill.1311159",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331160006,
						331161007
					}
				}
			},
			[2] = {
				delay = 0.4,
				flyCueId = 331160011,
				boxType = 1,
				state = {},
				hitCue = {
					cueList = {
						331160010,
						331161008
					}
				}
			},
			{
				boxId = 3311653,
				targetChoose = 4,
				eventType = 1,
				state = {
					duration = 8,
					stateId = 3311605
				},
				hitCue = {
					cueList = {
						331160008
					}
				}
			},
			[3] = {
				state = {},
				hitCue = {
					cueList = {
						331160012
					}
				}
			},
			[1001] = {
				boxId = 3311660,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000063
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
