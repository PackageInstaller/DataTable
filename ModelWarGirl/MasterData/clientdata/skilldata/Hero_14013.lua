-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14013.lua

local Data = {
	cueFile = "14013",
	[1401309] = {
		bhEvent = "skill.1401309",
		atkEvents = {
			{
				unitDelay = 0.1,
				boxId = 1401309,
				flyCueId = 140130002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140130003,
						140131003
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140130001,
						140130004,
						140131001
					}
				}
			}
		}
	},
	[1401310] = {
		bhEvent = "skill.1401310",
		atkEvents = {
			{
				unitDelay = 0.1,
				boxId = 1401309,
				flyCueId = 140130002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140130003,
						140131003
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140130001,
						140130004,
						140131002
					}
				}
			}
		}
	},
	[1401359] = {
		hideEffect = 1,
		actTime = 95,
		videoActTime = 70,
		prepareCamDruation = 35,
		prepareCamera = 1,
		bhEvent = "skill.1401359",
		atkEvents = {
			{
				targetChoose = 18,
				subEventId = 1001,
				subEventSkill = 1401359,
				targetArea = 3,
				state = {
					duration = 12,
					stateId = 1401301
				}
			},
			[1001] = {
				targetArea = 3,
				eventCondition = "1,1,1401305",
				flyCueId = 140130008,
				delay = 0.5,
				targetChoose = 18,
				baseToTarget = 1,
				state = {
					duration = 12,
					stateId = 1401302
				}
			},
			[1002] = {
				targetChoose = 18,
				targetArea = 3,
				state = {
					duration = 12,
					stateId = 1401314
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140130011,
						140130012
					}
				}
			},
			[10] = {
				targetArea = 3,
				boxType = 1,
				flyCueId = 140130013,
				delay = 0.5,
				targetChoose = 18,
				recordSkillTargets = 1,
				state = {}
			},
			[11] = {
				targetChoose = 12,
				state = {},
				hitCue = {
					cueList = {
						140130014,
						140130015
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						140130017,
						140135001,
						140131008
					}
				}
			},
			[1003] = {
				targetArea = 3,
				eventCondition = "1,2,1401301",
				boxId = 1401359,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			},
			[1004] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1401305
					}
				}
			},
			{
				targetArea = 3,
				eventProbId = 1401301,
				state = {
					duration = 6,
					stateId = 1401301
				}
			},
			[1005] = {
				targetArea = 3,
				state = {
					duration = 6,
					stateId = 1401314
				}
			},
			{
				subEventId = 1007,
				eventCondition = "1,1,8791190",
				subEventSkill = 1401359,
				targetArea = 3,
				state = {}
			},
			[1006] = {
				targetChoose = 18,
				targetArea = 3,
				state = {
					duration = 12,
					stateId = 82140131
				}
			},
			[1007] = {
				randomTargetNumber = 2,
				targetArea = 3,
				eventCondition = "1,2,1401301,1",
				randomRule = 1,
				targetChoose = 4,
				state = {
					duration = 12,
					stateId = 8791191
				}
			},
			[1008] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 3210849
				}
			}
		},
		videoActCue = {
			cueList = {
				140138001,
				140131007
			}
		}
	},
	[1401329] = {
		bhEvent = "skill.1401329",
		atkEvents = {
			{
				flyCueId = 140130007,
				boxId = 1401330,
				unitDelay = 0.12,
				boxType = 1,
				subEventSkill = 1401329,
				subEventId = 1001,
				eventType = 1,
				stunTime = 0.5,
				state = {
					duration = 4,
					stateId = 1401306
				},
				hitCue = {
					cueList = {
						140130009,
						140131006
					}
				}
			},
			[1001] = {
				randomTargetNumber = 1,
				boxType = 1,
				stunTime = 0.5,
				delay = 0.5,
				boxId = 1401329,
				excludeTarget = 1,
				eventType = 1,
				subEventSkill = 1401329,
				subEventId = 1002,
				flyCueId = 140130008,
				targetChoose = 3,
				baseToTarget = 1,
				state = {
					duration = 4,
					stateId = 1401306
				},
				hitCue = {
					cueList = {
						140130009,
						140131006
					}
				}
			},
			[1002] = {
				randomTargetNumber = 1,
				boxType = 1,
				boxId = 1401329,
				delay = 0.5,
				excludeTarget = 1,
				subEventSkill = 1401329,
				eventType = 1,
				subEventId = 1003,
				flyCueId = 140130008,
				targetChoose = 3,
				baseToTarget = 1,
				state = {
					duration = 4,
					stateId = 1401306
				},
				hitCue = {
					cueList = {
						140130009,
						140131006
					}
				}
			},
			[1003] = {
				randomTargetNumber = 1,
				boxType = 1,
				boxId = 1401329,
				delay = 0.5,
				excludeTarget = 1,
				subEventSkill = 1401329,
				eventType = 1,
				subEventId = 1004,
				flyCueId = 140130008,
				targetChoose = 3,
				baseToTarget = 1,
				state = {
					duration = 4,
					stateId = 1401306
				},
				hitCue = {
					cueList = {
						140130009,
						140131006
					}
				}
			},
			[1004] = {
				randomTargetNumber = 1,
				boxType = 1,
				boxId = 1401329,
				delay = 0.5,
				excludeTarget = 1,
				subEventSkill = 1401329,
				eventType = 1,
				subEventId = 1005,
				flyCueId = 140130008,
				targetChoose = 3,
				baseToTarget = 1,
				state = {
					duration = 4,
					stateId = 1401306
				},
				hitCue = {
					cueList = {
						140130009,
						140131006
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140130005,
						140130006,
						140131004
					}
				}
			},
			[1005] = {
				randomTargetNumber = 1,
				boxType = 1,
				boxId = 1401329,
				delay = 0.5,
				excludeTarget = 1,
				subEventSkill = 1401329,
				eventType = 1,
				subEventId = 1006,
				flyCueId = 140130008,
				targetChoose = 3,
				baseToTarget = 1,
				state = {
					duration = 4,
					stateId = 1401306
				},
				hitCue = {
					cueList = {
						140130009,
						140131006
					}
				}
			},
			[1006] = {
				randomTargetNumber = 1,
				boxType = 1,
				boxId = 1401329,
				delay = 0.5,
				excludeTarget = 1,
				subEventSkill = 1401329,
				eventType = 1,
				subEventId = 1008,
				eventCondition = "1,1,1401311",
				flyCueId = 140130008,
				targetChoose = 3,
				baseToTarget = 1,
				state = {
					duration = 4,
					stateId = 1401306
				},
				hitCue = {
					cueList = {
						140130009,
						140131006
					}
				}
			},
			[1007] = {
				randomTargetNumber = 1,
				boxType = 1,
				boxId = 1401331,
				delay = 0.5,
				excludeTarget = 1,
				eventType = 1,
				flyCueId = 140130008,
				targetChoose = 3,
				baseToTarget = 1,
				state = {
					duration = 4,
					stateId = 1401306
				},
				hitCue = {
					cueList = {
						140130009,
						140131006
					}
				}
			},
			[1008] = {
				state = {
					duration = 4,
					stateId = 1401312
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
