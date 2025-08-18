-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33111.lua

local Data = {
	cueFile = "33111",
	[3311101] = {
		bhEvent = "skill.3311101",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331110001,
						331111001
					}
				}
			},
			{
				boxId = 3311101,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331110002,
						331111002
					}
				}
			}
		}
	},
	[3311102] = {
		bhEvent = "skill.3311102",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331110003,
						331111001
					}
				}
			},
			{
				boxId = 3311101,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331110004,
						331111002
					}
				}
			}
		}
	},
	[3311151] = {
		actTime = 50,
		bhEvent = "skill.3311151",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331110005,
						331110006,
						331111003
					}
				}
			},
			{
				boxId = 3311151,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 3311102
				},
				hitCue = {
					cueList = {
						331110007,
						331111004
					}
				}
			},
			{
				state = {
					duration = 5,
					stateId = 1000001
				}
			}
		}
	},
	[3311152] = {
		actTime = 40,
		bhEvent = "skill.3311152",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331110013,
						331111005
					}
				}
			},
			{
				boxId = 3311152,
				targetChoose = 2,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 3311102
				},
				hitCue = {
					cueList = {
						331110014
					}
				}
			},
			{
				targetChoose = 2,
				state = {
					duration = 5,
					stateId = 1000001
				}
			}
		}
	},
	[3311153] = {
		actTime = 60,
		skillTarget = 1,
		bhEvent = "skill.3311153",
		atkEvents = {
			{
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 3311101
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331110017,
						331110019,
						331110020,
						331110021,
						331111006
					}
				}
			}
		}
	},
	[3311154] = {
		actTime = 50,
		bhEvent = "skill.3311154",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331110009,
						331110010,
						331111003
					}
				}
			},
			{
				boxId = 3311151,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 3311103
				},
				hitCue = {
					cueList = {
						331110011,
						331111004
					}
				}
			},
			{
				state = {
					duration = 5,
					stateId = 1000003
				}
			}
		}
	},
	[3311155] = {
		actTime = 40,
		bhEvent = "skill.3311155",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331110015,
						331111005
					}
				}
			},
			{
				boxId = 3311152,
				targetChoose = 2,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 3311103
				},
				hitCue = {
					cueList = {
						331110016
					}
				}
			},
			{
				targetChoose = 2,
				state = {
					duration = 5,
					stateId = 1000003
				}
			}
		}
	},
	[3311121] = {
		skillTarget = 1,
		bhEvent = "skill.3311121",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331110017,
						331110019,
						331110020,
						331110021,
						331111006
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 3311101
				}
			},
			[1001] = {
				boxId = 3311121,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			}
		}
	},
	[3311122] = {
		bhEvent = "skill.3311122",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331110013,
						331111005
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 3311104
				}
			},
			{
				boxId = 3311122,
				targetChoose = 2,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331110014
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
