-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11203.lua

local Data = {
	cueFile = "11203",
	[1120302] = {
		bhEvent = "skill.1120302",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						112030004,
						112030005,
						112031003
					}
				}
			},
			{
				boxId = 1120321,
				eventType = 1,
				state = {},
				levelAtkEvents = {
					[2] = {
						controlTime = 2,
						controlAniName = "Float"
					},
					[3] = {
						controlTime = 2,
						controlAniName = "Float"
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		}
	},
	[1120311] = {
		actTime = 43,
		skillTarget = 1,
		bhEvent = "skill.1120311",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						112030006
					}
				}
			},
			[1001] = {
				boxId = 1120330,
				targetArea = 3,
				state = {
					stateId = 1120301,
					stateOperation = 4,
					delLayer = 1
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1120302
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120301,
					delLayer = 1
				}
			},
			[2] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1120301,
						1120303,
						1120304,
						1120306,
						1120308
					}
				}
			},
			[3] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120322
				}
			},
			{
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120321
				}
			},
			[1004] = {
				targetArea = 4,
				state = {
					stateId = 1120305,
					stateOperation = 4,
					delLayer = 1
				}
			},
			[1005] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120305
				}
			},
			[5] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120307
				}
			},
			[6] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						112036001
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 8,
							stateId = 1120312
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1006] = {
				boxId = 1120331,
				targetArea = 3,
				state = {}
			}
		}
	},
	[1120309] = {
		bhEvent = "skill.1120309",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						112030003,
						112031002
					}
				}
			},
			{
				boxId = 1120309,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			}
		}
	},
	[1120310] = {
		bhEvent = "skill.1120310",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						112030001,
						112030002,
						112031001
					}
				}
			},
			{
				boxId = 1120309,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			}
		}
	},
	[1120359] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 60,
		prepareCamera = 1,
		prepareCamDruation = 40,
		actTime = 65,
		bhEvent = "skill.1120359",
		atkEvents = {
			{
				hitedAnim = "Hit",
				boxId = 1120359,
				targetChoose = 4,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						112030013
					}
				}
			},
			{
				boxId = 1120356,
				targetArea = 3,
				state = {}
			},
			[99] = {
				hitedAnim = "end",
				state = {}
			},
			{
				targetChoose = 4,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						boxId = 1120357
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				addManaNumber = 30,
				targetArea = 3,
				state = {}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						112030015,
						112035002,
						112031007
					}
				}
			},
			[100] = {
				targetChoose = 4,
				state = {},
				atkCue = {
					cueList = {
						112030011,
						112030012
					}
				}
			},
			{
				boxId = 1120358,
				targetArea = 3,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				112038001,
				112031004
			}
		}
	},
	[1120360] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 60,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 50,
		actTime = 65,
		bhEvent = "skill.1120360",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						112030008,
						112030009
					}
				}
			},
			{
				hitedAnim = "Hit",
				boxId = 1120360,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						112030010
					}
				}
			},
			[1001] = {
				boxId = 1120362,
				targetArea = 3,
				state = {
					chooseStateMode = 2
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						112030014,
						112035001,
						112031005
					}
				}
			},
			[99] = {
				hitedAnim = "end",
				state = {}
			},
			[3] = {
				boxId = 1120360,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						112030010,
						112031006
					}
				}
			},
			{
				boxId = 1120361,
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 1120311
				}
			}
		},
		videoActCue = {
			cueList = {
				112038001,
				112031004
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
