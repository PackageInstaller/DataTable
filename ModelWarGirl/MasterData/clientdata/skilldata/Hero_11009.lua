-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11009.lua

local Data = {
	cueFile = "11007",
	[1100909] = {
		bhEvent = "skill.1100909",
		atkEvents = {
			[0] = {
				boxId = 1100909,
				state = {},
				hitCue = {
					cueList = {
						110070001
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 1100902
				},
				hitCue = {
					cueList = {
						110070001
					}
				}
			},
			{
				boxId = 1100909,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110070002
					}
				}
			}
		}
	},
	[1100959] = {
		actTime = 50,
		skillTarget = 1,
		bhEvent = "skill.1100959",
		atkEvents = {
			[0] = {
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 1100901
				},
				hitCue = {
					cueList = {
						110070001
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110075001
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 1100901
				},
				hitCue = {
					cueList = {
						10000001
					}
				}
			}
		}
	},
	[1100929] = {
		skillTarget = 1,
		bhEvent = "skill.1100929",
		atkEvents = {
			[0] = {
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 1100902
				},
				hitCue = {
					cueList = {
						110070001
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 1100902
				},
				hitCue = {
					cueList = {
						10000001
					}
				}
			}
		}
	},
	[1100910] = {
		bhEvent = "skill.1100910",
		atkEvents = {
			{
				boxId = 1100909,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110070002
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
