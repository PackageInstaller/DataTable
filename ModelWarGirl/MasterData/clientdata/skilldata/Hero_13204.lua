-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13204.lua

local Data = {
	cueFile = "13204",
	[1320409] = {
		bhEvent = "skill.1320409",
		atkEvents = {
			[100] = {
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						132040006,
						132041001
					}
				}
			},
			[0] = {
				state = {}
			},
			{
				unitDelay = 0.12,
				boxId = 1320409,
				flyCueId = 132040008,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						132040009,
						132041003
					}
				}
			}
		}
	},
	[1320429] = {
		bhEvent = "skill.1320429",
		atkEvents = {
			[100] = {
				targetArea = 1,
				state = {},
				atkCue = {
					cueList = {
						132040004,
						132041004
					}
				}
			},
			{
				boxId = 1320429,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						132041005
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1320401
				}
			},
			[1002] = {
				controlTime = 2,
				controlAniName = "freeze",
				eventType = 1,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1320431
					},
					[3] = {
						boxId = 1320431
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1003] = {
				boxId = 1320430,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						132040017
					}
				}
			},
			[11] = {
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						132040005
					}
				}
			},
			[1004] = {
				boxId = 1320432,
				eventType = 1,
				state = {}
			},
			[1005] = {
				subEventSkill = 1320429,
				targetChoose = 23,
				subRandomNum = 1,
				subRandomEvents = "1006,1007,1008",
				state = {}
			},
			[1006] = {
				targetChoose = 23,
				state = {
					duration = 5,
					stateId = 1000001
				}
			},
			[1007] = {
				targetChoose = 23,
				state = {
					duration = 5,
					stateId = 1000003
				}
			},
			[1008] = {
				targetChoose = 23,
				state = {
					duration = 5,
					stateId = 1000013
				}
			},
			[1009] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1320408
				}
			},
			[1010] = {
				boxId = 1320433,
				eventType = 1,
				state = {}
			}
		}
	},
	[1320459] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 30,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 25,
		actTime = 85,
		bhEvent = "skill.1320459",
		atkEvents = {
			{
				boxId = 1320459,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						132040015,
						132043001,
						132041008
					}
				}
			},
			{
				subEventId = 1001,
				subEventSkill = 1320459,
				eventCondition = "1,1,1320402",
				state = {},
				hitCue = {
					cueList = {
						132040018
					}
				}
			},
			{
				subEventId = 1002,
				subEventSkill = 1320459,
				eventCondition = "1,1,1320403",
				state = {},
				hitCue = {
					cueList = {
						132040016
					}
				}
			},
			{
				subEventId = 1003,
				subEventSkill = 1320459,
				eventCondition = "1,1,1320404",
				state = {},
				hitCue = {
					cueList = {
						132040018
					}
				}
			},
			[1001] = {
				boxId = 1320460,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						132040018
					}
				}
			},
			[1002] = {
				subEventType = 1,
				boxId = 1320461,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						132040016
					}
				}
			},
			[1003] = {
				boxId = 1320462,
				targetChoose = 7,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 1320405
				},
				hitCue = {
					cueList = {
						132040017
					}
				}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1320402,
						1320403,
						1320404,
						1320411,
						1320412,
						1320413
					}
				}
			},
			[100] = {
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						132040011,
						132040012,
						132040013,
						132040014
					}
				}
			},
			[11] = {
				state = {},
				atkCue = {
					cueList = {
						132040019,
						132045001,
						132041007
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				132048001,
				132041006
			}
		}
	},
	[1320410] = {
		bhEvent = "skill.1320410",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						132040007,
						132041002
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 1320409,
				flyCueId = 132040008,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						132040010,
						132041003
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
