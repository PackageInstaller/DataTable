-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13019.lua

local Data = {
	cueFile = "13019",
	[1301909] = {
		bhEvent = "skill.1301909",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130190001,
						130191001
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1301909,
				flyCueId = 130190003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130190004,
						130191003
					}
				}
			}
		}
	},
	[1301910] = {
		bhEvent = "skill.1301910",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130190002,
						130191002
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1301909,
				flyCueId = 130190003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130190004,
						130191003
					}
				}
			}
		}
	},
	[1301929] = {
		bhEvent = "skill.1301929",
		atkEvents = {
			[100] = {
				state = {}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1301901
				}
			},
			[1002] = {
				subEventId = 1003,
				subEventType = 1,
				boxId = 1301929,
				eventType = 1,
				disablePassive = 1,
				subEventSkill = 1301929,
				targetChoose = 23,
				state = {},
				hitCue = {
					cueList = {
						130190005,
						130191004
					}
				}
			},
			[1003] = {
				subEventId = 1004,
				subEventType = 1,
				subEventSkill = 1301929,
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1301901
					}
				},
				levelAtkEvents = {
					[2] = {
						addManaNumber = 10
					},
					[3] = {
						addManaNumber = 10
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1004] = {
				subEventId = 1005,
				subEventType = 1,
				subEventSkill = 1301929,
				targetChoose = 23,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 4,
							stateId = 1301903
						}
					},
					[4] = {
						state = {
							duration = 4,
							stateId = 1301903
						}
					},
					[5] = {
						state = {
							duration = 4,
							stateId = 1301903
						}
					},
					[6] = {
						state = {
							duration = 4,
							stateId = 1301903
						}
					}
				}
			},
			{
				state = {}
			},
			[1005] = {
				addManaNumber = 5,
				targetArea = 3,
				eventCondition = "1,1,21301910",
				state = {}
			},
			[1006] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1301901
				}
			},
			[1007] = {
				targetChoose = 23,
				state = {
					duration = 1.5,
					stateId = 82130191
				}
			}
		}
	},
	[1301959] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 40,
		prepareCamera = 1,
		prepareCamDruation = 20,
		actTime = 90,
		bhEvent = "skill.1301959",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130190006,
						130190007,
						130190012
					}
				}
			},
			{
				subEventId = 1001,
				subEventSkill = 1301959,
				boxId = 1301959,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1001] = {
				eventCondition = "1,2,1301903",
				targetChoose = 23,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1301960,
						eventType = 1
					},
					[3] = {
						boxId = 1301960,
						eventType = 1
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1002] = {
				boxId = 1301961,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						130190011,
						130195001,
						130191006
					}
				}
			},
			[11] = {
				targetChoose = 23,
				state = {},
				hitCue = {
					cueList = {
						130190010
					}
				}
			},
			[12] = {
				targetChoose = 23,
				state = {},
				hitCue = {
					cueList = {
						130190008,
						130190009,
						130193001,
						130191007
					}
				}
			},
			{
				subEventId = 1001,
				eventCondition = "1,1,1301905",
				subEventSkill = 1301959,
				boxId = 1301959,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			{
				subEventId = 1001,
				eventCondition = "1,1,21301930",
				subEventSkill = 1301959,
				boxId = 1301959,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						21301921
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				130198001,
				130191005
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
