-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13015.lua

local Data = {
	cueFile = "13015",
	[1301509] = {
		bhEvent = "skill.1301509",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130150001,
						130150002,
						130150003,
						130150004,
						130151001
					}
				}
			},
			[0] = {
				delay = 0.16,
				boxId = 1301509,
				flyCueId = 130150006,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130150008,
						130151002
					}
				}
			}
		}
	},
	[1301559] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 46,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 40,
		actTime = 90,
		bhEvent = "skill.1301559",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130150018,
						130150019,
						130150020,
						130150015,
						130151009
					}
				}
			},
			{
				delay = 0.2,
				boxId = 1301559,
				flyCueId = 130150021,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130150022
					}
				}
			},
			[1001] = {
				targetChoose = 10,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 1301504,
					chooseStateMode = 2,
					chooseStateIds = {
						0
					}
				}
			},
			[1002] = {
				targetChoose = 23,
				state = {
					duration = -999,
					stateId = 1301502,
					chooseStateMode = 2,
					chooseStateIds = {
						0
					}
				},
				hitCue = {
					cueList = {
						130150014
					}
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1301503
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						130150023,
						130155001,
						130151007
					}
				}
			},
			[27] = {
				state = {},
				atkCue = {
					cueList = {
						130150017
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				130158001,
				130151006
			}
		}
	},
	[1301560] = {
		bhEvent = "skill.1301560",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130150016
					}
				}
			},
			{
				delay = 0.2,
				boxId = 1301560,
				flyCueId = 130150021,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130150022,
						130151008
					}
				}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 4,
					stateId = 1301503,
					chooseStateMode = 2,
					delLayer = 1,
					chooseStateIds = {
						1301503
					}
				}
			},
			[27] = {
				state = {},
				atkCue = {
					cueList = {
						130150017
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 4,
					stateId = 1301506
				}
			}
		}
	},
	[1301529] = {
		actTime = 55,
		bhEvent = "skill.1301529",
		atkEvents = {
			[10] = {
				state = {}
			},
			{
				targetChoose = 10,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 1301504
				}
			},
			[1001] = {
				delay = 0.5,
				boxId = 1301529,
				boxType = 1,
				targetChoose = 23,
				eventType = 1,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						subEventSkill = 1301529,
						subEventId = 1002
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1002] = {
				controlTime = 2,
				controlAniName = "freeze",
				eventCondition = "1,2,1000003",
				state = {
					chooseStateMode = 2,
					chooseStateIds = {
						0
					}
				}
			},
			{
				state = {
					duration = -999,
					stateId = 1301502
				},
				hitCue = {
					cueList = {
						130150014
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130150009,
						130150010,
						130150011,
						130150012,
						130151005
					}
				}
			},
			[1003] = {
				addManaNumber = 10,
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1301505
				}
			},
			{
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1301501
				}
			},
			[1004] = {
				subEventId = 1005,
				subEventSkill = 1301529,
				delay = 0.2,
				targetChoose = 23,
				state = {}
			},
			[1005] = {
				excludeTarget = 1,
				boxId = 1301530,
				delay = 0.6,
				boxType = 1,
				eventType = 1,
				subEventSkill = 1301529,
				subEventId = 1002,
				targetChoose = 4,
				state = {}
			},
			[1006] = {
				targetChoose = 23,
				state = {},
				hitCue = {
					cueList = {
						130150013
					}
				}
			},
			[1007] = {
				boxId = 1301531,
				targetChoose = 14,
				eventType = 1,
				state = {}
			},
			[1008] = {
				subEventId = 1009,
				targetArea = 3,
				subEventSkill = 1301529,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						21301521
					}
				}
			},
			[1009] = {
				targetArea = 3,
				eventProbId = 21301521,
				state = {
					duration = -999,
					stateId = 21301521
				}
			},
			[1010] = {
				boxId = 1301529,
				eventType = 1,
				state = {}
			},
			[1011] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						21301521
					}
				}
			}
		}
	},
	[1301510] = {
		bhEvent = "skill.1301510",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130150001,
						130150002,
						130150003,
						130150005,
						130151003
					}
				}
			},
			[0] = {
				unitDelay = 0.16,
				boxType = 1,
				flyCueId = 130150007,
				boxId = 1301509,
				state = {},
				hitCue = {
					cueList = {
						130150008,
						130151004
					}
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
