-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12207.lua

local Data = {
	cueFile = "12207",
	[1220709] = {
		bhEvent = "skill.1220709",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122070001,
						122070012,
						122071001
					}
				}
			},
			{
				boxId = 1220709,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						122070002
					}
				}
			}
		}
	},
	[1220710] = {
		bhEvent = "skill.1220710",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122070003,
						122070012,
						122071002
					}
				}
			},
			{
				boxId = 1220709,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						122070004
					}
				}
			}
		}
	},
	[1220729] = {
		bhEvent = "skill.1220729",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122070005,
						122070013,
						122070001
					}
				}
			},
			{
				boxId = 1220710,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						122070006
					}
				}
			},
			[1001] = {
				boxId = 1220729,
				disablePassive = 1,
				eventType = 1,
				state = {}
			},
			[1002] = {
				targetChoose = 10,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 1220705
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 1220706
				}
			},
			[1004] = {
				boxId = 1220730,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1005] = {
				boxType = 1,
				eventCondition = "isPvp",
				stunTime = 5,
				delay = 0.2,
				state = {}
			},
			[1006] = {
				eventCondition = "isPvp",
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1220704
					}
				}
			},
			[1007] = {
				boxId = 1220731,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[1008] = {
				boxId = 1220732,
				targetArea = 3,
				state = {}
			},
			[1009] = {
				addManaNumber = 10,
				targetArea = 3,
				state = {}
			},
			[1010] = {
				disablePassive = 1,
				boxId = 1220733,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[1011] = {
				targetChoose = 23,
				state = {
					duration = 5,
					stateId = 1220703
				}
			},
			[1012] = {
				boxId = 1220734,
				targetArea = 3,
				state = {}
			},
			[1013] = {
				eventCondition = "isPvp",
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1220715
					}
				}
			}
		}
	},
	[1220759] = {
		hideEffect = 1,
		actTime = 115,
		videoActTime = 53,
		hideTime = 10,
		hideEvent = 100,
		bhEvent = "skill.1220759",
		atkEvents = {
			[100] = {
				state = {}
			},
			[12] = {
				state = {},
				atkCue = {
					cueList = {
						122070007,
						122070011,
						122075001,
						122070014,
						122071005
					}
				}
			},
			[15] = {
				targetChoose = 23,
				state = {},
				hitCue = {
					cueList = {
						122070008
					}
				}
			},
			[16] = {
				state = {},
				atkCue = {
					cueList = {
						122070009
					}
				}
			},
			{
				hitedAnim = "Hit",
				state = {},
				hitCue = {
					cueList = {
						122070010
					}
				}
			},
			{
				hitedAnim = "Hit",
				state = {},
				hitCue = {
					cueList = {
						122070010
					}
				}
			},
			{
				subEventSkill = 1220759,
				boxId = 1220759,
				hitedAnim = "Hit",
				subEventId = 1002,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						122073001
					}
				},
				hitCue = {
					cueList = {
						122070010
					}
				}
			},
			[99] = {
				hitedAnim = "end",
				state = {}
			},
			{
				subEventId = 1001,
				subEventSkill = 1220759,
				boxId = 1220762,
				targetArea = 3,
				state = {}
			},
			[1001] = {
				boxId = 1220761,
				targetArea = 3,
				state = {}
			},
			[1002] = {
				eventType = 1,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1220760
					},
					[3] = {
						boxId = 1220760
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		},
		videoActCue = {
			cueList = {
				122078001,
				122071004
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
