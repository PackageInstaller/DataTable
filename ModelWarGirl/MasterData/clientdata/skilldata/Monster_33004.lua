-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33004.lua

local Data = {
	cueFile = "13003",
	[3300401] = {
		bhEvent = "skill.3300401",
		atkEvents = {
			[0] = {
				unitDelay = 0.12,
				boxId = 3300401,
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
				boxId = 3300401,
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
	[3300402] = {
		bhEvent = "skill.3300402",
		atkEvents = {
			[0] = {
				unitDelay = 0.05,
				boxId = 3300401,
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
				boxId = 3300401,
				unitDelay = 0.05,
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
	[3300421] = {
		actTime = 47,
		skillTarget = 1,
		bhEvent = "skill.3300421",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						90015001
					}
				}
			},
			[0] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3300401
				},
				hitCue = {
					cueList = {
						130030014
					}
				}
			},
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						130030013
					}
				}
			}
		}
	},
	[3300451] = {
		actTime = 90,
		skillTarget = 1,
		bhEvent = "skill.3300451",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130030005
					}
				}
			},
			[0] = {
				targetChoose = 7,
				excludeTarget = 1,
				targetArea = 3,
				addManaNumber = 50,
				state = {
					duration = -999,
					stateId = 3300402
				},
				hitCue = {
					cueList = {
						130030007,
						10000001,
						130031005
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3300404
				}
			},
			{
				state = {}
			},
			[101] = {
				state = {},
				atkCue = {
					cueList = {
						130030006
					}
				}
			}
		}
	},
	[3300452] = {
		actTime = 150,
		bhEvent = "skill.3300452",
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
				flyCueId = 90010027,
				unitDelay = 0.1,
				boxId = 3300451,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130030008
					}
				}
			},
			[10] = {
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
