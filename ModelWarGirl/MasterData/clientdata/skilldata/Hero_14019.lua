-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14019.lua

local Data = {
	cueFile = "14019",
	[1401909] = {
		bhEvent = "skill.1401909",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140191001
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1401909,
				flyCueId = 140190001,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140190002,
						140191002
					}
				}
			},
			[1001] = {
				subRandomEvents = "1002,1003,1004",
				subRandomNum = 1,
				subEventSkill = 1401909,
				state = {}
			},
			[1002] = {
				state = {
					duration = 5,
					stateId = 1000001
				}
			},
			[1003] = {
				state = {
					duration = 5,
					stateId = 1000003
				}
			},
			[1004] = {
				state = {
					duration = 5,
					stateId = 1000013
				}
			}
		}
	},
	[1401910] = {
		bhEvent = "skill.1401910",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140191003
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1401909,
				flyCueId = 140190003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140190004,
						140191004
					}
				}
			}
		}
	},
	[1401929] = {
		bhEvent = "skill.1401929",
		atkEvents = {
			{
				subRandomEvents = "1008,1009,1010",
				subRandomNum = 1,
				subEventSkill = 1401929,
				state = {}
			},
			[1001] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1401904
				}
			},
			[1002] = {
				subEventSkill = 1401929,
				unitDelay = 0.15,
				boxId = 1401929,
				subEventId = 1005,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140190007,
						140191006
					}
				}
			},
			[1003] = {
				subEventSkill = 1401929,
				unitDelay = 0.15,
				boxId = 1401929,
				subEventId = 1006,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140190008,
						140191006
					}
				}
			},
			[1004] = {
				unitDelay = 0.15,
				boxId = 1401929,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 1401905
				},
				hitCue = {
					cueList = {
						140190009,
						140191006
					}
				}
			},
			[1005] = {
				delay = 0.1,
				boxType = 1,
				boxId = 1401930,
				eventType = 1,
				state = {}
			},
			[1006] = {
				delay = 0.1,
				boxType = 1,
				boxId = 1401931,
				eventType = 1,
				state = {}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140190005,
						140191005
					}
				},
				hitCue = {
					cueList = {
						140190006
					}
				}
			},
			[1007] = {
				delay = 0.15,
				boxId = 1401932,
				excludeTarget = 1,
				boxType = 1,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[1008] = {
				subEventId = 1005,
				subEventSkill = 1401929,
				boxId = 1401933,
				eventType = 1,
				state = {
					duration = 2.5,
					stateId = 1000001
				},
				hitCue = {
					cueList = {
						140190007,
						140191006
					}
				}
			},
			[1009] = {
				subEventId = 1006,
				subEventSkill = 1401929,
				boxId = 1401933,
				eventType = 1,
				state = {
					duration = 2.5,
					stateId = 1000003
				},
				hitCue = {
					cueList = {
						140190008,
						140191006
					}
				}
			},
			[1010] = {
				subEventId = 1011,
				subEventSkill = 1401929,
				boxId = 1401933,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 1401905
				},
				hitCue = {
					cueList = {
						140190009,
						140191006
					}
				}
			},
			[1011] = {
				state = {
					duration = 2.5,
					stateId = 1000013
				}
			},
			[1012] = {
				boxId = 1401934,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1013] = {
				boxId = 1401935,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1014] = {
				boxId = 1401960,
				disablePassive = 1,
				eventType = 1,
				state = {}
			}
		}
	},
	[1401959] = {
		actTime = 80,
		videoActTime = 25,
		hideTime = 10,
		hideEvent = 100,
		bhEvent = "skill.1401959",
		atkEvents = {
			{
				subEventId = 1004,
				subEventSkill = 1401959,
				eventCondition = "1,1,1401901,1",
				state = {},
				hitCue = {
					cueList = {
						140190014,
						140190015,
						140193001,
						140195002,
						140191009
					}
				}
			},
			{
				subEventId = 1005,
				subEventSkill = 1401959,
				eventCondition = "1,1,1401901",
				state = {},
				hitCue = {
					cueList = {
						140190014,
						140190015,
						140193001,
						140195002,
						140191009
					}
				}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1401901
					}
				}
			},
			[1001] = {
				targetChoose = 3,
				state = {
					duration = 5,
					stateId = 1000001
				}
			},
			[1002] = {
				targetChoose = 3,
				state = {
					duration = 5,
					stateId = 1000003
				}
			},
			[1003] = {
				targetChoose = 3,
				state = {
					duration = 5,
					stateId = 1000013
				}
			},
			{
				targetChoose = 3,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 5,
							stateId = 1401902
						}
					},
					[3] = {
						state = {
							duration = 5,
							stateId = 1401902
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1004] = {
				subRandomEvents = "1001,1002,1003",
				subEventType = 1,
				boxId = 1401959,
				subRandomNum = 1,
				eventType = 1,
				subEventSkill = 1401959,
				targetChoose = 3,
				state = {},
				hitCue = {
					cueList = {
						140190015
					}
				}
			},
			[1005] = {
				subRandomEvents = "1001,1002,1003",
				subEventType = 1,
				boxId = 1401959,
				subRandomNum = 3,
				eventType = 1,
				subEventSkill = 1401959,
				targetChoose = 3,
				state = {},
				hitCue = {
					cueList = {
						140190015
					}
				}
			},
			[100] = {
				targetChoose = 3,
				state = {},
				atkCue = {
					cueList = {
						140190010,
						140190011
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						140190016,
						140195001,
						140191008
					}
				}
			},
			[15] = {
				state = {},
				hitCue = {
					cueList = {
						140190012,
						140190013
					}
				}
			},
			[1006] = {
				targetChoose = 3,
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 21401911
				}
			}
		},
		videoActCue = {
			cueList = {
				140198001,
				140191007
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
