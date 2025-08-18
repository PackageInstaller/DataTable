-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13003.lua

local Data = {
	cueFile = "13003",
	[1300309] = {
		bhEvent = "skill.1300309",
		atkEvents = {
			[0] = {
				unitDelay = 0.12,
				boxId = 1300309,
				flyCueId = 130030002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130030003,
						130031003
					}
				}
			},
			{
				state = {},
				atkCue = {
					cueList = {
						130030001
					}
				}
			},
			[100] = {
				state = {}
			}
		}
	},
	[1300310] = {
		bhEvent = "skill.1300310",
		atkEvents = {
			[0] = {
				unitDelay = 0.12,
				boxId = 1300309,
				flyCueId = 130030010,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130030003,
						130031004
					}
				}
			},
			{
				state = {},
				atkCue = {
					cueList = {
						130030009
					}
				}
			},
			[100] = {
				state = {}
			}
		}
	},
	[1300359] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 50,
		hideEffect = 1,
		skillTarget = 5,
		prepareCamera = 1,
		prepareCamDruation = 25,
		actTime = 76,
		bhEvent = "skill.1300359",
		atkEvents = {
			[11] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						130035001,
						130030015
					}
				}
			},
			{
				randomTargetNumber = 1,
				hitedAnim = "Hit",
				boxId = 1300359,
				recordSkillTargets = 1,
				eventType = 1,
				targetChoose = 4,
				state = {},
				atkCue = {
					cueList = {
						130033001
					}
				},
				hitCue = {
					cueList = {
						130030008,
						10006003,
						130031002
					}
				}
			},
			[1001] = {
				manaNotShow = 1,
				targetArea = 3,
				addManaNumber = -15,
				state = {}
			},
			{
				randomTargetNumber = 1,
				boxId = 1300359,
				targetChoose = 4,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130030008
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[12] = {
				targetChoose = 4,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1300303
					}
				}
			},
			[13] = {
				targetArea = 3,
				state = {}
			},
			[10] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						manaNotShow = 1,
						addManaNumber = 60,
						state = {
							duration = 4,
							stateId = 1300302
						}
					},
					[3] = {
						manaNotShow = 1,
						addManaNumber = 60,
						state = {
							duration = 4,
							stateId = 1300302
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1002] = {
				manaNotShow = 1,
				addManaNumber = -15,
				state = {}
			},
			[100] = {
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						130030016
					}
				}
			},
			[90] = {
				hitedAnim = "end",
				targetChoose = 12,
				state = {
					duration = 2,
					stateId = 1300303
				}
			},
			[1003] = {
				disablePassive = 1,
				boxType = 1,
				boxId = 1300361,
				delay = 0.1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130030008,
						130031002,
						10006003
					}
				}
			},
			[1004] = {
				targetChoose = 4,
				state = {
					duration = 2,
					stateId = 82130031
				}
			},
			[1005] = {
				state = {
					duration = 2,
					stateId = 82130032
				}
			},
			[1006] = {
				targetChoose = 4,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						82130031,
						82130032
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				130038002,
				130031006
			}
		}
	},
	[1300329] = {
		actTime = 48,
		skillTarget = 1,
		bhEvent = "skill.1300329",
		atkEvents = {
			[100] = {
				targetArea = 2,
				boxId = 1300360,
				targetChoose = 7,
				eventType = 1,
				state = {
					duration = 10,
					stateId = 1300302
				},
				hitCue = {
					cueList = {
						130030003
					}
				}
			},
			[0] = {
				state = {}
			},
			[1001] = {
				boxType = 1,
				unitDelay = 0.1,
				boxId = 1300360,
				targetArea = 2,
				eventType = 1,
				flyCueId = 130030001,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						130030007
					}
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1300301
				}
			},
			[1003] = {
				unitDelay = 0.25,
				flyCueId = 130030004,
				boxType = 1,
				targetArea = 1,
				state = {},
				atkCue = {
					cueList = {
						130030018
					}
				}
			},
			{
				boxType = 1,
				unitDelay = 0.08,
				boxId = 1300360,
				targetArea = 2,
				eventType = 1,
				flyCueId = 130030001,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						130030007
					}
				}
			},
			[10] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1300304
					}
				}
			},
			{
				boxId = 1300329,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10006006
					}
				}
			},
			[1004] = {
				disablePassive = 1,
				stunTime = 1,
				boxId = 1300330,
				targetChoose = 7,
				eventType = 1,
				state = {},
				baseCue = {
					cueList = {
						10000058
					}
				}
			},
			[1005] = {
				controlTime = 0.1,
				controlAniName = "idle",
				manaNotShow = 1,
				addManaNumber = -100,
				state = {}
			}
		}
	},
	[1300321] = {
		actTime = 300,
		bhEvent = "skill.1300321",
		atkEvents = {
			{
				boxType = 1,
				unitDelay = 0.12,
				boxId = 1300309,
				targetArea = 2,
				eventType = 1,
				flyCueId = 130030002,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						130030006
					}
				}
			}
		}
	},
	[1300391] = {
		bhEvent = "skill.1300391",
		atkEvents = {
			[100] = {
				state = {}
			},
			{
				randomTargetNumber = 1,
				boxId = 1300359,
				targetChoose = 4,
				state = {},
				hitCue = {
					cueList = {
						130030008
					}
				}
			}
		}
	},
	[1300311] = {
		bhEvent = "skill.1300311",
		atkEvents = {
			[100] = {
				state = {}
			},
			[0] = {
				randomTargetNumber = 3,
				boxId = 3300401,
				unitDelay = 0.12,
				boxType = 1,
				eventType = 1,
				flyCueId = 130030002,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						130030003,
						130031003
					}
				}
			},
			{
				state = {},
				atkCue = {
					cueList = {
						130030001
					}
				}
			}
		}
	},
	[1300312] = {
		bhEvent = "skill.1300312",
		atkEvents = {
			[100] = {
				state = {}
			},
			[0] = {
				randomTargetNumber = 3,
				boxId = 3300401,
				unitDelay = 0.12,
				boxType = 1,
				eventType = 1,
				flyCueId = 130030010,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						130030003,
						130031004
					}
				}
			},
			{
				state = {},
				atkCue = {
					cueList = {
						130030009
					}
				}
			}
		}
	},
	[1300331] = {
		skillTarget = 1,
		bhEvent = "skill.1300331",
		atkEvents = {
			{
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3300405
				}
			},
			[1001] = {
				boxId = 3300431,
				targetChoose = 3,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						130030017
					}
				},
				hitCue = {
					cueList = {
						130030003
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
