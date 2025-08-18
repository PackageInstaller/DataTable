-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33003.lua

local Data = {
	cueFile = "13003",
	[3300301] = {
		bhEvent = "skill.3300301",
		atkEvents = {
			[0] = {
				unitDelay = 0.12,
				boxId = 3300301,
				flyCueId = 130030002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130030003,
						130031003
					}
				}
			},
			{
				randomTargetNumber = 2,
				boxId = 3300301,
				unitDelay = 0.12,
				boxType = 1,
				excludeTarget = 1,
				eventType = 1,
				flyCueId = 130030002,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						130030003
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130030001
					}
				}
			}
		}
	},
	[3300302] = {
		bhEvent = "skill.3300302",
		atkEvents = {
			[0] = {
				unitDelay = 0.12,
				boxId = 3300301,
				flyCueId = 130030010,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130030003,
						130031004
					}
				}
			},
			{
				randomTargetNumber = 2,
				boxId = 3300301,
				unitDelay = 0.12,
				boxType = 1,
				excludeTarget = 1,
				eventType = 1,
				flyCueId = 130030010,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						130030003
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130030009
					}
				}
			}
		}
	},
	[3300321] = {
		actTime = 46,
		skillTarget = 1,
		bhEvent = "skill.3300321",
		atkEvents = {
			[0] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3300301
				},
				hitCue = {
					cueList = {
						130030012
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						90015001
					}
				}
			},
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						130030011
					}
				}
			}
		}
	},
	[3300351] = {
		actTime = 150,
		bhEvent = "skill.3300351",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130030001
					}
				}
			},
			[0] = {
				boxId = 3300351,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130030008
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
