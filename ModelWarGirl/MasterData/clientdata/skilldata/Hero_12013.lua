-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12013.lua

local Data = {
	cueFile = "12013",
	[1201309] = {
		bhEvent = "skill.1201309",
		atkEvents = {
			{
				boxId = 1201309,
				state = {},
				hitCue = {
					cueList = {
						120130002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120130001,
						120131001
					}
				}
			}
		}
	},
	[1201359] = {
		hideEffect = 1,
		actTime = 70,
		videoActTime = 45,
		prepareCamDruation = 20,
		prepareCamera = 1,
		bhEvent = "skill.1201359",
		atkEvents = {
			{
				boxId = 1201359,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120130012
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120130008,
						120130009
					}
				}
			},
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						120130013,
						120135001,
						120131005
					}
				}
			},
			[11] = {
				state = {},
				atkCue = {
					cueList = {
						120130011,
						120133001
					}
				}
			},
			[12] = {
				state = {},
				hitCue = {
					cueList = {
						120130010
					}
				}
			},
			[1001] = {
				addManaNumber = 4,
				targetArea = 3,
				state = {}
			},
			[1002] = {
				targetChoose = 16,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						subEventSkill = 1201359,
						subEventId = 1003
					},
					[3] = {
						subEventSkill = 1201359,
						subEventId = 1003
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				subEventId = 1002,
				subEventSkill = 1201359,
				boxId = 1201360,
				targetArea = 3,
				state = {}
			},
			[1003] = {
				boxId = 1201361,
				targetArea = 3,
				state = {}
			},
			[1005] = {
				targetChoose = 10,
				subEventId = 1006,
				subEventSkill = 1201359,
				targetArea = 3,
				state = {}
			},
			[1006] = {
				boxId = 1201363,
				targetArea = 3,
				state = {}
			},
			[1007] = {
				boxId = 1201362,
				targetChoose = 23,
				eventType = 1,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				120138001,
				120131004
			}
		}
	},
	[1201310] = {
		bhEvent = "skill.1201310",
		atkEvents = {
			[2] = {
				boxId = 1201309,
				state = {},
				hitCue = {
					cueList = {
						120130004
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120130003,
						120131002
					}
				}
			}
		}
	},
	[1201329] = {
		skillTarget = 1,
		bhEvent = "skill.1201329",
		atkEvents = {
			[1001] = {
				boxId = 1201329,
				targetArea = 3,
				state = {
					chooseStateMode = 2
				}
			},
			[100] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1201302
				},
				atkCue = {
					cueList = {
						120130006,
						120130007,
						120131003
					}
				}
			},
			[4] = {
				targetChoose = 23,
				summonMonsters = "1620401",
				state = {},
				levelAtkEvents = {
					[2] = {
						summonMonsters = "1620400"
					},
					[3] = {
						summonMonsters = "1620400"
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1002] = {
				delay = 0.1,
				subEventId = 1003,
				subEventSkill = 1201329,
				boxType = 1,
				targetChoose = 23,
				state = {}
			},
			[1003] = {
				delay = 0.1,
				boxType = 1,
				boxId = 1201330,
				eventType = 1,
				state = {}
			},
			[1004] = {
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 1201311
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
