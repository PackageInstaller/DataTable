-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13202.lua

local Data = {
	cueFile = "13202",
	[1320209] = {
		bhEvent = "skill.1320209",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						132020001,
						132021001
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1320209,
				flyCueId = 132020002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						132020003,
						132021002
					}
				}
			}
		}
	},
	[1320229] = {
		bhEvent = "skill.1320229",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						132020004,
						132021003
					}
				}
			},
			{
				flyCueId = 132020005,
				boxId = 1320229,
				unitDelay = 0.15,
				boxType = 1,
				subEventId = 1001,
				eventType = 1,
				subEventSkill = 1320229,
				state = {},
				hitCue = {
					cueList = {
						132020007,
						132020007
					}
				},
				levelAtkEvents = {
					[2] = {
						stunTime = 0.3
					},
					[3] = {
						stunTime = 0.3
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				boxId = 1320230,
				excludeTarget = 1,
				unitDelay = 0.2,
				boxType = 1,
				subEventSkill = 1320229,
				subEventId = 1002,
				eventType = 1,
				flyCueId = 132020006,
				targetChoose = 22,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						132020007
					}
				},
				levelAtkEvents = {
					[2] = {
						stunTime = 0.6
					},
					[3] = {
						stunTime = 0.6
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1002] = {
				boxId = 1320231,
				excludeTarget = 1,
				unitDelay = 0.2,
				boxType = 1,
				eventType = 1,
				flyCueId = 132020006,
				targetChoose = 22,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						132020007
					}
				},
				levelAtkEvents = {
					[2] = {
						stunTime = 0.9
					},
					[3] = {
						stunTime = 0.9
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1003] = {
				addManaNumber = 30,
				targetArea = 3,
				state = {}
			},
			[1004] = {
				targetChoose = 9,
				state = {
					duration = 2,
					stateId = 82132021
				}
			}
		}
	},
	[1320259] = {
		hideEffect = 1,
		videoActTime = 70,
		skillTarget = 2,
		prepareCamera = 1,
		prepareCamDruation = 35,
		actTime = 97,
		bhEvent = "skill.1320259",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 1320203
				},
				atkCue = {
					cueList = {
						132020008
					}
				}
			},
			[10] = {
				state = {},
				hitCue = {
					cueList = {
						132020009
					}
				}
			},
			[11] = {
				state = {}
			},
			{
				boxId = 1320259,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						132020010
					}
				}
			},
			[13] = {
				state = {
					duration = -999,
					stateId = 1320201
				},
				atkCue = {
					cueList = {
						132020013,
						132025001,
						132021005
					}
				}
			},
			[1001] = {
				targetArea = 3,
				addManaNumber = 100,
				state = {},
				hitCue = {
					cueList = {
						10000035
					}
				}
			},
			[1002] = {
				boxId = 1320260,
				excludeTarget = 1,
				unitDelay = 0.1,
				boxType = 1,
				eventType = 1,
				flyCueId = 132020006,
				targetChoose = 3,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						132020007
					}
				}
			},
			{
				eventCondition = "1,1,1320204,1",
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1320202
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				132028001,
				132021006
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
