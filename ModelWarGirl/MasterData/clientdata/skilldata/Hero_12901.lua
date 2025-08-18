-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12901.lua

local Data = {
	cueFile = "12012",
	[1290101] = {
		bhEvent = "skill.1290101",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120120001
					}
				}
			},
			{
				boxId = 1290101,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120120004
					}
				}
			}
		}
	},
	[1290121] = {
		bhEvent = "skill.1290101",
		atkEvents = {
			[100] = {
				state = {}
			},
			[1001] = {
				boxId = 1290121,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120120004
					}
				}
			},
			[1002] = {
				boxId = 1290122,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			{
				state = {}
			}
		}
	},
	[1290151] = {
		actTime = 96,
		videoActTime = 64,
		bhEvent = "skill.1290151",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120120007
					}
				}
			},
			{
				boxId = 1290151,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120120009
					}
				}
			},
			{
				boxId = 1290152,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				120128001,
				120121006
			}
		}
	},
	[1290152] = {
		actTime = 96,
		videoActTime = 64,
		bhEvent = "skill.1290152",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120120007
					}
				}
			},
			{
				boxId = 1290161,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120120009
					}
				}
			},
			{
				boxId = 1290152,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				120128001,
				120121006
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
