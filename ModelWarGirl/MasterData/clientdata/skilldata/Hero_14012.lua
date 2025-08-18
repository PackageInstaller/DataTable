-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14012.lua

local Data = {
	cueFile = "14012",
	[1401201] = {
		bhEvent = "skill.1401209",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140120001,
						140121001
					}
				}
			},
			{
				unitDelay = 0.1,
				boxId = 1401201,
				flyCueId = 140120002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140120003,
						140121002
					}
				}
			},
			[1001] = {
				disablePassive = 1,
				boxType = 1,
				boxId = 1401202,
				delay = 0.1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140120007
					}
				}
			},
			[1002] = {
				disablePassive = 1,
				boxType = 1,
				boxId = 1401203,
				delay = 0.1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140120007
					}
				}
			}
		}
	},
	[1401221] = {
		bhEvent = "skill.1401229",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140120005,
						140121003
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1401221,
				flyCueId = 140120006,
				boxType = 1,
				eventType = 1,
				state = {
					duration = -999,
					stateId = 1401201
				},
				hitCue = {
					cueList = {
						140120007
					}
				}
			},
			[1001] = {
				boxId = 1401222,
				disablePassive = 1,
				state = {}
			},
			[1002] = {
				priorUsePreTarget = 1,
				state = {
					duration = -999,
					stateId = 1401201
				}
			},
			{
				state = {}
			},
			{
				state = {}
			}
		}
	},
	[1401251] = {
		hideTime = 10,
		hideEvent = 2,
		videoActTime = 60,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 25,
		actTime = 70,
		bhEvent = "skill.1401259",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140120009
					}
				}
			},
			[2] = {
				state = {
					duration = 5,
					stateId = 1401202
				}
			},
			{
				boxId = 1401251,
				eventType = 1,
				state = {}
			},
			[1001] = {
				disablePassive = 1,
				boxId = 1401252,
				disableHpPassive = 1,
				eventType = 1,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1401205
					}
				},
				hitCue = {
					cueList = {
						140120012
					}
				}
			},
			[1002] = {
				disablePassive = 1,
				boxId = 1401253,
				targetChoose = 7,
				disableHpPassive = 1,
				excludeTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						140120012
					}
				}
			},
			[1003] = {
				addManaNumber = -6,
				state = {}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						140120013,
						140125001,
						140121006
					}
				}
			},
			[20] = {
				state = {},
				hitCue = {
					cueList = {
						140120010,
						140120014
					}
				}
			},
			[1004] = {
				addManaNumber = -6,
				targetChoose = 7,
				state = {}
			},
			[1005] = {
				targetChoose = 7,
				stunTime = 1,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				140128001,
				140121005
			}
		}
	},
	[1401202] = {
		bhEvent = "skill.1401210",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140120004,
						140121001
					}
				}
			},
			{
				unitDelay = 0.1,
				boxId = 1401201,
				flyCueId = 140120002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140120003,
						140121002
					}
				}
			}
		}
	},
	[1401222] = {
		bhEvent = "skill.1401230",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140120005,
						140121003
					}
				}
			},
			{
				unitDelay = 0.15,
				flyCueId = 140120006,
				boxType = 1,
				eventType = 1,
				state = {
					duration = -999,
					stateId = 1401201
				},
				hitCue = {
					cueList = {
						140120007
					}
				}
			},
			[3] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1401211
					}
				}
			},
			{
				randomTargetNumber = 1,
				eventCondition = "1,1,1401211",
				unitDelay = 0.15,
				boxType = 1,
				excludeTarget = 1,
				flyCueId = 140120006,
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 1401212
				},
				hitCue = {
					cueList = {
						140120007,
						140121004
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
