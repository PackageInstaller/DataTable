-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_32102.lua

local Data = {
	cueFile = "32101",
	[3210201] = {
		bhEvent = "skill.3210201",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321011004,
						321010026
					}
				}
			},
			{
				boxId = 3210201,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						321010027
					}
				}
			}
		}
	},
	[3210202] = {
		bhEvent = "skill.3210202",
		atkEvents = {
			{
				boxId = 3210201,
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
	[3210251] = {
		bhEvent = "skill.3210251 ",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321011005,
						321010024
					}
				}
			},
			{
				targetArea = 2,
				boxId = 3210251,
				targetChoose = 3,
				excludeTarget = 1,
				eventType = 1,
				state = {
					duration = 10,
					stateId = 3210201
				},
				atkCue = {
					cueList = {
						321010010
					}
				},
				hitCue = {
					cueList = {
						321010028
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 3210204
				},
				hitCue = {
					cueList = {
						10000048
					}
				}
			}
		}
	},
	[3210252] = {
		skillTarget = 1,
		bhEvent = "skill.3210252",
		atkEvents = {
			[100] = {
				state = {}
			},
			{
				targetChoose = 3,
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 3210202
				},
				atkCue = {
					cueList = {
						321010029,
						321011006
					}
				}
			}
		}
	},
	[3210253] = {
		actTime = 55,
		skillTarget = 1,
		bhEvent = "skill.3210253",
		atkEvents = {
			{
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 3210203
				},
				hitCue = {
					cueList = {
						321010029,
						321011006
					}
				}
			}
		}
	},
	[3210203] = {
		bhEvent = "skill.3210203",
		atkEvents = {
			[100] = {
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						321010024,
						321011005
					}
				}
			},
			{
				targetArea = 2,
				boxId = 3210203,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						321010028
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
