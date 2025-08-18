-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13105.lua

local Data = {
	cueFile = "13105",
	[1310529] = {
		bhEvent = "skill.1310529",
		atkEvents = {
			[100] = {
				eventCondition = "1,1,8791270",
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 1310508
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {},
					[4] = {
						state = {
							stateId = 1310508
						}
					},
					[5] = {
						state = {
							stateId = 1310508
						}
					},
					[6] = {
						state = {
							stateId = 1310508
						}
					}
				}
			},
			{
				flyCueId = 131050008,
				unitDelay = 0.15,
				boxType = 1,
				eventCondition = "1,1,1310503,1",
				eventType = 1,
				subEventSkill = 1310529,
				subEventId = 1001,
				state = {},
				hitCue = {
					cueList = {
						131050009,
						131051005
					}
				}
			},
			{
				flyCueId = 131050008,
				unitDelay = 0.15,
				boxType = 1,
				eventCondition = "1,1,1310503",
				eventType = 1,
				subEventSkill = 1310529,
				subEventId = 1003,
				state = {},
				hitCue = {
					cueList = {
						131050009
					}
				}
			},
			[1001] = {
				subEventType = 1,
				subEventId = 1002,
				boxId = 1310529,
				eventType = 1,
				subEventSkill = 1310529,
				targetChoose = 1,
				state = {
					duration = -999,
					stateId = 1310502
				},
				hitCue = {
					cueList = {
						131050012
					}
				},
				baseCue = {
					cueList = {
						131050010
					}
				}
			},
			[1002] = {
				eventCondition = "1,1,1310553",
				targetChoose = 11,
				state = {
					duration = 1,
					stateId = 1310505
				}
			},
			[1003] = {
				subEventType = 1,
				subEventId = 1004,
				boxId = 1310529,
				eventType = 1,
				subEventSkill = 1310529,
				targetChoose = 4,
				state = {
					duration = -999,
					stateId = 1310502
				},
				hitCue = {
					cueList = {
						131050012
					}
				},
				baseCue = {
					cueList = {
						131050011
					}
				}
			},
			[1004] = {
				eventCondition = "1,1,1310553",
				targetChoose = 11,
				state = {
					duration = 1,
					stateId = 1310506
				}
			},
			[1005] = {
				disablePassive = 1,
				boxType = 1,
				delay = 0.1,
				boxId = 1310510,
				eventType = 1,
				state = {}
			},
			[1006] = {
				boxType = 1,
				subEventSkill = 1310529,
				delay = 0.4,
				subEventId = 1007,
				eventType = 1,
				state = {},
				baseCue = {
					cueList = {
						131050010
					}
				}
			},
			[1007] = {
				delay = 0.1,
				subEventType = 1,
				subEventSkill = 1310529,
				boxId = 1310529,
				targetChoose = 1,
				subEventId = 1012,
				state = {
					duration = -999,
					stateId = 1310502
				},
				hitCue = {
					cueList = {
						131050012
					}
				}
			},
			[1008] = {
				boxType = 1,
				subEventSkill = 1310529,
				delay = 0.4,
				subEventId = 1009,
				state = {},
				baseCue = {
					cueList = {
						131050011
					}
				}
			},
			[1009] = {
				delay = 0.1,
				subEventType = 1,
				subEventSkill = 1310529,
				boxId = 1310529,
				targetChoose = 4,
				subEventId = 1013,
				state = {
					duration = -999,
					stateId = 1310502
				},
				hitCue = {
					cueList = {
						131050012
					}
				}
			},
			[99] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1310508
					}
				}
			},
			[1010] = {
				addManaNumber = 2,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						addManaNumber = 4
					},
					[3] = {
						addManaNumber = 4
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1011] = {
				targetArea = 3,
				subEventType = 1,
				boxId = 1310530,
				targetChoose = 13,
				state = {},
				hitCue = {
					cueList = {
						131050014
					}
				}
			},
			[101] = {
				state = {},
				atkCue = {
					cueList = {
						131050007,
						131051004
					}
				}
			},
			[1012] = {
				targetArea = 3,
				state = {
					chooseStateType = 1,
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1310505
					}
				}
			},
			[1013] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1310506
					}
				}
			}
		}
	},
	[1310509] = {
		bhEvent = "skill.1310509",
		atkEvents = {
			{
				unitDelay = 0.15,
				boxId = 1310509,
				flyCueId = 131050002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131050003,
						131051002
					}
				}
			},
			[1002] = {
				boxId = 1310509,
				boxType = 1,
				eventCondition = "1,1,1310551",
				delay = 0.1,
				excludeTarget = 1,
				flyCueId = 131050004,
				targetChoose = 1,
				baseToTarget = 1,
				state = {}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						131050001,
						131051001
					}
				}
			},
			{
				subEventSkill = 1310509,
				subEventId = 1002,
				unitDelay = 0.15,
				boxType = 1,
				eventCondition = "1,1,1310552,1",
				state = {}
			},
			[1003] = {
				boxType = 1,
				boxId = 1310509,
				flyCueId = 131050004,
				delay = 0.1,
				targetChoose = 4,
				baseToTarget = 1,
				excludeTarget = 1,
				state = {}
			},
			{
				subEventSkill = 1310509,
				subEventId = 1003,
				unitDelay = 0.15,
				boxType = 1,
				eventCondition = "1,1,1310552",
				state = {}
			}
		}
	},
	[1310559] = {
		hideTime = 10,
		hideEvent = 101,
		videoActTime = 60,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 35,
		actTime = 93,
		bhEvent = "skill.1310559",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						131050017,
						131050018
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						131050024,
						131055001,
						131051007
					}
				}
			},
			{
				boxId = 1310559,
				targetChoose = 4,
				hitedAnim = "Hit",
				state = {},
				hitCue = {
					cueList = {
						131050019
					}
				}
			},
			{
				subEventId = 1005,
				targetArea = 3,
				subEventSkill = 1310559,
				state = {
					duration = -999,
					stateId = 1310504
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1310551
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1310552
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1310553
				}
			},
			[4] = {
				eventCondition = "1,1,1310552",
				targetChoose = 7,
				state = {},
				levelAtkEvents = {
					[2] = {
						subEventSkill = 1310559,
						subEventId = 1004
					},
					[3] = {
						subEventSkill = 1310559,
						subEventId = 1004
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1004] = {
				boxId = 1310560,
				eventCondition = "1,2,1310502",
				state = {},
				hitCue = {
					cueList = {
						131050023
					}
				}
			},
			[1005] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = -999,
							stateId = 1310554
						}
					},
					[4] = {
						state = {
							duration = -999,
							stateId = 1310554
						}
					},
					[5] = {
						state = {
							duration = -999,
							stateId = 1310554
						}
					},
					[6] = {
						state = {
							duration = -999,
							stateId = 1310554
						}
					}
				}
			},
			[1006] = {
				randomTargetNumber = 1,
				boxId = 1310561,
				targetChoose = 4,
				state = {},
				hitCue = {
					cueList = {
						131050015
					}
				}
			},
			{
				state = {},
				atkCue = {
					cueList = {
						131050016
					}
				}
			},
			[101] = {
				targetChoose = 4,
				state = {},
				levelAtkEvents = {
					[2] = {
						targetChoose = 7
					},
					[3] = {
						targetChoose = 7
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[99] = {
				hitedAnim = "end",
				targetChoose = 4,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				131058001,
				131051006
			}
		}
	},
	[1310510] = {
		bhEvent = "skill.1310510",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						131050005,
						131051003
					}
				}
			},
			{
				unitDelay = 0.15,
				boxType = 1,
				flyCueId = 131050006,
				boxId = 1310509,
				state = {},
				hitCue = {
					cueList = {
						131050003,
						131051002
					}
				}
			},
			{
				subEventSkill = 1310509,
				subEventId = 1002,
				unitDelay = 0.15,
				boxType = 1,
				eventCondition = "1,1,1310552,1",
				state = {}
			},
			{
				subEventSkill = 1310509,
				subEventId = 1003,
				unitDelay = 0.15,
				boxType = 1,
				eventCondition = "1,1,1310552",
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
