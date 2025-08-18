-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12203.lua

local Data = {
	cueFile = "12203",
	[1220301] = {
		bhEvent = "skill.1220301",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122030001,
						122031001
					}
				}
			},
			{
				boxId = 1220301,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						122030004
					}
				}
			}
		}
	},
	[1220302] = {
		bhEvent = "skill.1220302",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122030002,
						122031002
					}
				}
			},
			{
				boxId = 1220301,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						122030004
					}
				}
			}
		}
	},
	[1220303] = {
		bhEvent = "skill.1220303",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122030003,
						122030005,
						122031003
					}
				}
			},
			{
				boxId = 1220301,
				eventType = 1,
				state = {}
			}
		}
	},
	[1220321] = {
		bhEvent = "skill.1220321",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122030006,
						122031004
					}
				}
			},
			{
				boxId = 1220322,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						122030007
					}
				},
				levelAtkEvents = {
					[2] = {
						addManaNumber = -20
					},
					[3] = {
						addManaNumber = -20
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 5,
							stateId = 1220302
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				disablePassive = 1,
				boxType = 1,
				boxId = 1220321,
				delay = 0.2,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000041
					}
				}
			},
			[1002] = {
				disablePassive = 1,
				eventCondition = "1,1,82122030,1",
				boxId = 1220352,
				eventType = 1,
				state = {}
			},
			[1003] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1220307
					}
				}
			},
			[1004] = {
				boxId = 1220362,
				targetChoose = 23,
				eventType = 1,
				state = {}
			}
		}
	},
	[1220351] = {
		hideTime = 10,
		hideEvent = 1,
		videoActTime = 60,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 25,
		actTime = 90,
		bhEvent = "skill.1220351",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						122030009
					}
				}
			},
			{
				hitedAnim = "Hit",
				subEventSkill = 1220351,
				boxId = 1220351,
				subEventId = 1004,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 1220304
				},
				hitCue = {
					cueList = {
						122033001,
						122030014
					}
				}
			},
			{
				subEventId = 1005,
				targetArea = 3,
				subEventSkill = 1220351,
				state = {
					duration = 5,
					stateId = 1220305
				}
			},
			[1001] = {
				boxId = 1220360,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			},
			[1002] = {
				boxId = 1220352,
				disablePassive = 1,
				eventType = 1,
				state = {}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						122030012,
						122035001,
						122031006
					}
				}
			},
			[99] = {
				hitedAnim = "end",
				state = {}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1220306
				}
			},
			[1004] = {
				state = {
					duration = 5,
					stateId = 1220306
				}
			},
			[1005] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1220307
				}
			}
		},
		videoActCue = {
			cueList = {
				122038001,
				122031005
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
