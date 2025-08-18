-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_15006.lua

local Data = {
	cueFile = "15006",
	[1500609] = {
		bhEvent = "skill.1500609",
		atkEvents = {
			[0] = {
				unitDelay = 0.12,
				boxId = 1500609,
				flyCueId = 150060002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						150060003,
						150061002
					}
				}
			},
			[1001] = {
				targetArea = 3,
				addManaNumber = 10,
				state = {},
				hitCue = {
					cueList = {
						10000035
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						150061001
					}
				}
			}
		}
	},
	[1500659] = {
		hideTime = 10,
		videoActTime = 70,
		hideEffect = 1,
		skillTarget = 1,
		prepareCamera = 1,
		prepareCamDruation = 40,
		actTime = 61,
		bhEvent = "skill.1500659",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						150060006,
						150060007
					}
				}
			},
			[0] = {
				targetArea = 3,
				boxId = 1500660,
				targetChoose = 10,
				state = {
					duration = 5,
					stateId = 1500601
				},
				hitCue = {
					cueList = {
						150060008,
						150061007
					}
				}
			},
			{
				targetChoose = 7,
				targetArea = 2,
				state = {
					duration = 5,
					stateId = 1000001
				}
			},
			[11] = {
				state = {},
				atkCue = {
					cueList = {
						150065001,
						150060009,
						150061006
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				150068001,
				150061005
			}
		}
	},
	[1500629] = {
		actTime = 40,
		skillTarget = 1,
		bhEvent = "skill.1500629",
		atkEvents = {
			[100] = {
				targetChoose = 3,
				recordSkillTargets = 1,
				targetArea = 3,
				excludeTarget = 1,
				state = {},
				atkCue = {
					cueList = {
						150060004,
						150061003
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						targetChoose = 7
					},
					[4] = {
						targetChoose = 4
					},
					[5] = {
						targetChoose = 4
					},
					[6] = {
						targetChoose = 4
					}
				}
			},
			{
				targetChoose = 4,
				targetArea = 3,
				excludeTarget = 1,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = -999,
							stateId = 1500603
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[0] = {
				targetChoose = 12,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1500602
				},
				hitCue = {
					cueList = {
						150060005,
						150061004
					}
				}
			},
			[1001] = {
				targetChoose = 10,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 1500605
				}
			},
			[1002] = {
				targetChoose = 9,
				targetArea = 3,
				state = {
					duration = 1.1,
					stateId = 1500608
				}
			},
			[1003] = {
				targetChoose = 18,
				targetArea = 3,
				state = {
					duration = 1.1,
					stateId = 1500609
				}
			},
			[1004] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 82150062
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
