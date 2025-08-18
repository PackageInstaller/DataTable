-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_15103.lua

local Data = {
	cueFile = "15103",
	[1510309] = {
		bhEvent = "skill.1510309",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						151030001,
						151031001
					}
				}
			},
			{
				boxId = 1510309,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						151030003,
						151031002
					}
				}
			}
		}
	},
	[1510310] = {
		bhEvent = "skill.1510310",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						151030004,
						151031003
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 0.1,
					stateId = 1510308
				}
			},
			{
				targetArea = 3,
				state = {}
			}
		}
	},
	[1510329] = {
		actTime = 80,
		bhEvent = "skill.1510329",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						151030006,
						151031004
					}
				}
			},
			{
				targetArea = 3,
				boxId = 1510329,
				targetChoose = 10,
				state = {},
				hitCue = {
					cueList = {
						151030007
					}
				}
			},
			{
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1510301
				}
			},
			{
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1510302
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
							stateId = 1510303
						}
					},
					[3] = {
						state = {
							duration = -999,
							stateId = 1510303
						}
					},
					[4] = {
						state = {
							duration = -999
						}
					},
					[5] = {
						state = {
							duration = -999
						}
					},
					[6] = {
						state = {
							duration = -999
						}
					}
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
							stateId = 1510304
						}
					},
					[3] = {
						state = {
							duration = -999,
							stateId = 1510304
						}
					},
					[4] = {
						state = {
							duration = -999
						}
					},
					[5] = {
						state = {
							duration = -999
						}
					},
					[6] = {
						state = {
							duration = -999
						}
					}
				}
			},
			[1001] = {
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 1510306
				}
			},
			[1002] = {
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 1510307
				}
			},
			[1003] = {
				targetArea = 1,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1510306
					}
				}
			},
			[1004] = {
				targetArea = 1,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1510307
					}
				}
			},
			[1005] = {
				boxId = 1510331,
				targetArea = 1,
				state = {}
			},
			[1006] = {
				targetArea = 3,
				boxId = 1510310,
				targetChoose = 10,
				state = {},
				hitCue = {
					cueList = {
						151030005
					}
				}
			},
			[1007] = {
				boxId = 1510311,
				targetArea = 3,
				targetChoose = 14,
				state = {}
			},
			[1008] = {
				boxId = 1510312,
				targetArea = 3,
				targetChoose = 14,
				state = {
					duration = 3,
					stateId = 1510311
				}
			},
			[1009] = {
				boxId = 1510313,
				targetArea = 3,
				targetChoose = 14,
				state = {}
			},
			[1010] = {
				boxType = 1,
				delay = 0.1,
				boxId = 8350380,
				targetArea = 1,
				state = {}
			},
			[1011] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8791591
				}
			},
			[1012] = {
				targetChoose = 10,
				targetArea = 3,
				addManaNumber = 15,
				state = {}
			},
			[1013] = {
				delay = 0.1,
				targetArea = 1,
				boxType = 1,
				state = {
					duration = 6,
					stateId = 8350380
				}
			},
			[1014] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 21510311
				}
			},
			[1015] = {
				boxId = 1510332,
				targetArea = 3,
				targetChoose = 10,
				state = {}
			},
			[1016] = {
				targetChoose = 10,
				excludeTarget = 1,
				targetArea = 3,
				addManaNumber = 10,
				state = {
					duration = 8,
					stateId = 21510331
				}
			}
		}
	},
	[1510359] = {
		hideEffect = 1,
		actTime = 95,
		videoActTime = 55,
		bhEvent = "skill.1510359",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						151030008,
						151030009
					}
				}
			},
			{
				targetArea = 3,
				boxId = 1510359,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						151030010
					}
				}
			},
			{
				targetChoose = 10,
				subEventId = 1001,
				subEventSkill = 1510359,
				targetArea = 3,
				state = {}
			},
			[1001] = {
				boxId = 1510360,
				targetArea = 1,
				eventCondition = "4,2,race,3",
				state = {}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 10,
							stateId = 1510351
						}
					},
					[3] = {
						state = {
							duration = 10,
							stateId = 1510351
						}
					},
					[4] = {
						state = {
							duration = 10
						}
					},
					[5] = {
						state = {
							duration = 10
						}
					},
					[6] = {
						state = {
							duration = 10
						}
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						151030011,
						151035001,
						151031006
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				151038001,
				151031005
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
