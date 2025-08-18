-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12015.lua

local Data = {
	cueFile = "12015",
	[1201509] = {
		bhEvent = "skill.1201509",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120150001,
						120151001
					}
				}
			},
			{
				boxId = 1201509,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120150002
					}
				}
			}
		}
	},
	[1201510] = {
		bhEvent = "skill.1201510",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120150003,
						120151002
					}
				}
			},
			{
				boxId = 1201510,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120150004
					}
				}
			}
		}
	},
	[1201529] = {
		bhEvent = "skill.1201529",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120150007,
						120151003
					}
				}
			},
			{
				subEventId = 1001,
				eventCondition = "1,1,1201503,1",
				subEventSkill = 1201529,
				targetChoose = 4,
				state = {}
			},
			{
				boxId = 1201529,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120150008
					}
				}
			},
			{
				subEventId = 1003,
				subEventSkill = 1201529,
				stunTime = 1,
				eventCondition = "1,1,1201502",
				state = {}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1201501
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1201502
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 1201503
				}
			},
			[1004] = {
				addManaNumber = 5,
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 1201505
				}
			},
			[1005] = {
				targetArea = 3,
				state = {
					stateId = 1201507,
					stateCondition = 2,
					duration = 1.1
				}
			},
			[1006] = {
				boxId = 1201530,
				targetArea = 3,
				state = {}
			},
			[1007] = {
				targetChoose = 3,
				subEventId = 1010,
				subEventSkill = 1201529,
				targetArea = 2,
				excludeTarget = 1,
				state = {}
			},
			{
				addManaNumber = 10,
				targetArea = 3,
				state = {}
			},
			[1008] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1201502
					}
				}
			},
			[1009] = {
				addManaNumber = 5,
				targetArea = 3,
				state = {}
			},
			[1010] = {
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 1201508
				}
			},
			[1011] = {
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 1201515
				}
			},
			[1012] = {
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 1201516
				}
			},
			[1013] = {
				targetChoose = 3,
				subEventId = 1014,
				subEventSkill = 1201529,
				targetArea = 2,
				excludeTarget = 1,
				state = {}
			},
			[1014] = {
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 1201517
				}
			},
			[1015] = {
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 1201518
				}
			},
			[1016] = {
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 1201519
				}
			},
			[1017] = {
				boxId = 1201511,
				targetChoose = 23,
				eventType = 1,
				state = {}
			}
		}
	},
	[1201559] = {
		hideTime = 1,
		hideEvent = 100,
		videoActTime = 45,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 20,
		actTime = 120,
		bhEvent = "skill.1201559",
		atkEvents = {
			{
				boxId = 1201559,
				eventType = 1,
				state = {
					duration = 3,
					stateId = 1201511
				},
				hitCue = {
					cueList = {
						120150015,
						120153001
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1201509
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120150011,
						120150012,
						120150013,
						120150014
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						120155001,
						120150016,
						120151005
					}
				}
			},
			[11] = {
				targetArea = 3,
				state = {
					duration = 1.2,
					stateId = 1201513
				},
				atkCue = {
					cueList = {
						120150009
					}
				}
			},
			[12] = {
				targetArea = 3,
				state = {}
			},
			[10] = {
				state = {
					duration = 5,
					stateId = 1201512
				}
			},
			[1001] = {
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120150006
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				120158001,
				120151004
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
