-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14021.lua

local Data = {
	cueFile = "14021",
	[1402109] = {
		bhEvent = "skill.1402109",
		atkEvents = {
			{
				unitDelay = 0.1,
				boxId = 1402109,
				flyCueId = 140210015,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140210004,
						140211002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140210001,
						140210003,
						140211001
					}
				}
			}
		}
	},
	[1402110] = {
		bhEvent = "skill.1402110",
		atkEvents = {
			{
				unitDelay = 0.1,
				boxId = 1402109,
				flyCueId = 140210015,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140210004,
						140211004
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140210002,
						140210003,
						140211003
					}
				}
			}
		}
	},
	[1402129] = {
		bhEvent = "skill.1402129",
		atkEvents = {
			{
				targetArea = 3,
				eventProbId = 1402101,
				state = {
					duration = 1,
					stateId = 1402101
				}
			},
			{
				eventCondition = "1,1,1402101",
				state = {
					duration = 5,
					stateId = 1000001
				}
			},
			{
				eventCondition = "1,1,1402101,1",
				state = {
					duration = 5,
					stateId = 1000003
				},
				levelAtkEvents = {
					[2] = {
						eventCondition = "1,1,1402101"
					},
					[3] = {
						eventCondition = "1,1,1402101"
					},
					[4] = {
						eventCondition = "1,1,1402101"
					},
					[5] = {
						eventCondition = "1,1,1402101"
					},
					[6] = {}
				}
			},
			{
				unitDelay = 0.1,
				boxId = 1402129,
				flyCueId = 140210006,
				boxType = 1,
				eventCondition = "1,1,1402101",
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140210009,
						140211006
					}
				}
			},
			{
				boxId = 1402130,
				unitDelay = 0.1,
				eventCondition = "1,1,1402101,1",
				boxType = 1,
				eventType = 1,
				flyCueId = 140210006,
				state = {},
				hitCue = {
					cueList = {
						140210009,
						140211006
					}
				},
				levelAtkEvents = {
					[2] = {
						eventCondition = "1,1,1402101"
					},
					[3] = {
						eventCondition = "1,1,1402101"
					},
					[4] = {
						eventCondition = "1,1,1402101"
					},
					[5] = {
						eventCondition = "1,1,1402101"
					},
					[6] = {}
				}
			},
			[1001] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1402102
				}
			},
			[1002] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1402103
				}
			},
			[1003] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 82140211
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140210005,
						140211005
					}
				}
			},
			[1004] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1402104
				}
			},
			[1005] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1402105
				}
			},
			[1006] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1402106
				}
			},
			[1007] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1402107
				}
			},
			[1008] = {
				boxId = 1402131,
				targetArea = 3,
				targetChoose = 10,
				state = {}
			},
			[1009] = {
				targetChoose = 3,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 21402131
				}
			},
			[1010] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8791683
				}
			},
			[1011] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1402122
					}
				}
			}
		}
	},
	[1402159] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 20,
		prepareCamera = 1,
		prepareCamDruation = 25,
		actTime = 135,
		bhEvent = "skill.1402159",
		atkEvents = {
			{
				boxId = 1402159,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140210013,
						140211009
					}
				}
			},
			{
				boxId = 1402160,
				eventCondition = "1,2,1000003",
				eventType = 1,
				state = {}
			},
			{
				boxId = 1402161,
				eventCondition = "1,2,1000001",
				eventType = 1,
				state = {}
			},
			[1001] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1402112
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140210011
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						140210014,
						140215001,
						140211008
					}
				},
				hitCue = {
					cueList = {
						140210012
					}
				}
			},
			[1002] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 21402121
				}
			}
		},
		videoActCue = {
			cueList = {
				140218001
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
