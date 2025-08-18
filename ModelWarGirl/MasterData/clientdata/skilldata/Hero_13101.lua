-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13101.lua

local Data = {
	cueFile = "13101",
	[1310109] = {
		bhEvent = "skill.1310109",
		atkEvents = {
			[0] = {
				unitDelay = 0.12,
				boxId = 1310109,
				flyCueId = 131010002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131010003,
						131011002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						131010001,
						131011001
					}
				}
			}
		}
	},
	[1310159] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 65,
		hideEffect = 1,
		skillTarget = 4,
		prepareCamera = 1,
		prepareCamDruation = 25,
		actTime = 71,
		bhEvent = "skill.1310159",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						131010005
					}
				}
			},
			{
				manaNotShow = 1,
				targetArea = 3,
				addManaNumber = -100,
				state = {
					duration = 3,
					stateId = 1310101
				}
			},
			[0] = {
				unitDelay = 0.05,
				boxId = 1310159,
				hitedAnim = "Hit",
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						131013001
					}
				},
				hitCue = {
					cueList = {
						131010006,
						131011006
					}
				}
			},
			[11] = {
				state = {},
				atkCue = {
					cueList = {
						131010007,
						131015001,
						131011004,
						131011005
					}
				}
			},
			[90] = {
				hitedAnim = "end",
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				131018001,
				131011003
			}
		}
	},
	[1310129] = {
		bhEvent = "skill.1310129",
		atkEvents = {
			[0] = {
				randomTargetNumber = 1,
				recordSkillTargets = 1,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131010011
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						131010008,
						131010009,
						131011007
					}
				}
			},
			{
				randomTargetNumber = 1,
				recordSkillTargets = 1,
				delay = 0.4,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131010011
					}
				}
			},
			{
				randomTargetNumber = 1,
				recordSkillTargets = 1,
				delay = 0.4,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131010011
					}
				}
			},
			[10] = {
				boxId = 1310129,
				targetChoose = 12,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131010010,
						131011002
					}
				}
			},
			[11] = {
				boxId = 1310129,
				targetChoose = 12,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131011002,
						131010010
					}
				}
			},
			[12] = {
				boxId = 1310129,
				targetChoose = 12,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131010010,
						131011002
					}
				}
			}
		}
	},
	[1310171] = {
		hideEffect = 1,
		actTime = 71,
		hideEvent = 100,
		skillTarget = 4,
		bhEvent = "skill.1310171",
		atkEvents = {
			{
				manaNotShow = 1,
				targetArea = 3,
				addManaNumber = -100,
				state = {
					duration = 3,
					stateId = 1310101
				}
			},
			[0] = {
				unitDelay = 0.15,
				flyCueId = 130030002,
				boxId = 1310159,
				hitedAnim = "Hit",
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						131013001
					}
				},
				hitCue = {
					cueList = {
						131010006,
						131011006
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						131010005
					}
				}
			},
			[11] = {
				state = {},
				atkCue = {
					cueList = {
						131010007,
						131015001,
						131011004,
						131011005
					}
				}
			},
			[90] = {
				hitedAnim = "end",
				state = {}
			}
		}
	},
	[1310130] = {
		bhEvent = "skill.1310130",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						131010008,
						131010012,
						131011008
					}
				}
			},
			[0] = {
				randomTargetNumber = 1,
				recordSkillTargets = 1,
				delay = 0.7,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131010011
					}
				}
			},
			{
				randomTargetNumber = 1,
				recordSkillTargets = 1,
				delay = 0.4,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131010011
					}
				}
			},
			{
				randomTargetNumber = 1,
				recordSkillTargets = 1,
				delay = 0.4,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131010011
					}
				}
			},
			{
				randomTargetNumber = 1,
				recordSkillTargets = 1,
				delay = 0.5,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131010011
					}
				}
			},
			[10] = {
				boxId = 1310129,
				targetChoose = 12,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131010010,
						131011002
					}
				}
			},
			[11] = {
				boxId = 1310129,
				targetChoose = 12,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131010010,
						131011002
					}
				}
			},
			[12] = {
				boxId = 1310129,
				targetChoose = 12,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131010010,
						131011002
					}
				}
			},
			[13] = {
				boxId = 1310129,
				targetChoose = 12,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						131011002
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
