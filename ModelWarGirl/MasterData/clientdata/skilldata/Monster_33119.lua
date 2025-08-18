-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33119.lua

local Data = {
	cueFile = "33119",
	[3311901] = {
		bhEvent = "skill.3311901",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331190001,
						331190002,
						331191001
					}
				}
			},
			{
				delay = 0.1,
				boxType = 1,
				boxId = 3311901,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			{
				boxType = 1,
				delay = 0.1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			{
				boxType = 1,
				delay = 0.1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			}
		}
	},
	[3311902] = {
		bhEvent = "skill.3311902",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331190003,
						331190004,
						331191002
					}
				}
			},
			{
				unitDelay = 0.25,
				boxId = 3311902,
				flyCueId = 331190007,
				boxType = 1,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			{
				unitDelay = 0.25,
				boxId = 3311902,
				flyCueId = 331190008,
				boxType = 1,
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
	[3311921] = {
		bhEvent = "skill.3311921",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331190011,
						331191003
					}
				}
			},
			{
				randomTargetNumber = 1,
				boxId = 3311921,
				unitDelay = 0.3,
				boxType = 1,
				eventType = 1,
				flyCueId = 331190009,
				targetChoose = 19,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			{
				randomTargetNumber = 1,
				boxId = 3311921,
				flyCueId = 331190010,
				boxType = 1,
				targetChoose = 19,
				unitDelay = 0.3,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			}
		}
	},
	[3311922] = {
		bhEvent = "skill.3311922",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					chooseStateType = 2,
					stateOperation = 1,
					chooseStateMode = 1
				},
				atkCue = {
					cueList = {
						331191004
					}
				}
			},
			{
				randomTargetNumber = 1,
				boxId = 3311922,
				unitDelay = 0.3,
				boxType = 1,
				randomRule = 4,
				flyCueId = 331190012,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						331190014,
						331191005
					}
				}
			}
		}
	},
	[3311951] = {
		actTime = 45,
		bhEvent = "skill.3311951",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331190015,
						331190016,
						331191006
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 3311901
				}
			}
		}
	},
	[3311923] = {
		bhEvent = "skill.3311922",
		atkEvents = {
			[100] = {
				summonLineChoose = 3,
				targetArea = 3,
				summonMonsters = "70230022",
				state = {
					duration = 1,
					stateId = 3311903
				}
			},
			{
				summonLineChoose = 1,
				targetArea = 3,
				summonMonsters = "70230022",
				state = {
					duration = -999,
					stateId = 3311904
				}
			},
			[1001] = {
				targetChoose = 16,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3311002
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
