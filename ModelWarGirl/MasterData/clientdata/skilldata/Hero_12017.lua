-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12017.lua

local Data = {
	cueFile = "12017",
	[1201709] = {
		bhEvent = "skill.1201709",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120170001,
						120171001
					}
				}
			},
			{
				subEventId = 1005,
				subEventSkill = 1201709,
				boxId = 1201709,
				eventCondition = "1,1,1201704,1",
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120170002
					}
				}
			},
			[1001] = {
				subEventId = 1003,
				subEventSkill = 1201709,
				boxId = 1201710,
				targetChoose = 23,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 1000003
				},
				hitCue = {
					cueList = {
						120170004
					}
				}
			},
			[1002] = {
				subEventId = 1004,
				subEventSkill = 1201709,
				boxId = 1201720,
				targetChoose = 23,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 1000003
				},
				hitCue = {
					cueList = {
						120170004
					}
				}
			},
			[1003] = {
				eventCondition = "1,1,1201703",
				boxId = 1201710,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1004] = {
				eventCondition = "1,1,1201703",
				boxId = 1201720,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			{
				subEventId = 1006,
				subEventSkill = 1201709,
				boxId = 1201719,
				eventCondition = "1,1,1201704",
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120170002
					}
				}
			},
			[1005] = {
				eventCondition = "1,1,1201703",
				boxId = 1201709,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1006] = {
				boxId = 1201719,
				eventCondition = "1,1,1201703",
				eventType = 1,
				state = {}
			}
		}
	},
	[1201710] = {
		bhEvent = "skill.1201710",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120170003,
						120171002
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1201705
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1201707
				}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1201707,
						8791721
					}
				}
			}
		}
	},
	[1201729] = {
		bhEvent = "skill.1201729",
		atkEvents = {
			[100] = {
				state = {}
			},
			[1001] = {
				subEventId = 1002,
				eventCondition = "1,2,1000003",
				subEventSkill = 1201729,
				targetChoose = 23,
				state = {}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = 1.1,
					stateId = 1201704
				}
			},
			[1003] = {
				boxId = 1201715,
				targetArea = 3,
				state = {}
			},
			[1004] = {
				eventCondition = "1,1,1201701",
				targetArea = 3,
				state = {
					duration = 1.1,
					stateId = 1201703
				}
			},
			[1005] = {
				addManaNumber = 8,
				targetArea = 3,
				state = {}
			},
			[1006] = {
				subEventId = 1007,
				subEventSkill = 1201729,
				state = {
					duration = 3,
					stateId = 1000003
				}
			},
			[1007] = {
				targetArea = 3,
				state = {
					duration = 1.5,
					stateId = 21201721
				}
			}
		}
	},
	[1201759] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 32,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 20,
		actTime = 100,
		bhEvent = "skill.1201759",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120170007,
						120171005
					}
				}
			},
			{
				boxId = 1201759,
				targetChoose = 23,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120173001,
						120171006
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						controlTime = 3,
						controlAniName = "freeze",
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
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 5,
							stateId = 1201701
						}
					},
					[3] = {
						state = {
							duration = 5,
							stateId = 1201701
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1201707
				}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1201707
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						120175001,
						120170010
					}
				}
			},
			[11] = {
				state = {},
				hitCue = {
					cueList = {
						120170008
					}
				}
			},
			[12] = {
				state = {},
				hitCue = {
					cueList = {
						120170009
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				120178001,
				120171004
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
