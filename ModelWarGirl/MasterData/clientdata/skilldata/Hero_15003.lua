-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_15003.lua

local Data = {
	cueFile = "15003",
	[1500309] = {
		bhEvent = "skill.1500309",
		atkEvents = {
			[0] = {
				unitDelay = 0.12,
				boxId = 1500309,
				flyCueId = 150030001,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						150030002,
						150031004
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						150030008
					}
				}
			}
		}
	},
	[1500310] = {
		bhEvent = "skill.1500310",
		atkEvents = {
			[0] = {
				unitDelay = 0.08,
				boxId = 1500309,
				flyCueId = 90010003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						150030001
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						150030008
					}
				}
			}
		}
	},
	[1500359] = {
		hideTime = 10,
		videoActTime = 39,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 60,
		bhEvent = "skill.1500359",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						150035001,
						150030005
					}
				}
			},
			[0] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1500301
				}
			},
			{
				targetArea = 3,
				boxId = 1500359,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						150030004,
						150031003
					}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 5,
							stateId = 1500302
						}
					},
					[3] = {
						state = {
							duration = 5,
							stateId = 1500302
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[99] = {
				state = {},
				atkCue = {
					cueList = {
						150030006,
						150030007
					}
				}
			},
			[1001] = {
				addManaNumber = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1500304
				}
			}
		},
		videoActCue = {
			cueList = {
				150038002,
				150031006
			}
		}
	},
	[1500329] = {
		actTime = 51,
		skillTarget = 1,
		bhEvent = "skill.1500329",
		atkEvents = {
			[100] = {
				targetChoose = 3,
				recordSkillTargets = 1,
				targetArea = 3,
				excludeTarget = 1,
				state = {},
				atkCue = {
					cueList = {
						150030009,
						150030010
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
				targetChoose = 12,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1500303
				},
				hitCue = {
					cueList = {
						150030003,
						150031005
					}
				}
			},
			[1001] = {
				boxId = 1500330,
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
