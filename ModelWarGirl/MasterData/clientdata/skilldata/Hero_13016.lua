-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13016.lua

local Data = {
	cueFile = "13016",
	[1301609] = {
		bhEvent = "skill.1301609",
		atkEvents = {
			[1001] = {
				state = {}
			},
			{
				delay = 0.3,
				boxId = 1301609,
				flyCueId = 130160008,
				boxType = 1,
				targetChoose = 23,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130160009,
						130161003
					}
				}
			},
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						130160006,
						130161001
					}
				}
			}
		}
	},
	[1301610] = {
		bhEvent = "skill.1301610",
		atkEvents = {
			{
				delay = 0.3,
				boxId = 1301609,
				flyCueId = 130160008,
				boxType = 1,
				targetChoose = 23,
				state = {},
				hitCue = {
					cueList = {
						130160009,
						130161003
					}
				}
			},
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						130160007,
						130161002
					}
				}
			}
		}
	},
	[1301629] = {
		bhEvent = "skill.1301629",
		atkEvents = {
			{
				subEventId = 1001,
				subEventSkill = 1301629,
				boxId = 1301629,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130160004
					}
				}
			},
			[1001] = {
				targetChoose = 23,
				state = {},
				levelAtkEvents = {
					[2] = {
						eventCondition = "1,2,1000001",
						subEventSkill = 1301629,
						subEventId = 1002
					},
					[3] = {
						eventCondition = "1,2,1000001",
						subEventSkill = 1301629,
						subEventId = 1002
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1002] = {
				addManaNumber = 10,
				targetArea = 3,
				state = {}
			},
			[1003] = {
				boxId = 1301629,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[11] = {
				state = {},
				hitCue = {
					cueList = {
						130160005,
						130161005
					}
				}
			},
			[1004] = {
				subEventId = 1005,
				targetArea = 3,
				subEventSkill = 1301629,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1301601
					}
				}
			},
			[1005] = {
				subEventId = 1006,
				subEventSkill = 1301629,
				targetChoose = 10,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						targetChoose = 7
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1006] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1301601
				}
			},
			[1007] = {
				targetChoose = 10,
				subEventId = 1008,
				subEventSkill = 1301629,
				targetArea = 3,
				state = {}
			},
			[1008] = {
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 1301603
				}
			},
			[1009] = {
				delay = 0.6,
				boxId = 1301630,
				boxType = 1,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[1010] = {
				targetArea = 3,
				boxId = 1301631,
				targetChoose = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			}
		}
	},
	[1301659] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 35,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 40,
		actTime = 88,
		bhEvent = "skill.1301659",
		atkEvents = {
			{
				randomTargetNumber = 1,
				boxId = 1301659,
				targetChoose = 3,
				eventType = 1,
				state = {},
				levelAtkEvents = {
					[2] = {
						subEventSkill = 1301659,
						subEventId = 1001
					},
					[3] = {
						subEventSkill = 1301659,
						subEventId = 1001
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[100] = {
				targetChoose = 3,
				state = {},
				atkCue = {
					cueList = {
						130160001,
						130160002
					}
				}
			},
			[13] = {
				targetChoose = 3,
				state = {},
				atkCue = {
					cueList = {
						130160011,
						130165001,
						130161007
					}
				}
			},
			[11] = {
				state = {},
				hitCue = {
					cueList = {
						130160003
					}
				}
			},
			[14] = {
				state = {},
				atkCue = {
					cueList = {
						130163001,
						130161008
					}
				}
			},
			{
				randomTargetNumber = 1,
				targetChoose = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						boxId = 1301659,
						subEventId = 1001,
						subEventSkill = 1301659,
						eventType = 1
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				disablePassive = 1,
				boxId = 1301660,
				delay = 0.1,
				boxType = 1,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1002] = {
				subEventId = 1003,
				targetChoose = 23,
				subEventSkill = 1301659,
				state = {}
			},
			[1003] = {
				targetChoose = 3,
				state = {
					duration = 5,
					stateId = 1000001
				}
			},
			[1004] = {
				subEventId = 1005,
				targetChoose = 7,
				subEventSkill = 1301659,
				state = {}
			},
			[1005] = {
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 21301611
				}
			},
			[1006] = {
				targetChoose = 3,
				state = {
					duration = 5,
					stateId = 1000001
				}
			}
		},
		videoActCue = {
			cueList = {
				130168001,
				130160001
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
