-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14105.lua

local Data = {
	cueFile = "14105",
	[1410509] = {
		bhEvent = "skill.1410509",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						141050001
					}
				}
			},
			{
				unitDelay = 0.2,
				boxId = 1410509,
				flyCueId = 141050003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						141050004
					}
				}
			},
			{
				state = {}
			}
		}
	},
	[1410510] = {
		bhEvent = "skill.1410510",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						141050002
					}
				}
			},
			{
				unitDelay = 0.2,
				boxId = 1410509,
				flyCueId = 141050003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						141050004
					}
				}
			}
		}
	},
	[1410529] = {
		actTime = 58,
		bhEvent = "skill.1410529",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						141050005,
						141050008
					}
				}
			},
			[1002] = {
				subEventType = 1,
				boxId = 1410529,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						141050010
					}
				}
			},
			[1003] = {
				subEventType = 1,
				targetChoose = 3,
				eventType = 1,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						boxId = 1410530,
						eventCondition = "1,2,1410501,1"
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1005] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = -999,
							stateId = 1410503
						}
					},
					[3] = {
						state = {
							duration = -999,
							stateId = 1410503
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				unitDelay = 0.2,
				flyCueId = 141050006,
				boxType = 1,
				targetChoose = 23,
				state = {
					duration = -999,
					stateId = 1410501
				},
				hitCue = {
					cueList = {
						141050007
					}
				}
			}
		}
	},
	[1410559] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 40,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 20,
		actTime = 96,
		bhEvent = "skill.1410559",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						141050011,
						141050012,
						141050013
					}
				}
			},
			{
				unitDelay = 0.2,
				boxId = 1410559,
				flyCueId = 141050014,
				boxType = 1,
				targetChoose = 3,
				eventType = 1,
				state = {
					duration = 8,
					stateId = 1000001
				},
				hitCue = {
					cueList = {
						141050015,
						141050016,
						141053001
					}
				}
			},
			{
				subEventId = 1002,
				subEventSkill = 1410559,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1410501
					}
				}
			},
			{
				excludeTarget = 1,
				targetChoose = 3,
				state = {
					duration = -999,
					stateId = 1410501
				}
			},
			{
				targetChoose = 10,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 3,
							stateId = 1410504
						}
					},
					[3] = {
						state = {
							duration = 3,
							stateId = 1410504
						}
					},
					[4] = {
						state = {
							duration = 3,
							stateId = 1410504
						}
					},
					[5] = {},
					[6] = {}
				}
			},
			[6] = {
				targetChoose = 23,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						eventCondition = "1,2,1000001",
						subEventSkill = 1410559,
						subEventId = 1001
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1410505
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1410505
					}
				}
			},
			[1003] = {
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						stunTime = 3,
						eventCondition = "1,2,1000001"
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				state = {}
			},
			[1004] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1410506
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						141050017,
						141055001
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				141058001
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
