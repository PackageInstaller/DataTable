-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_15009.lua

local Data = {
	cueFile = "15009",
	[1500909] = {
		bhEvent = "skill.1500909",
		atkEvents = {
			[0] = {
				unitDelay = 0.16,
				boxId = 1500909,
				flyCueId = 150090002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000063,
						150091002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						150090001,
						150091001
					}
				}
			}
		}
	},
	[1500910] = {
		bhEvent = "skill.1500909",
		atkEvents = {
			[0] = {
				unitDelay = 0.08,
				boxId = 1500909,
				flyCueId = 90010003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						150090001
					}
				}
			},
			[10] = {
				state = {}
			},
			[100] = {
				state = {}
			}
		}
	},
	[1500959] = {
		actTime = 50,
		bhEvent = "skill.1500959",
		atkEvents = {
			[10] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						150090001,
						150090001
					}
				}
			},
			[2] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 1500901
				},
				atkCue = {
					cueList = {
						150090006
					}
				},
				hitCue = {
					cueList = {
						150090008
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 15,
							stateId = 1500901
						}
					},
					[4] = {
						state = {
							duration = 15,
							stateId = 1500901
						}
					},
					[5] = {},
					[6] = {}
				}
			},
			{
				state = {}
			},
			[1001] = {
				boxId = 1500959,
				targetArea = 1,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[0] = {
				state = {}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						150090007,
						150091005
					}
				}
			}
		}
	},
	[1500921] = {
		actTime = 40,
		bhEvent = "skill.1500921",
		atkEvents = {
			[2] = {
				targetChoose = 12,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1500902
				},
				hitCue = {
					cueList = {
						150090005,
						150091004
					}
				}
			},
			[100] = {
				targetChoose = 4,
				recordSkillTargets = 1,
				targetArea = 3,
				excludeTarget = 1,
				state = {},
				atkCue = {
					cueList = {
						150090004,
						150091003
					}
				},
				levelAtkEvents = {
					[2] = {
						targetChoose = 3
					},
					[3] = {
						targetChoose = 7
					},
					[4] = {},
					[5] = {},
					[6] = {}
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
