-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11003.lua

local Data = {
	cueFile = "11003",
	[1100351] = {
		hideTime = 10,
		hideEvent = 1,
		videoActTime = 59,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 62,
		bhEvent = "skill.1100351",
		atkEvents = {
			[10] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						110035002,
						110030002
					}
				}
			},
			[100] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1100301
				}
			},
			{
				hitedAnim = "Hit",
				boxId = 1100359,
				targetArea = 2,
				eventType = 1,
				targetChoose = 3,
				state = {},
				atkCue = {
					cueList = {
						110033001
					}
				},
				hitCue = {
					cueList = {
						110030003,
						10006003
					}
				},
				levelAtkEvents = {
					[2] = {
						stunTime = 2
					},
					[3] = {
						stunTime = 2
					},
					[4] = {
						stunTime = 3
					},
					[5] = {},
					[6] = {}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1100303
				}
			},
			[12] = {
				state = {},
				atkCue = {
					cueList = {
						110035003
					}
				}
			},
			[20] = {
				state = {},
				atkCue = {
					cueList = {
						110038001
					}
				}
			},
			[30] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						110035004,
						110030004
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 2,
							stateId = 1100305
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				state = {},
				atkCue = {
					cueList = {
						110036001
					}
				}
			},
			[1002] = {
				state = {},
				atkCue = {
					cueList = {
						110036002
					}
				}
			},
			[1003] = {
				addManaNumber = 10,
				targetArea = 3,
				state = {}
			},
			[99] = {
				state = {}
			},
			[11] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						110030006,
						110030007,
						110031002
					}
				}
			},
			[90] = {
				targetChoose = 3,
				targetArea = 2,
				hitedAnim = "end",
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				110038002,
				110031006
			}
		}
	},
	[1100301] = {
		bhEvent = "skill.1100301",
		atkEvents = {
			{
				boxId = 1100309,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110030001
					}
				}
			},
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						110031003
					}
				}
			},
			[99] = {
				state = {}
			}
		}
	},
	[1100302] = {
		bhEvent = "skill.1100302",
		atkEvents = {
			{
				boxId = 1100309,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110030001
					}
				}
			},
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						110031005
					}
				}
			},
			[99] = {
				state = {},
				atkCue = {
					cueList = {
						110031004
					}
				}
			},
			{
				state = {}
			}
		}
	},
	[1100321] = {
		bhEvent = "skill.1100321",
		atkEvents = {
			{
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 1100302
				},
				atkCue = {
					cueList = {
						110031005
					}
				}
			},
			[1001] = {
				subEventId = 1003,
				subEventSkill = 1100321,
				boxId = 1100329,
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1100304
					}
				},
				levelAtkEvents = {
					[2] = {
						addManaNumber = 30,
						hitCue = {
							cueList = {
								10000035
							}
						}
					},
					[3] = {
						addManaNumber = 30,
						hitCue = {
							cueList = {
								10000035
							}
						}
					},
					[4] = {
						addManaNumber = 30
					},
					[5] = {},
					[6] = {}
				}
			},
			[10] = {
				state = {}
			},
			[1002] = {
				eventCondition = "1,1,1100316",
				boxId = 1100330,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			},
			[1003] = {
				eventCondition = "1,1,1100313",
				targetArea = 3,
				state = {
					duration = 7,
					stateId = 1100316
				}
			}
		}
	},
	[1100371] = {
		actTime = 110,
		prepareCamDruation = 30,
		prepareCamera = 1,
		bhEvent = "skill.1100371",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110038002
					}
				}
			},
			[2] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1100303
				},
				atkCue = {
					cueList = {
						110035004
					}
				}
			},
			{
				targetArea = 2,
				stunTime = 3,
				boxId = 1100359,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110030003
					}
				}
			}
		}
	},
	[1100303] = {
		bhEvent = "skill.1100303",
		atkEvents = {
			{
				stunTime = 1.5,
				boxId = 1100309,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110030008
					}
				}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1100306,
						1100315
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110030005,
						110031007
					}
				}
			},
			[1001] = {
				boxId = 1100310,
				targetArea = 3,
				addManaNumber = 3,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			},
			[1002] = {
				delay = 0.2,
				targetArea = 3,
				boxType = 1,
				state = {
					duration = -999,
					stateId = 1100315
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
