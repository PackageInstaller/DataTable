-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11011.lua

local Data = {
	cueFile = "11011",
	[1101101] = {
		bhEvent = "skill.1101101",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110110001,
						110111001
					}
				}
			},
			{
				boxId = 1101101,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110110002
					}
				}
			}
		}
	},
	[1101102] = {
		bhEvent = "skill.1101102",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110110003,
						110110004,
						110111002
					}
				}
			},
			{
				boxId = 1101101,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110110005
					}
				}
			}
		}
	},
	[1101151] = {
		hideTime = 10,
		hideEvent = 101,
		videoActTime = 82,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 50,
		actTime = 94,
		bhEvent = "skill.1101151",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						110110009,
						110110010,
						110110011,
						110110012,
						110110013,
						110110014,
						110110021,
						110115002
					}
				}
			},
			{
				delay = 0.5,
				boxId = 1101151,
				eventType = 1,
				state = {}
			},
			[1001] = {
				targetArea = 3,
				unitDelay = 0.36,
				boxType = 1,
				targetChoose = 10,
				state = {
					duration = -999,
					stateId = 1101103,
					chooseStateMode = 2
				}
			},
			[101] = {
				state = {}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						110110020,
						110115001,
						110111005
					}
				}
			},
			[91] = {
				hitedAnim = "Hit",
				state = {},
				atkCue = {
					cueList = {
						110113001
					}
				},
				hitCue = {
					cueList = {
						110110016
					}
				}
			},
			[92] = {
				hitedAnim = "Hit",
				state = {},
				atkCue = {
					cueList = {
						110113001
					}
				},
				hitCue = {
					cueList = {
						110110017
					}
				}
			},
			[93] = {
				hitedAnim = "Hit",
				state = {},
				atkCue = {
					cueList = {
						110113002
					}
				},
				hitCue = {
					cueList = {
						110110018
					}
				}
			},
			[99] = {
				hitedAnim = "end",
				state = {}
			},
			[1002] = {
				unitDelay = 0.36,
				targetChoose = 10,
				flyCueId = 110110024,
				boxType = 1,
				targetArea = 3,
				excludeTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						110110025
					}
				}
			},
			[1003] = {
				boxId = 1101152,
				eventType = 1,
				state = {}
			},
			[1004] = {
				targetChoose = 7,
				targetArea = 3,
				eventCondition = "4,2,race,2",
				state = {
					duration = -999,
					stateId = 1101106
				}
			},
			[1005] = {
				stunTime = 1,
				boxId = 1101153,
				targetChoose = 7,
				eventType = 1,
				state = {}
			},
			[1006] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1101102
					}
				}
			},
			[1007] = {
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 1101107
				}
			}
		},
		videoActCue = {
			cueList = {
				110118001,
				110111004
			}
		}
	},
	[1101121] = {
		actTime = 68,
		skillTarget = 1,
		bhEvent = "skill.1101121",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					chooseStateMode = 2,
					chooseStateIds = {
						1101105
					}
				},
				atkCue = {
					cueList = {
						110110006,
						110110007,
						110111003
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1101109
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						subEventSkill = 1101121,
						subEventId = 1002
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				boxId = 1101121,
				targetArea = 3,
				addManaNumber = 25,
				state = {
					duration = 5,
					stateId = 1101101
				},
				atkCue = {
					cueList = {
						110110022
					}
				}
			},
			[90] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1101108
				},
				atkCue = {
					cueList = {
						110116001
					}
				}
			},
			[1002] = {
				subEventId = 1003,
				targetArea = 3,
				subEventSkill = 1101121,
				state = {
					duration = 5,
					stateId = 1101101
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1101101
				}
			},
			{
				unitDelay = 0.36,
				targetChoose = 10,
				flyCueId = 110110024,
				boxType = 1,
				targetArea = 3,
				eventCondition = "1,1,1101105",
				state = {
					duration = -999,
					stateId = 1101103
				},
				hitCue = {
					cueList = {
						110110025
					}
				}
			},
			[1004] = {
				delay = 0.36,
				flyCueId = 110110023,
				boxType = 1,
				state = {},
				hitCue = {
					cueList = {
						110110025
					}
				}
			},
			[1005] = {
				addManaNumber = 5,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1101111
				}
			}
		}
	},
	[1101152] = {
		hideTime = 10,
		hideEvent = 101,
		videoActTime = 82,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 50,
		actTime = 94,
		bhEvent = "skill.1101152",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						110110009,
						110110010,
						110110011,
						110110012,
						110110013,
						110110014,
						110110021,
						110115002
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						110110020,
						110115001,
						110111005
					}
				}
			},
			[91] = {
				hitedAnim = "Hit",
				state = {},
				atkCue = {
					cueList = {
						110113001
					}
				},
				hitCue = {
					cueList = {
						110110016
					}
				}
			},
			[92] = {
				hitedAnim = "Hit",
				state = {},
				atkCue = {
					cueList = {
						110113001
					}
				},
				hitCue = {
					cueList = {
						110110017
					}
				}
			},
			[93] = {
				hitedAnim = "Hit",
				state = {},
				atkCue = {
					cueList = {
						110113002
					}
				},
				hitCue = {
					cueList = {
						110110018
					}
				}
			},
			[99] = {
				hitedAnim = "end",
				state = {}
			},
			{
				boxId = 1101151,
				eventType = 1,
				state = {}
			},
			[101] = {
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				110118002,
				110111004
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
