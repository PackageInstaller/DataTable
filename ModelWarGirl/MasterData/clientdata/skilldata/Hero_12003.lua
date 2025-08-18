-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12003.lua

local Data = {
	cueFile = "12003",
	[1200309] = {
		bhEvent = "skill.1200309",
		atkEvents = {
			{
				boxId = 1200309,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120030008,
						120030009
					}
				}
			}
		}
	},
	[1200310] = {
		bhEvent = "skill.1200310",
		atkEvents = {
			{
				boxId = 1200309,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120030010,
						120030011
					}
				}
			}
		}
	},
	[1200359] = {
		hideTime = 10,
		hideEvent = 1,
		videoActTime = 60,
		hideEffect = 1,
		skillTarget = 2,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 60,
		bhEvent = "skill.1200359",
		atkEvents = {
			{
				hitedAnim = "Hit",
				boxId = 1200359,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						120031002,
						120033001
					}
				},
				hitCue = {
					cueList = {
						120030002,
						120031003,
						10006003
					}
				}
			},
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						120030005,
						120030006,
						120030007
					}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = -999,
							stateId = 1200301
						}
					},
					[3] = {
						state = {
							duration = -999,
							stateId = 1200301
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[11] = {
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 1200303
				},
				atkCue = {
					cueList = {
						120035001,
						120030003
					}
				}
			},
			[1001] = {
				disablePassive = 1,
				boxType = 1,
				boxId = 1200360,
				delay = 0.25,
				state = {},
				hitCue = {
					cueList = {
						10000078
					}
				}
			},
			[1002] = {
				targetArea = 3,
				addManaNumber = 10,
				state = {},
				hitCue = {
					cueList = {
						10000035
					}
				}
			},
			[90] = {
				hitedAnim = "end",
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				120038002,
				120031005
			}
		}
	},
	[1200329] = {
		skillTarget = 2,
		bhEvent = "skill.1200329",
		atkEvents = {
			{
				boxId = 1200329,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120030001,
						120031004
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1200302
				}
			},
			[1001] = {
				controlTime = 2,
				controlAniName = "Float",
				subEventSkill = 1200329,
				subEventId = 1002,
				state = {}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120030014
					}
				}
			},
			[1002] = {
				controlTime = 2,
				controlAniName = "Float",
				eventCondition = "1,1,1200306",
				targetChoose = 20,
				excludeTarget = 1,
				state = {}
			},
			[1003] = {
				boxId = 1200330,
				targetChoose = 9,
				eventType = 1,
				state = {}
			}
		}
	},
	[1200311] = {
		bhEvent = "skill.1200311",
		atkEvents = {
			[10] = {
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 1200305
				}
			},
			{
				boxId = 1200309,
				eventType = 1,
				state = {}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1200304
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120030004,
						120030013
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
