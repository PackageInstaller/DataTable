-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13012.lua

local Data = {
	cueFile = "13012",
	[1301209] = {
		bhEvent = "skill.1301209",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1301211
					}
				},
				atkCue = {
					cueList = {
						130121001
					}
				}
			},
			{
				unitDelay = 0.2,
				boxId = 1301209,
				flyCueId = 130120001,
				boxType = 1,
				eventType = 1,
				state = {
					duration = 3,
					stateId = 1301203
				},
				hitCue = {
					cueList = {
						130120002,
						130121002
					}
				}
			},
			[1001] = {
				targetChoose = 23,
				state = {
					duration = 3,
					stateId = 1301203
				}
			}
		}
	},
	[1301210] = {
		bhEvent = "skill.1301210",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1301211
					}
				},
				atkCue = {
					cueList = {
						130121003
					}
				}
			},
			{
				unitDelay = 0.1,
				boxId = 1301209,
				flyCueId = 130120014,
				boxType = 1,
				eventType = 1,
				state = {
					duration = 3,
					stateId = 1301203
				},
				hitCue = {
					cueList = {
						130120004,
						130121002
					}
				}
			}
		}
	},
	[1301229] = {
		bhEvent = "skill.1301229",
		atkEvents = {
			[100] = {
				state = {
					duration = 3,
					stateId = 1301203
				},
				atkCue = {
					cueList = {
						130120005,
						130120006,
						130121004
					}
				}
			},
			{
				unitDelay = 0.08,
				boxId = 1301229,
				flyCueId = 130120007,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130120008,
						130121005
					}
				},
				levelAtkEvents = {
					[2] = {
						stunTime = 1
					},
					[3] = {
						stunTime = 1
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				boxType = 1,
				delay = 0.5,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = -999,
							stateId = 1301201
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				state = {
					duration = -999,
					stateId = 1301203
				}
			},
			[1002] = {
				randomTargetNumber = 1,
				excludeTarget = 1,
				stunTime = 1,
				boxId = 1301230,
				targetChoose = 7,
				eventType = 1,
				state = {
					chooseStateMode = 2,
					chooseStateIds = {
						0
					}
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1301220
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1301212
				}
			},
			[1004] = {
				subEventId = 1005,
				subEventType = 1,
				subEventSkill = 1301229,
				state = {
					duration = 5,
					stateId = 1000001
				}
			},
			[1005] = {
				addManaNumber = 6,
				targetArea = 3,
				state = {}
			}
		}
	},
	[1301259] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 70,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 95,
		bhEvent = "skill.1301259",
		atkEvents = {
			[100] = {
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						130120009,
						130120012,
						130120010
					}
				}
			},
			[11] = {
				unitDelay = 0.1,
				boxId = 1301259,
				flyCueId = 130120013,
				boxType = 1,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[17] = {
				state = {},
				atkCue = {
					cueList = {
						130120021,
						130125001,
						130121007
					}
				}
			},
			[12] = {
				unitDelay = 0.1,
				boxId = 1301259,
				flyCueId = 130120014,
				boxType = 1,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[13] = {
				unitDelay = 0.1,
				boxId = 1301259,
				flyCueId = 130120015,
				boxType = 1,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[14] = {
				unitDelay = 0.1,
				boxType = 1,
				targetChoose = 23,
				state = {},
				hitCue = {
					cueList = {
						130120016,
						130120019
					}
				}
			},
			[1001] = {
				disablePassive = 1,
				boxType = 1,
				boxId = 1301260,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130120018
					}
				}
			},
			[1002] = {
				targetArea = 5,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1301202
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1301202
				}
			}
		},
		videoActCue = {
			cueList = {
				130128001,
				130121006
			}
		}
	},
	[1301260] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 70,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 103,
		bhEvent = "skill.1301260",
		atkEvents = {
			[100] = {
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						130120009,
						130120011,
						130120012
					}
				}
			},
			[11] = {
				unitDelay = 0.1,
				boxId = 1301259,
				flyCueId = 130120013,
				boxType = 1,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[17] = {
				state = {},
				atkCue = {
					cueList = {
						130120021,
						130125002,
						130121007
					}
				}
			},
			[14] = {
				unitDelay = 0.1,
				boxType = 1,
				targetChoose = 23,
				state = {},
				hitCue = {
					cueList = {
						130120020,
						130120017
					}
				}
			},
			[12] = {
				unitDelay = 0.1,
				boxId = 1301259,
				flyCueId = 130120014,
				boxType = 1,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[13] = {
				unitDelay = 0.1,
				boxId = 1301259,
				flyCueId = 130120015,
				boxType = 1,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			{
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1301202
				}
			}
		},
		videoActCue = {
			cueList = {
				130128001,
				130121006
			}
		}
	},
	[1301230] = {
		bhEvent = "skill.1301230",
		atkEvents = {
			[100] = {
				state = {
					duration = 3,
					stateId = 1301203
				},
				atkCue = {
					cueList = {
						130120005,
						130120006,
						130121004
					}
				}
			},
			{
				boxId = 1301229,
				unitDelay = 0.08,
				boxType = 1,
				eventType = 1,
				flyCueId = 130120007,
				targetChoose = 3,
				state = {},
				hitCue = {
					cueList = {
						130120008,
						130121005
					}
				},
				levelAtkEvents = {
					[2] = {
						stunTime = 1
					},
					[3] = {
						stunTime = 1
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				boxType = 1,
				delay = 0.5,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = -999,
							stateId = 1301201
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
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
