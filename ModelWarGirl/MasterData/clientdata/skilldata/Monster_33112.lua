-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33112.lua

local Data = {
	cueFile = "33112",
	[3311201] = {
		bhEvent = "skill.3311201",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331120001,
						331121001
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 3311201,
				flyCueId = 331120002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331120003,
						331121002
					}
				}
			}
		}
	},
	[3311202] = {
		bhEvent = "skill.3311202",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331120004,
						331121003
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 3311202,
				flyCueId = 331120005,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331120006
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 3311202,
				flyCueId = 331120005,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331120007,
						331121004
					}
				}
			}
		}
	},
	[3311251] = {
		actTime = 80,
		skillTarget = 2,
		bhEvent = "skill.3311251",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331120008,
						331121005
					}
				},
				hitCue = {
					cueList = {
						331120009
					}
				}
			},
			{
				delay = 0.3,
				boxType = 1,
				boxId = 3311251,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 3311202
				},
				hitCue = {
					cueList = {
						331120010,
						331121006
					}
				}
			},
			[1001] = {
				boxId = 3311254,
				state = {},
				hitCue = {
					cueList = {
						331120003
					}
				}
			}
		}
	},
	[3311252] = {
		actTime = 65,
		bhEvent = "skill.3311252",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331120013,
						331121007
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 3311252,
				flyCueId = 331120014,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331120016,
						331121008
					}
				}
			},
			[99] = {
				state = {},
				hitCue = {
					cueList = {
						331120015
					}
				}
			}
		}
	},
	[3311253] = {
		actTime = 75,
		skillTarget = 1,
		bhEvent = "skill.3311253",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331120017,
						331121009
					}
				}
			},
			{
				state = {
					duration = 8,
					stateId = 3311201
				}
			}
		}
	},
	[3311254] = {
		actTime = 80,
		bhEvent = "skill.3311254",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331120008,
						331121005
					}
				},
				hitCue = {
					cueList = {
						331120011
					}
				}
			},
			{
				boxType = 1,
				delay = 0.3,
				boxId = 3311253,
				targetChoose = 3,
				state = {},
				hitCue = {
					cueList = {
						331120012,
						331121006
					}
				}
			}
		}
	},
	[3311255] = {
		actTime = 80,
		bhEvent = "skill.3311255",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331120008,
						331121005
					}
				},
				hitCue = {
					cueList = {
						331120009
					}
				}
			},
			[101] = {
				targetChoose = 9,
				state = {},
				hitCue = {
					cueList = {
						331120009
					}
				}
			},
			{
				delay = 0.3,
				boxType = 1,
				boxId = 3311255,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331120010,
						331121006
					}
				}
			},
			{
				delay = 0.3,
				boxId = 3311255,
				boxType = 1,
				targetChoose = 9,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331120010,
						331121006
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
