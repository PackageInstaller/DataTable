-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11008.lua

local Data = {
	cueFile = "11008",
	[1100801] = {
		bhEvent = "skill.1100801",
		atkEvents = {
			[1001] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 1100801
				},
				hitCue = {
					cueList = {
						110080001
					}
				}
			},
			{
				boxId = 1100801,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110080006
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110080004
					}
				}
			},
			[99] = {
				state = {},
				atkCue = {
					cueList = {
						110081001
					}
				}
			}
		}
	},
	[1100851] = {
		actTime = 60,
		bhEvent = "skill.1100851",
		atkEvents = {
			{
				boxId = 1100852,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000025
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 10,
							stateId = 1100802
						}
					},
					[4] = {
						state = {
							duration = 10,
							stateId = 1100802
						}
					},
					[5] = {},
					[6] = {}
				}
			},
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						110080009,
						110080010,
						110081004
					}
				}
			},
			{
				boxId = 1100851,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110080011,
						10006003
					}
				}
			},
			{
				targetChoose = 4,
				targetArea = 3,
				excludeTarget = 1,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1100853,
						hitCue = {
							cueList = {
								10000025
							}
						}
					},
					[3] = {
						boxId = 1100853,
						state = {
							duration = 10,
							stateId = 1100802
						},
						hitCue = {
							cueList = {
								10000025
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		}
	},
	[1100802] = {
		bhEvent = "skill.1100802",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110080005
					}
				}
			},
			{
				boxId = 1100801,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110080006
					}
				}
			},
			[99] = {
				state = {},
				atkCue = {
					cueList = {
						110081002
					}
				}
			}
		}
	},
	[1100821] = {
		skillTarget = 1,
		bhEvent = "skill.1100821",
		atkEvents = {
			{
				randomTargetNumber = 3,
				boxId = 1100821,
				targetChoose = 7,
				randomRule = 2,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						110080008
					}
				},
				levelAtkEvents = {
					[2] = {
						randomTargetNumber = 20
					},
					[3] = {
						randomTargetNumber = 20,
						state = {
							duration = 10,
							stateId = 1100801
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110080007,
						110081003
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
