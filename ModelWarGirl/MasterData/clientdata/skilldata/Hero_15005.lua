-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_15005.lua

local Data = {
	cueFile = "15005",
	[1500509] = {
		bhEvent = "skill.1500509",
		atkEvents = {
			[0] = {
				unitDelay = 0.08,
				boxId = 1500509,
				flyCueId = 90010003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						90010008
					}
				}
			}
		}
	},
	[1500510] = {
		bhEvent = "skill.1500510",
		atkEvents = {
			[0] = {
				unitDelay = 0.08,
				boxId = 1500509,
				flyCueId = 90010003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						90010008
					}
				}
			}
		}
	},
	[1500559] = {
		actTime = 70,
		bhEvent = "skill.1500559",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						150050001
					}
				}
			},
			[0] = {
				randomTargetNumber = 1,
				targetArea = 3,
				boxId = 1500559,
				targetChoose = 4,
				randomRule = 1,
				addManaNumber = 20,
				state = {},
				hitCue = {
					cueList = {
						150050001
					}
				}
			}
		}
	},
	[1500501] = {
		bhEvent = "skill.1500501",
		atkEvents = {
			{
				unitDelay = 0.1,
				boxId = 1500509,
				flyCueId = 150050002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						150050001,
						150051001
					}
				}
			}
		}
	},
	[1500551] = {
		actTime = 40,
		bhEvent = "skill.1500551",
		atkEvents = {
			{
				randomTargetNumber = 1,
				boxId = 1500559,
				randomRule = 1,
				targetArea = 3,
				targetChoose = 4,
				addManaNumber = 20,
				state = {},
				hitCue = {
					cueList = {
						10000008,
						150050003
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						addManaNumber = 30
					},
					[4] = {
						addManaNumber = 30
					},
					[5] = {},
					[6] = {}
				}
			},
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						150051004
					}
				}
			}
		}
	},
	[1500521] = {
		actTime = 50,
		skillTarget = 1,
		bhEvent = "skill.1500521",
		atkEvents = {
			{
				targetChoose = 12,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1500506
				},
				hitCue = {
					cueList = {
						150050004
					}
				}
			},
			[100] = {
				targetChoose = 4,
				recordSkillTargets = 1,
				targetArea = 3,
				excludeTarget = 1,
				state = {},
				atkCue = {
					cueList = {
						150051003
					}
				},
				levelAtkEvents = {
					[2] = {
						targetChoose = 3
					},
					[3] = {
						targetChoose = 7
					},
					[4] = {},
					[5] = {},
					[6] = {}
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
