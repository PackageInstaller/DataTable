-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33128.lua

local Data = {
	cueFile = "33128",
	[3312801] = {
		bhEvent = "skill.3312801",
		atkEvents = {
			{
				unitDelay = 0.12,
				boxId = 3312801,
				flyCueId = 331280003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331280002,
						331281003
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331280001,
						331281001
					}
				}
			}
		}
	},
	[3312802] = {
		bhEvent = "skill.3312802",
		atkEvents = {
			{
				unitDelay = 0.12,
				boxId = 3312801,
				flyCueId = 331280021,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331280002,
						331281003
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331280020,
						331281002
					}
				}
			}
		}
	},
	[3312851] = {
		actTime = 60,
		prepareCamDruation = 20,
		skillTarget = 2,
		prepareCamera = 1,
		bhEvent = "skill.3312851",
		atkEvents = {
			{
				controlTime = 2,
				controlAniName = "Float",
				boxId = 3312851,
				targetChoose = 7,
				eventType = 1,
				state = {}
			},
			[100] = {
				targetArea = 1,
				state = {},
				atkCue = {
					cueList = {
						331280015,
						331280016,
						331285001,
						331281009
					}
				}
			},
			[11] = {
				state = {},
				atkCue = {
					cueList = {
						331280017,
						331283001
					}
				}
			}
		}
	},
	[3312803] = {
		bhEvent = "skill.3312803",
		atkEvents = {
			{
				unitDelay = 0.12,
				boxId = 3312802,
				flyCueId = 331280006,
				boxType = 1,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331280005,
						331281005
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331280004,
						331280022,
						331281004
					}
				}
			}
		}
	},
	[3312821] = {
		actTime = 60,
		skillTarget = 2,
		bhEvent = "skill.3312821",
		atkEvents = {
			{
				recordSkillTargets = 1,
				boxId = 3312821,
				targetChoose = 25,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331280010
					}
				}
			},
			{
				boxId = 3312822,
				targetChoose = 12,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331281008
					}
				}
			},
			[1001] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 3312805
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331280007,
						331280023,
						331280008,
						331280011,
						331280012,
						331285002
					}
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3312802
				},
				atkCue = {
					cueList = {
						331286001
					}
				}
			},
			[11] = {
				recordSkillTargets = 1,
				targetChoose = 25,
				state = {},
				hitCue = {
					cueList = {
						331280009,
						331281007
					}
				}
			},
			[12] = {
				targetChoose = 12,
				state = {}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3312806
				}
			}
		}
	},
	[3312822] = {
		bhEvent = "skill.3312822",
		atkEvents = {
			[1001] = {
				subEventSkill = 3312822,
				boxId = 3312823,
				subEventId = 1004,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						331280013
					}
				},
				hitCue = {
					cueList = {
						331280014,
						331281006
					}
				}
			},
			[1002] = {
				targetArea = 3,
				stunTime = 3,
				state = {
					duration = -999,
					stateId = 3312803
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 3312804
				}
			},
			[1004] = {
				excludeTarget = 1,
				boxId = 3312823,
				targetChoose = 3,
				eventType = 1,
				state = {}
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
