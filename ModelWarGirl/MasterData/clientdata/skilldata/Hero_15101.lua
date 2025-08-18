-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_15101.lua

local Data = {
	cueFile = "15101",
	[1510109] = {
		bhEvent = "skill.1510109",
		atkEvents = {
			[0] = {
				unitDelay = 0.12,
				boxId = 1510109,
				flyCueId = 151010004,
				boxType = 1,
				eventType = 1,
				state = {
					chooseStateType = 1,
					chooseStateMode = 2
				},
				hitCue = {
					cueList = {
						151010005,
						151011001
					}
				}
			},
			[15] = {
				state = {},
				hitCue = {
					cueList = {
						151010008
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						151010001
					}
				}
			}
		}
	},
	[1510110] = {
		bhEvent = "skill.1510110",
		atkEvents = {
			[0] = {
				unitDelay = 0.12,
				boxId = 1510109,
				flyCueId = 151010003,
				boxType = 1,
				eventType = 1,
				state = {
					chooseStateMode = 2
				},
				hitCue = {
					cueList = {
						151010005,
						151011002
					}
				}
			},
			[15] = {
				state = {},
				hitCue = {
					cueList = {
						151010008
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						151010002
					}
				}
			}
		}
	},
	[1510159] = {
		actTime = 65,
		skillTarget = 1,
		bhEvent = "skill.1510159",
		atkEvents = {
			[100] = {
				state = {}
			},
			[0] = {
				targetArea = 3,
				boxId = 1510159,
				targetChoose = 12,
				state = {
					duration = 5,
					stateId = 1510103
				},
				hitCue = {
					cueList = {
						151010007,
						151011004
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 2,
							stateId = 1510102
						}
					},
					[4] = {
						state = {}
					},
					[5] = {
						state = {}
					},
					[6] = {
						state = {}
					}
				}
			},
			{
				recordSkillTargets = 1,
				targetArea = 3,
				targetChoose = 18,
				state = {
					duration = 2,
					stateId = 1510104
				}
			},
			[1001] = {
				boxId = 1510160,
				targetArea = 1,
				state = {},
				hitCue = {
					cueList = {
						10000047
					}
				}
			},
			[1002] = {
				boxId = 1510161,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						151010007
					}
				}
			},
			{
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 0.2,
							stateId = 1510105
						}
					},
					[3] = {
						state = {
							duration = 0.2,
							stateId = 1510105
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		}
	},
	[1510129] = {
		actTime = 35,
		skillTarget = 1,
		bhEvent = "skill.1510129",
		atkEvents = {
			[100] = {
				targetChoose = 3,
				recordSkillTargets = 1,
				targetArea = 3,
				excludeTarget = 1,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						targetChoose = 7
					},
					[4] = {
						targetChoose = 4
					},
					[5] = {
						targetChoose = 4
					},
					[6] = {
						targetChoose = 4
					}
				}
			},
			{
				targetChoose = 12,
				targetArea = 3,
				addManaNumber = 20,
				state = {
					duration = -999,
					stateId = 1510101
				},
				hitCue = {
					cueList = {
						151010006,
						151011003
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {},
					[4] = {
						state = {}
					},
					[5] = {
						state = {}
					},
					[6] = {
						state = {}
					}
				}
			},
			{
				targetChoose = 4,
				targetArea = 3,
				excludeTarget = 1,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						addManaNumber = 10
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		}
	},
	[1510160] = {
		actTime = 65,
		skillTarget = 1,
		bhEvent = "skill.1510160",
		atkEvents = {
			[100] = {
				state = {}
			},
			[0] = {
				targetArea = 3,
				boxId = 1510159,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						151010007,
						151011004
					}
				}
			},
			{
				state = {}
			},
			{
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
