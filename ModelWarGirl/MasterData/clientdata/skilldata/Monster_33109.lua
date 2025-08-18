-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33109.lua

local Data = {
	cueFile = "33109",
	[3310901] = {
		bhEvent = "skill.3310901",
		atkEvents = {
			{
				unitDelay = 0.15,
				boxId = 3310901,
				flyCueId = 331090002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331090003,
						331091002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331091001
					}
				}
			}
		}
	},
	[3310951] = {
		actTime = 70,
		bhEvent = "skill.3310951",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331090004,
						331091003
					}
				}
			},
			{
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331090005
					}
				}
			},
			{
				delay = 0.2,
				boxId = 3310951,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331090006,
						331091004
					}
				}
			}
		}
	},
	[3310952] = {
		actTime = 62,
		bhEvent = "skill.3310952",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331090007,
						331091005
					}
				}
			},
			{
				randomTargetNumber = 3,
				flyCueId = 331090008,
				boxType = 1,
				targetChoose = 7,
				unitDelay = 0.3,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 3310901
				},
				hitCue = {
					cueList = {
						331091006,
						331090001
					}
				}
			},
			[1001] = {
				boxId = 3310952,
				disablePassive = 1,
				eventType = 1,
				state = {}
			}
		}
	},
	[3310953] = {
		actTime = 60,
		bhEvent = "skill.3310953",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331090010,
						331091007
					}
				}
			},
			{
				unitDelay = 0.2,
				flyCueId = 331090011,
				boxType = 1,
				state = {},
				hitCue = {
					cueList = {
						331090017
					}
				}
			},
			{
				boxId = 3310953,
				unitDelay = 0.18,
				boxType = 1,
				targetChoose = 4,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331090013,
						331091008
					}
				}
			}
		}
	},
	[3310902] = {
		bhEvent = "skill.3310902",
		atkEvents = {
			{
				unitDelay = 0.15,
				boxId = 3310901,
				flyCueId = 331090015,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331090016,
						331091002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331091001
					}
				}
			}
		}
	},
	[3310954] = {
		actTime = 62,
		bhEvent = "skill.3310954",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331090007,
						331091005
					}
				}
			},
			{
				randomTargetNumber = 2,
				targetChoose = 7,
				state = {
					duration = 8,
					stateId = 3310902
				},
				hitCue = {
					cueList = {
						331090001,
						331091005
					}
				}
			},
			[1001] = {
				boxId = 3310954,
				eventType = 1,
				state = {}
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
