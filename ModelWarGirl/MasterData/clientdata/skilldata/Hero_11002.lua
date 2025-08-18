-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11002.lua

local Data = {
	cueFile = "11002",
	[1100201] = {
		bhEvent = "skill.1100201",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110020005,
						110021001
					}
				}
			},
			{
				boxId = 1100201,
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
	[1100202] = {
		bhEvent = "skill.1100202",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110020006,
						110021002
					}
				}
			},
			{
				boxId = 1100201,
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
	[1100221] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.1100221",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 1100205
				},
				atkCue = {
					cueList = {
						110020011,
						110021003
					}
				}
			},
			{
				targetArea = 2,
				boxId = 1100221,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000063
					}
				}
			},
			[1001] = {
				boxId = 1100222,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			[1002] = {
				unitDelay = 0.15,
				boxId = 1100223,
				flyCueId = 110020009,
				boxType = 1,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						110020010
					}
				},
				hitCue = {
					cueList = {
						10000063
					}
				}
			},
			[1003] = {
				boxId = 1100254,
				targetArea = 3,
				state = {}
			},
			[1004] = {
				targetArea = 2,
				boxId = 1100252,
				targetChoose = 3,
				excludeTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						10000063
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 1.1,
							stateId = 1100202
						}
					},
					[3] = {
						subEventId = 1003,
						subEventSkill = 1100221,
						state = {
							duration = 1.1,
							stateId = 1100202
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1005] = {
				targetChoose = 7,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						110020011
					}
				}
			},
			[1006] = {
				boxId = 1100224,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1007] = {
				randomTargetNumber = 1,
				targetArea = 3,
				boxId = 1100225,
				targetChoose = 10,
				excludeTarget = 1,
				state = {}
			}
		}
	},
	[1100251] = {
		hideEffect = 1,
		videoActTime = 55,
		skillTarget = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 90,
		bhEvent = "skill.1100251",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110020002
					}
				}
			},
			{
				boxId = 1100251,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 1100201
				}
			},
			[1001] = {
				targetArea = 2,
				boxId = 1100252,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000063
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 1.1,
							stateId = 1100202
						}
					},
					[3] = {
						subEventId = 1003,
						subEventSkill = 1100221,
						state = {
							duration = 1.1,
							stateId = 1100202
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1003] = {
				boxId = 1100254,
				targetArea = 3,
				state = {}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						110020012,
						110025001,
						110021006
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				110028001,
				110021004
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
