-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12012.lua

local Data = {
	cueFile = "12012",
	[1201209] = {
		bhEvent = "skill.1201209",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120120001,
						120121001
					}
				}
			},
			{
				boxId = 1201209,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120120004
					}
				}
			}
		}
	},
	[1201210] = {
		bhEvent = "skill.1201210",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120120002,
						120121002
					}
				}
			},
			{
				boxId = 1201209,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120120004
					}
				}
			}
		}
	},
	[1201211] = {
		bhEvent = "skill.1201211",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120120003,
						120121003
					}
				}
			},
			{
				boxId = 1201209,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120120004
					}
				}
			}
		}
	},
	[1201229] = {
		bhEvent = "skill.1201229",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 1201203
				},
				atkCue = {
					cueList = {
						120120005,
						120121004
					}
				}
			},
			{
				boxId = 1201229,
				eventType = 1,
				state = {}
			},
			{
				boxId = 1201229,
				eventType = 1,
				state = {}
			},
			[1001] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1201212
					}
				}
			}
		}
	},
	[1201230] = {
		bhEvent = "skill.1201230",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 1201203
				},
				atkCue = {
					cueList = {
						120120006,
						120121005
					}
				}
			},
			{
				boxId = 1201230,
				eventType = 1,
				state = {}
			},
			{
				boxId = 1201230,
				eventType = 1,
				state = {}
			},
			{
				boxId = 1201230,
				eventType = 1,
				state = {}
			}
		}
	},
	[1201259] = {
		hideTime = 10,
		hideEvent = 1,
		videoActTime = 64,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 55,
		actTime = 96,
		bhEvent = "skill.1201259",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120120007
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						120120012,
						120125001,
						120121008
					}
				}
			},
			[11] = {
				state = {},
				hitCue = {
					cueList = {
						120120010
					}
				}
			},
			[12] = {
				state = {},
				hitCue = {
					cueList = {
						120120009
					}
				}
			},
			[27] = {
				hitedAnim = "Hit",
				state = {},
				atkCue = {
					cueList = {
						120123001
					}
				}
			},
			[99] = {
				hitedAnim = "end",
				state = {}
			},
			{
				boxId = 1201259,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						120123003
					}
				}
			},
			[1001] = {
				boxId = 1201260,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120120011
					}
				}
			},
			[28] = {
				hitedAnim = "Hit",
				state = {},
				atkCue = {
					cueList = {
						120123002
					}
				}
			},
			[14] = {
				state = {},
				atkCue = {
					cueList = {
						120121007
					}
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1201202,
						1201205
					}
				}
			},
			[1003] = {
				boxId = 1201261,
				disablePassive = 1,
				eventType = 1,
				state = {}
			},
			[1004] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1201205
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1201201
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = -999,
							stateId = 1201204
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		},
		videoActCue = {
			cueList = {
				120128001,
				120121006
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
