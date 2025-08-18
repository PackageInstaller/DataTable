-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13009.lua

local Data = {
	cueFile = "13009",
	[1300901] = {
		bhEvent = "skill.1300901",
		atkEvents = {
			[0] = {
				unitDelay = 0.15,
				boxId = 1300901,
				flyCueId = 130090002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130090003,
						130091002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130090001,
						130091001
					}
				}
			}
		}
	},
	[1300902] = {
		bhEvent = "skill.1300901",
		atkEvents = {
			[0] = {
				unitDelay = 0.08,
				boxId = 1300901,
				flyCueId = 90010002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130090001,
						130090001
					}
				}
			},
			[100] = {
				state = {}
			}
		}
	},
	[1300951] = {
		actTime = 60,
		bhEvent = "skill.1300951",
		atkEvents = {
			{
				randomTargetNumber = 4,
				boxId = 1300951,
				unitDelay = 0.12,
				boxType = 1,
				eventType = 1,
				flyCueId = 130090008,
				targetChoose = 7,
				state = {
					duration = 5,
					stateId = 1300901
				},
				hitCue = {
					cueList = {
						130090009,
						130091006,
						10006003
					}
				},
				levelAtkEvents = {
					[2] = {
						randomTargetNumber = 5
					},
					[3] = {
						randomTargetNumber = 5
					},
					[4] = {
						randomTargetNumber = 5
					},
					[5] = {
						randomTargetNumber = 3,
						state = {}
					},
					[6] = {
						randomTargetNumber = 3,
						state = {}
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130090006,
						130090007,
						130091005
					}
				}
			}
		}
	},
	[1300921] = {
		bhEvent = "skill.1300921",
		atkEvents = {
			[0] = {
				targetArea = 2,
				boxId = 1300921,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130090005,
						130091004
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130090004,
						130091003
					}
				}
			}
		}
	},
	[1300922] = {
		actTime = 60,
		bhEvent = "skill.1300922",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130090004,
						130091003
					}
				}
			},
			[0] = {
				targetArea = 2,
				boxId = 1300921,
				targetChoose = 7,
				eventType = 1,
				state = {
					duration = -999,
					stateId = 1300902
				},
				hitCue = {
					cueList = {
						130090005,
						130091004
					}
				}
			}
		}
	},
	[1300952] = {
		actTime = 60,
		bhEvent = "skill.1300952",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130090006,
						130090007,
						130091005
					}
				}
			},
			{
				randomTargetNumber = 1,
				boxId = 1300952,
				flyCueId = 130090008,
				boxType = 1,
				targetChoose = 19,
				unitDelay = 0.12,
				state = {
					duration = 5,
					stateId = 1300901
				},
				hitCue = {
					cueList = {
						130090009,
						130091006,
						10006003
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
