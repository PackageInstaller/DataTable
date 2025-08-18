-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13010.lua

local Data = {
	cueFile = "13010",
	[1301009] = {
		bhEvent = "skill.1301009",
		atkEvents = {
			[1001] = {
				state = {
					duration = 10,
					stateId = 1301001
				}
			},
			[1002] = {
				disablePassive = 1,
				boxType = 1,
				boxId = 1301029,
				delay = 0.2,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130100001
					}
				}
			},
			[2] = {
				unitDelay = 0.15,
				boxId = 1301009,
				flyCueId = 130100002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062,
						130100003,
						130101002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130100001,
						130101001
					}
				}
			}
		}
	},
	[1301059] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.1301059",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130100004,
						130101003
					}
				}
			},
			[1001] = {
				boxId = 1301060,
				targetArea = 3,
				state = {}
			},
			{
				targetArea = 3,
				summonMonsters = "1630101",
				state = {},
				levelAtkEvents = {
					[2] = {
						summonMonsters = "1630102"
					},
					[3] = {
						summonMonsters = "1630103"
					},
					[4] = {
						summonMonsters = "1630103"
					},
					[5] = {},
					[6] = {}
				}
			},
			[1002] = {
				targetChoose = 15,
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 1301005
				}
			},
			[1003] = {
				targetChoose = 15,
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1301001
					}
				}
			},
			[1004] = {
				addManaNumber = 20,
				targetArea = 3,
				state = {}
			},
			[1005] = {
				targetArea = 3,
				summonMonsters = "1630103",
				state = {}
			}
		}
	},
	[1301060] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.1301060",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130100004,
						130101003
					}
				}
			},
			{
				targetArea = 3,
				summonMonsters = "1630111",
				state = {}
			}
		}
	},
	[1301010] = {
		bhEvent = "skill.1301010",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130100001,
						130101001
					}
				}
			},
			[2] = {
				randomTargetNumber = 3,
				boxId = 1301009,
				unitDelay = 0.15,
				boxType = 1,
				randomRule = 2,
				eventType = 1,
				flyCueId = 130100002,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						10000062,
						130100003,
						130101002
					}
				}
			}
		}
	},
	[1301061] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.1301061",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130100004,
						130101003
					}
				}
			},
			{
				summonMonsters = "1630112,1630112",
				state = {}
			},
			[1001] = {
				boxId = 1301060,
				targetArea = 3,
				state = {}
			},
			[1002] = {
				targetChoose = 15,
				targetArea = 3,
				addManaNumber = 30,
				state = {},
				hitCue = {
					cueList = {
						10000035
					}
				}
			},
			[1003] = {
				targetArea = 3,
				boxId = 1301010,
				targetChoose = 18,
				excludeTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						10000045,
						10000047
					}
				}
			},
			[1004] = {
				boxId = 1301061,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						10000062
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
