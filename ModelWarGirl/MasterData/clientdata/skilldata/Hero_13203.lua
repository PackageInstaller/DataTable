-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13203.lua

local Data = {
	cueFile = "13203",
	[1320309] = {
		bhEvent = "skill.1320309",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						132030001,
						132030004,
						132031001
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 1320309,
				flyCueId = 132030007,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						132030010,
						132031002
					}
				}
			},
			[1001] = {
				disablePassive = 1,
				subRandomEvents = "1002,1003,1004,1005,1006,1007",
				subEventSkill = 1320309,
				boxId = 1320310,
				subRandomNum = 1,
				eventType = 1,
				state = {}
			},
			[1002] = {
				stunTime = 1,
				state = {}
			},
			[1003] = {
				addManaNumber = -10,
				state = {}
			},
			[1004] = {
				state = {
					duration = 5,
					stateId = 1000001
				}
			},
			[1005] = {
				state = {
					duration = 5,
					stateId = 1000003
				}
			},
			[1006] = {
				state = {
					duration = 3,
					stateId = 1000004
				}
			},
			[1007] = {
				state = {
					duration = 2,
					stateId = 1000006
				}
			}
		}
	},
	[1320310] = {
		bhEvent = "skill.1320310",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						132030002,
						132030005,
						132031003
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 1320309,
				flyCueId = 132030008,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						132030010,
						132031002
					}
				}
			}
		}
	},
	[1320311] = {
		bhEvent = "skill.1320311",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						132030003,
						132030006,
						132031004
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 1320309,
				flyCueId = 132030009,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						132030010,
						132031002
					}
				}
			}
		}
	},
	[1320329] = {
		bhEvent = "skill.1320329",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						132030011,
						132030012,
						132031005
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 1320309,
				flyCueId = 132030013,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						132030014,
						132031006
					}
				}
			},
			{
				boxId = 1320329,
				eventCondition = "1,3,1320301",
				unitDelay = 0.12,
				boxType = 1,
				eventType = 1,
				disablePassive = 1,
				flyCueId = 132030013,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						132030014
					}
				}
			}
		}
	},
	[1320359] = {
		hideTime = 10,
		hideEvent = 3,
		videoActTime = 65,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 40,
		actTime = 90,
		bhEvent = "skill.1320359",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 1320303
				},
				atkCue = {
					cueList = {
						132030015,
						132030016,
						132030017,
						132030019,
						132030027,
						132030028,
						132030029,
						132030030,
						132030031,
						132030032,
						132030033,
						132030034,
						132030035,
						132030036,
						132030037
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						132030020,
						132035001,
						132031008
					}
				}
			},
			{
				boxId = 1320359,
				targetChoose = 12,
				subEventType = 1,
				state = {
					duration = 5,
					stateId = 1320301
				}
			},
			[3] = {
				randomTargetNumber = 3,
				recordSkillTargets = 1,
				randomRule = 2,
				targetChoose = 7,
				state = {}
			},
			{
				targetArea = 3,
				state = {}
			},
			[11] = {
				targetChoose = 12,
				hitedAnim = "Hit",
				state = {},
				hitCue = {
					cueList = {
						132030018
					}
				}
			},
			[27] = {
				hitedAnim = "Hit",
				targetChoose = 12,
				state = {}
			},
			[90] = {
				hitedAnim = "end",
				targetChoose = 12,
				state = {}
			},
			[15] = {
				subEventType = 1,
				subEventSkill = 1320359,
				targetChoose = 12,
				subRandomNum = 1,
				subRandomEvents = "1002,1003,1004,1005,1006,1007",
				state = {}
			},
			[91] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1320303
					}
				}
			},
			[1001] = {
				targetChoose = 12,
				state = {
					duration = 5,
					stateId = 1320301
				}
			},
			[1002] = {
				subEventId = 1009,
				subEventSkill = 1320359,
				eventCondition = "1,1,1320308,1",
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1320351
				},
				atkCue = {
					cueList = {
						132030021
					}
				}
			},
			[1003] = {
				subEventId = 1010,
				subEventSkill = 1320359,
				eventCondition = "1,1,1320308,1",
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1320352
				},
				atkCue = {
					cueList = {
						132030022
					}
				}
			},
			[1004] = {
				subEventId = 1011,
				subEventSkill = 1320359,
				eventCondition = "1,1,1320308,1",
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1320353
				},
				atkCue = {
					cueList = {
						132030023
					}
				}
			},
			[1005] = {
				subEventId = 1012,
				subEventSkill = 1320359,
				eventCondition = "1,1,1320308,1",
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1320354
				},
				atkCue = {
					cueList = {
						132030024
					}
				}
			},
			[1006] = {
				subEventId = 1013,
				subEventSkill = 1320359,
				eventCondition = "1,1,1320308,1",
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1320355
				},
				atkCue = {
					cueList = {
						132030025
					}
				}
			},
			[1007] = {
				subEventId = 1014,
				subEventSkill = 1320359,
				eventCondition = "1,1,1320308,1",
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1320356
				},
				atkCue = {
					cueList = {
						132030026
					}
				}
			},
			[1008] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1320308,
						1320309
					}
				}
			},
			[1009] = {
				delay = 1.7,
				stunTime = 1,
				boxType = 1,
				targetChoose = 12,
				state = {}
			},
			[1010] = {
				delay = 1.7,
				targetChoose = 12,
				boxType = 1,
				state = {
					duration = 5,
					stateId = 1000001
				}
			},
			[1011] = {
				delay = 1.7,
				targetChoose = 12,
				boxType = 1,
				state = {
					duration = 5,
					stateId = 1000003
				}
			},
			[1012] = {
				delay = 1.7,
				boxType = 1,
				targetChoose = 12,
				addManaNumber = -10,
				state = {}
			},
			[1013] = {
				delay = 1.7,
				targetChoose = 12,
				boxType = 1,
				state = {
					duration = 3,
					stateId = 1000004
				}
			},
			[1014] = {
				delay = 1.7,
				targetChoose = 12,
				boxType = 1,
				state = {
					duration = 2,
					stateId = 1000006
				}
			},
			[1015] = {
				addManaNumber = -10,
				stunTime = 1,
				state = {}
			},
			[4] = {
				eventCondition = "0",
				targetChoose = 7,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1320312
					}
				}
			},
			[5] = {
				eventCondition = "1,1,1320311",
				targetChoose = 12,
				state = {
					duration = -999,
					stateId = 1320312
				}
			}
		},
		videoActCue = {
			cueList = {
				132038001,
				132031007
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
