-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33101.lua

local Data = {
	cueFile = "33101",
	[3310101] = {
		bhEvent = "skill.3310101",
		atkEvents = {
			{
				unitDelay = 0.08,
				boxId = 3310101,
				flyCueId = 331010001,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331010002,
						331011001
					}
				}
			},
			[10] = {
				state = {}
			}
		}
	},
	[3310151] = {
		actTime = 40,
		bhEvent = "skill.3310151",
		atkEvents = {
			[10] = {
				targetChoose = 1,
				state = {}
			},
			{
				randomTargetNumber = 3,
				delay = 0.1,
				boxId = 3310151,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331010005,
						331010004
					}
				}
			}
		}
	},
	[3310152] = {
		actTime = 70,
		bhEvent = "skill.3310152",
		atkEvents = {
			{
				delay = 0.1,
				boxId = 3310152,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331010004,
						331010005
					}
				}
			},
			[1001] = {
				targetArea = 2,
				boxId = 3310160,
				targetChoose = 3,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						331010003
					}
				},
				hitCue = {
					cueList = {
						331010002
					}
				}
			},
			[1002] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3310101
				}
			}
		}
	},
	[3310153] = {
		actTime = 45,
		bhEvent = "skill.3310153",
		atkEvents = {
			{
				randomTargetNumber = 1,
				boxId = 3310153,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331010016
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331011005
					}
				}
			}
		}
	},
	[3310154] = {
		actTime = 37,
		bhEvent = "skill.3310154",
		atkEvents = {
			{
				delay = 0.25,
				flyCueId = 331010017,
				boxType = 1,
				state = {},
				hitCue = {
					cueList = {
						331010018
					}
				}
			},
			{
				boxId = 3310154,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331011006
					}
				}
			}
		}
	},
	[3310155] = {
		bhEvent = "skill.3310155",
		atkEvents = {
			[0] = {
				boxId = 3310155,
				targetChoose = 10,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331010004,
						331010005
					}
				}
			}
		}
	},
	[3310156] = {
		actTime = 72,
		bhEvent = "skill.3310156",
		atkEvents = {
			{
				boxId = 3310156,
				targetChoose = 19,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331010004,
						331010005
					}
				}
			}
		}
	},
	[3310157] = {
		actTime = 16,
		bhEvent = "skill.3310157",
		atkEvents = {
			[0] = {
				boxId = 3310157,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331010004,
						331010005
					}
				}
			}
		}
	},
	[3310102] = {
		bhEvent = "skill.3310102",
		atkEvents = {
			{
				randomTargetNumber = 3,
				boxId = 3310102,
				unitDelay = 0.08,
				boxType = 1,
				randomRule = 2,
				eventType = 1,
				flyCueId = 331010001,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						331010002,
						331011001
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
