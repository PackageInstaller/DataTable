-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11013.lua

local Data = {
	cueFile = "11013",
	[1101309] = {
		bhEvent = "skill.1101309",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110130001,
						110131001
					}
				}
			},
			[0] = {
				boxId = 1101309,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110130002
					}
				}
			}
		}
	},
	[1101310] = {
		bhEvent = "skill.1101310",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110130003,
						110131002
					}
				}
			},
			[0] = {
				boxId = 1101309,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110130004
					}
				}
			}
		}
	},
	[1101329] = {
		actTime = 45,
		bhEvent = "skill.1101329",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110130005,
						110131003
					}
				}
			},
			{
				state = {},
				atkCue = {
					cueList = {
						110130008
					}
				}
			},
			{
				targetChoose = 19,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1101302
				}
			},
			[1001] = {
				eventCondition = "1,1,1101304,1",
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1101303
				}
			},
			{
				targetChoose = 10,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = -999,
							stateId = 1101307
						}
					},
					[3] = {
						state = {
							duration = -999,
							stateId = 1101307
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1002] = {
				targetChoose = 23,
				state = {
					duration = 1.2,
					stateId = 1101306
				}
			},
			[1003] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 1101309
				}
			},
			[1004] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1101314
				}
			},
			[1005] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1101320
				}
			},
			[1006] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1101330
				}
			},
			[1007] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8791651
				}
			},
			[1008] = {
				targetChoose = 10,
				targetArea = 3,
				addManaNumber = 20,
				state = {}
			},
			[1009] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 21101321
				}
			},
			[1010] = {
				addManaNumber = 25,
				targetArea = 3,
				state = {}
			}
		}
	},
	[1101359] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 55,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 20,
		actTime = 95,
		bhEvent = "skill.1101359",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110130011,
						110130012,
						110130013
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						110130014,
						110135001,
						110131005
					}
				}
			},
			[90] = {
				hitedAnim = "Hit",
				state = {}
			},
			[99] = {
				hitedAnim = "end",
				state = {}
			},
			{
				targetArea = 3,
				eventCondition = "1,2,1101301",
				boxId = 1101360,
				targetChoose = 10,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			{
				boxId = 1101359,
				eventType = 1,
				state = {}
			},
			[1001] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1101312
				}
			}
		},
		videoActCue = {
			cueList = {
				110138001,
				110131004
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
