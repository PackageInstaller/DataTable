-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13002.lua

local Data = {
	cueFile = "13002",
	[1300209] = {
		bhEvent = "skill.1300209",
		atkEvents = {
			[0] = {
				unitDelay = 0.08,
				boxId = 1300209,
				flyCueId = 130020001,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130020002,
						130021003
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130021005
					}
				}
			}
		}
	},
	[1300221] = {
		bhEvent = "skill.1300221",
		atkEvents = {
			[0] = {
				state = {}
			},
			[1001] = {
				disablePassive = 1,
				boxId = 1300229,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130020004
					}
				}
			},
			[1002] = {
				disablePassive = 1,
				boxId = 1300230,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130020004
					}
				}
			},
			[100] = {
				state = {}
			},
			[1003] = {
				subEventCondition = 1,
				targetArea = 3,
				addManaNumber = 5,
				state = {}
			}
		}
	},
	[1300259] = {
		hideEffect = 1,
		videoActTime = 49,
		skillTarget = 4,
		prepareCamera = 1,
		prepareCamDruation = 20,
		actTime = 50,
		bhEvent = "skill.1300259",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130020007
					}
				}
			},
			[2] = {
				manaNotShow = 1,
				targetArea = 3,
				addManaNumber = -100,
				state = {
					duration = 0.2,
					stateId = 1300201
				}
			},
			[10] = {
				unitDelay = 0.12,
				flyCueId = 130020008,
				boxType = 1,
				hitedAnim = "Hit",
				state = {},
				hitCue = {
					cueList = {
						130020004,
						130021002
					}
				}
			},
			{
				unitDelay = 0.12,
				flyCueId = 130020008,
				boxId = 1300259,
				hitedAnim = "Hit",
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130021002,
						130020004,
						10006003
					}
				}
			},
			[11] = {
				state = {},
				atkCue = {
					cueList = {
						130020005,
						130025001
					}
				}
			},
			[90] = {
				hitedAnim = "end",
				state = {}
			},
			[1001] = {
				state = {
					duration = 3,
					stateId = 1300211
				}
			},
			[1002] = {
				subEventId = 1003,
				subEventType = 1,
				subEventSkill = 1300259,
				eventCondition = "1,2,1300211",
				state = {}
			},
			[1003] = {
				subEventId = 1004,
				subEventSkill = 1300259,
				targetArea = 3,
				addManaNumber = 20,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1300212
					}
				}
			},
			[1004] = {
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1300211
					}
				}
			},
			[1005] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						82130021
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				130028002,
				130021004
			}
		}
	},
	[1300271] = {
		hideEffect = 1,
		actTime = 50,
		prepareCamDruation = 20,
		skillTarget = 4,
		prepareCamera = 1,
		bhEvent = "skill.1300271",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130020006,
						130025002
					}
				}
			},
			[2] = {
				manaNotShow = 1,
				targetArea = 3,
				addManaNumber = -100,
				state = {
					duration = 1.8,
					stateId = 1300201
				}
			},
			[10] = {
				unitDelay = 0.12,
				flyCueId = 130020008,
				boxType = 1,
				hitedAnim = "Hit",
				state = {},
				hitCue = {
					cueList = {
						130020004,
						130021002
					}
				}
			},
			{
				unitDelay = 0.12,
				flyCueId = 130020008,
				boxId = 1300259,
				hitedAnim = "Hit",
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130020004,
						130021002,
						10006003
					}
				}
			},
			[11] = {
				state = {}
			},
			[0] = {
				state = {}
			},
			[90] = {
				hitedAnim = "end",
				state = {}
			}
		}
	},
	[1300210] = {
		skillTarget = 2,
		bhEvent = "skill.1300210",
		atkEvents = {
			[0] = {
				unitDelay = 0.08,
				boxId = 1300209,
				flyCueId = 130020001,
				boxType = 1,
				targetChoose = 9,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130020002,
						130021003
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130021005
					}
				}
			}
		}
	},
	[1300291] = {
		bhEvent = "skill.1300291",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130020007
					}
				}
			},
			[10] = {
				unitDelay = 0.12,
				flyCueId = 130020008,
				boxType = 1,
				state = {},
				hitCue = {
					cueList = {
						130021002,
						130020004
					}
				}
			},
			{
				boxId = 1300259,
				state = {},
				hitCue = {
					cueList = {
						130020004,
						130021002
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
