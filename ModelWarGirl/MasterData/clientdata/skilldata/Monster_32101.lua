-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_32101.lua

local Data = {
	cueFile = "32101",
	[3210101] = {
		bhEvent = "skill.3210101",
		atkEvents = {
			{
				boxId = 3210101,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			}
		}
	},
	[3210151] = {
		actTime = 53,
		skillTarget = 1,
		bhEvent = "skill.3210151",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321011001
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 3210101
				}
			},
			[5] = {
				state = {}
			}
		}
	},
	[3210102] = {
		bhEvent = "skill.3210102",
		atkEvents = {
			{
				boxId = 3210101,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			}
		}
	},
	[3210152] = {
		actTime = 50,
		skillTarget = 1,
		bhEvent = "skill.3210152",
		atkEvents = {
			[100] = {
				state = {}
			},
			[0] = {
				boxType = 1,
				unitDelay = 0.4,
				boxId = 3210152,
				targetArea = 2,
				eventType = 1,
				flyCueId = 321010025,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						321010021
					}
				}
			},
			{
				boxType = 1,
				unitDelay = 0.4,
				boxId = 3210152,
				targetArea = 2,
				eventType = 1,
				flyCueId = 321010025,
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						321010020
					}
				},
				hitCue = {
					cueList = {
						321010021
					}
				}
			}
		}
	},
	[3210103] = {
		bhEvent = "skill.3210103",
		atkEvents = {
			{
				targetArea = 2,
				boxId = 3210103,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						321010009
					}
				}
			}
		}
	},
	[3210154] = {
		actTime = 53,
		bhEvent = "skill.3210154",
		atkEvents = {
			[100] = {
				state = {}
			},
			{
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 3210102
				}
			},
			[5] = {
				state = {}
			}
		}
	},
	[3210153] = {
		actTime = 90,
		bhEvent = "skill.3210153",
		atkEvents = {
			[5] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 3210103
				}
			},
			{
				targetArea = 2,
				boxId = 3210153,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						321010016
					}
				}
			},
			[100] = {
				state = {}
			}
		}
	},
	[3210155] = {
		bhEvent = "skill.3210155",
		atkEvents = {
			[5] = {
				state = {}
			},
			{
				targetArea = 2,
				boxId = 3210155,
				targetChoose = 3,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 1500101
				},
				hitCue = {
					cueList = {
						321010016
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						321010015
					}
				}
			}
		}
	},
	[3210156] = {
		actTime = 50,
		skillTarget = 1,
		bhEvent = "skill.3210156",
		atkEvents = {
			[100] = {
				state = {}
			},
			[0] = {
				randomTargetNumber = 1,
				boxId = 3210156,
				unitDelay = 0.4,
				boxType = 1,
				eventType = 1,
				flyCueId = 321010025,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						321010021
					}
				}
			},
			{
				randomTargetNumber = 1,
				unitDelay = 0.4,
				boxType = 1,
				boxId = 3210156,
				eventType = 1,
				flyCueId = 321010025,
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						321010020
					}
				},
				hitCue = {
					cueList = {
						321010021
					}
				}
			}
		}
	},
	[3210157] = {
		actTime = 50,
		skillTarget = 1,
		bhEvent = "skill.3210157",
		atkEvents = {
			[100] = {
				state = {}
			},
			[0] = {
				unitDelay = 0.25,
				targetChoose = 3,
				flyCueId = 321010025,
				boxId = 3210157,
				targetArea = 2,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						321010021
					}
				}
			},
			{
				boxId = 3210157,
				delay = 0.1,
				boxType = 1,
				targetArea = 2,
				eventType = 1,
				targetChoose = 3,
				state = {},
				atkCue = {
					cueList = {
						321010020
					}
				},
				hitCue = {
					cueList = {
						321010021
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
