-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12206.lua

local Data = {
	cueFile = "12206",
	[1220609] = {
		bhEvent = "skill.1220609",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122060001,
						122061001
					}
				}
			},
			{
				boxId = 1220609,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						122060003
					}
				}
			}
		}
	},
	[1220610] = {
		bhEvent = "skill.1220610",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122060002,
						122061002
					}
				}
			},
			{
				boxId = 1220609,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						122060003
					}
				}
			}
		}
	},
	[1220629] = {
		bhEvent = "skill.1220629",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122060004,
						122061003
					}
				}
			},
			[2] = {
				state = {},
				hitCue = {
					cueList = {
						122060005
					}
				}
			},
			{
				boxId = 1220659,
				eventType = 1,
				state = {}
			},
			[1001] = {
				targetChoose = 10,
				excludeTarget = 1,
				targetArea = 3,
				eventType = 1,
				state = {
					duration = -999,
					stateId = 1220601
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = 2,
					stateOperation = 2,
					chooseStateMode = 2,
					chooseStateIds = {
						1220604
					}
				}
			},
			[3] = {
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						boxType = 1,
						delay = 0.15,
						boxId = 1220661,
						eventType = 1
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		}
	},
	[1220659] = {
		hideEffect = 1,
		actTime = 83,
		videoActTime = 70,
		hideTime = 10,
		hideEvent = 100,
		bhEvent = "skill.1220659",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122060006,
						122060007
					}
				}
			},
			[21] = {
				state = {},
				hitCue = {
					cueList = {
						122060008
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						122060010,
						122065001,
						122061005
					}
				}
			},
			[99] = {
				hitedAnim = "end",
				state = {}
			},
			[22] = {
				targetArea = 3,
				state = {
					duration = 6,
					stateId = 1220651
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 6,
					stateId = 1220604
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 3.1,
							stateId = 1220606
						}
					},
					[3] = {
						state = {
							duration = 3.1,
							stateId = 1220606
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				subEventId = 1002,
				subEventSkill = 1220659,
				boxId = 1220660,
				targetArea = 3,
				state = {}
			},
			[1002] = {
				targetArea = 3,
				state = {}
			},
			{
				boxId = 1220662,
				eventType = 1,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 5,
							stateId = 1000003
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[23] = {
				hitedAnim = "Hit",
				state = {}
			},
			[1003] = {
				controlTime = 2,
				controlAniName = "freeze",
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				122068001,
				122061004
			}
		}
	},
	[1220630] = {
		bhEvent = "skill.1220630",
		atkEvents = {
			[100] = {
				state = {}
			},
			{
				state = {}
			},
			[1001] = {
				delay = 0.1,
				boxId = 1220630,
				boxType = 1,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1002] = {
				boxType = 1,
				delay = 0.1,
				boxId = 1220629,
				targetArea = 3,
				state = {}
			},
			{
				state = {}
			},
			{
				state = {}
			},
			[1003] = {
				randomTargetNumber = 1,
				boxId = 1220631,
				delay = 0.25,
				boxType = 1,
				targetChoose = 3,
				excludeTarget = 1,
				eventType = 1,
				state = {}
			},
			[1004] = {
				boxId = 1220632,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1005] = {
				boxId = 1220633,
				targetChoose = 4,
				eventType = 1,
				state = {}
			},
			[1006] = {
				subEventId = 1007,
				subEventType = 1,
				subEventSkill = 1220630,
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 1220609
				}
			},
			[1007] = {
				controlTime = 2,
				targetChoose = 23,
				controlAniName = "freeze",
				state = {}
			},
			[1008] = {
				boxId = 1220635,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1009] = {
				boxId = 1220634,
				targetChoose = 23,
				eventType = 1,
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
