-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14015.lua

local Data = {
	cueFile = "14015",
	[1401509] = {
		bhEvent = "skill.1401509",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140150001,
						140151001
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1401509,
				flyCueId = 140150002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140150003
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1401501,
					chooseStateMode = 2,
					chooseStateIds = {
						0
					}
				}
			},
			[1001] = {
				boxType = 1,
				unitDelay = 0.15,
				boxId = 1401510,
				eventType = 1,
				state = {}
			}
		}
	},
	[1401510] = {
		bhEvent = "skill.1401510",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140150004,
						140151003
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1401509,
				flyCueId = 140150005,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140150003
					}
				}
			},
			{
				subEventId = 1001,
				targetArea = 3,
				subEventSkill = 1401510,
				state = {
					duration = -999,
					stateId = 1401502,
					chooseStateMode = 2,
					chooseStateIds = {
						0
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1401501,
						1401503
					}
				}
			}
		}
	},
	[1401511] = {
		bhEvent = "skill.1401511",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140150006,
						140151004
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1401509,
				flyCueId = 140150007,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140150003
					}
				}
			},
			{
				subEventId = 1001,
				targetArea = 3,
				subEventSkill = 1401511,
				state = {
					duration = -999,
					stateId = 1401503,
					chooseStateMode = 2,
					chooseStateIds = {
						0
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1401501,
						1401502
					}
				}
			}
		}
	},
	[1401512] = {
		bhEvent = "skill.1401512",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140150008,
						140151005
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1401509,
				flyCueId = 140150009,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140150003
					}
				}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1401501,
						1401502,
						1401503
					}
				}
			}
		}
	},
	[1401529] = {
		bhEvent = "skill.1401529",
		atkEvents = {
			[100] = {
				state = {}
			},
			[1001] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1401509
				}
			},
			[1002] = {
				boxId = 1401530,
				targetChoose = 23,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140150011
					}
				}
			},
			{
				state = {}
			},
			{
				state = {}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1401507
				}
			},
			[1004] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1401507
					}
				}
			},
			[1005] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 21401511
				}
			},
			[1006] = {
				boxId = 1401531,
				targetArea = 1,
				state = {}
			},
			[1007] = {
				boxId = 1401532,
				unitDelay = 0.15,
				boxType = 1,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[1008] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1401509
					}
				}
			}
		}
	},
	[1401559] = {
		hideEffect = 1,
		actTime = 85,
		videoActTime = 40,
		prepareCamDruation = 30,
		prepareCamera = 1,
		bhEvent = "skill.1401559",
		atkEvents = {
			[100] = {
				targetChoose = 7,
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						140150012,
						140150013,
						140150014,
						140150015,
						140150016
					}
				}
			},
			{
				targetChoose = 20,
				subEventSkill = 1401559,
				subEventId = 1002,
				targetArea = 3,
				state = {
					duration = 2.6,
					stateId = 1401504
				},
				hitCue = {
					cueList = {
						140150018
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						140150019,
						140155001,
						140151007
					}
				}
			},
			[14] = {
				state = {},
				atkCue = {
					cueList = {
						140150017
					}
				}
			},
			[15] = {
				targetChoose = 7,
				targetArea = 3,
				excludeTarget = 1,
				state = {}
			},
			{
				targetChoose = 18,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						subEventId = 1002,
						subEventSkill = 1401559,
						state = {
							duration = 2.6,
							stateId = 1401504
						},
						hitCue = {
							cueList = {
								140150018
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				boxId = 1401559,
				targetArea = 1,
				state = {}
			},
			[1002] = {
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 1401505
				}
			},
			[1003] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 21401531
				}
			},
			[1004] = {
				targetChoose = 11,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 21401532
				}
			},
			[1005] = {
				targetChoose = 23,
				state = {
					duration = 5,
					stateId = 1000003
				}
			},
			[1006] = {
				boxId = 1401560,
				targetArea = 3,
				targetChoose = 7,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				140158001,
				140151006
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
