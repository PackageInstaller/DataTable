-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14201.lua

local Data = {
	cueFile = "14201",
	[1420109] = {
		bhEvent = "skill.1420109",
		atkEvents = {
			{
				unitDelay = 0.15,
				boxId = 1420109,
				flyCueId = 142010003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						142010005,
						142011002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						142010001,
						142011001
					}
				}
			}
		}
	},
	[1420129] = {
		skillTarget = 1,
		bhEvent = "skill.1420129",
		atkEvents = {
			{
				randomTargetNumber = 1,
				boxType = 1,
				unitDelay = 0.2,
				boxId = 1420130,
				targetArea = 3,
				randomRule = 3,
				eventType = 1,
				excludeTarget = 1,
				flyCueId = 142010011,
				targetChoose = 4,
				state = {
					duration = 8,
					stateId = 1420101
				},
				hitCue = {
					cueList = {
						142010012,
						142011008
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 10,
							stateId = 1420101
						}
					},
					[3] = {
						state = {
							duration = 15,
							stateId = 1420101
						}
					},
					[4] = {
						state = {
							duration = 12,
							stateId = 1420101
						}
					},
					[5] = {
						state = {
							duration = 12,
							stateId = 1420101
						}
					},
					[6] = {
						state = {
							duration = 12,
							stateId = 1420101
						}
					}
				}
			},
			[1001] = {
				targetArea = 3,
				eventCondition = "1,3,1420101",
				boxId = 1420129,
				targetChoose = 7,
				state = {}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						142010010,
						142011007
					}
				}
			},
			[1002] = {
				boxId = 1420131,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1003] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						boxId = 1420160
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1004] = {
				targetArea = 3,
				eventCondition = "1,3,1420101",
				boxId = 1420160,
				targetChoose = 7,
				state = {}
			},
			[1005] = {
				targetChoose = 4,
				excludeTarget = 1,
				targetArea = 3,
				addManaNumber = 25,
				state = {},
				hitCue = {
					cueList = {
						10000035
					}
				}
			},
			[1006] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1420104
				}
			},
			[1007] = {
				randomTargetNumber = 1,
				targetArea = 3,
				randomRule = 3,
				targetChoose = 4,
				excludeTarget = 1,
				state = {
					duration = 15,
					stateId = 82142011
				}
			}
		}
	},
	[1420159] = {
		hideEffect = 1,
		videoActTime = 70,
		hideEvent = 10,
		prepareCamera = 1,
		prepareCamDruation = 25,
		actTime = 85,
		bhEvent = "skill.1420159",
		atkEvents = {
			[5] = {
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 1420102
				}
			},
			{
				hitedAnim = "Hit",
				boxId = 1420159,
				targetChoose = 4,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						142010015,
						10006003
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						boxId = 1420160
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1002] = {
				targetArea = 1,
				eventCondition = "1,3,1420101",
				boxId = 1420160,
				targetChoose = 7,
				state = {}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						142010014
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						142010016,
						142015001,
						142011010
					}
				}
			},
			[99] = {
				hitedAnim = "end",
				targetChoose = 4,
				state = {}
			},
			{
				eventCondition = "1,3,1420101",
				targetChoose = 7,
				targetArea = 1,
				state = {},
				levelAtkEvents = {
					[2] = {
						addManaNumber = 30
					},
					[3] = {
						addManaNumber = 30
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1003] = {
				disablePassive = 1,
				boxId = 1420161,
				targetChoose = 23,
				eventType = 1,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				142018001,
				142011009
			}
		}
	},
	[1420110] = {
		bhEvent = "skill.1420110",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						142010002,
						142011003
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1420109,
				flyCueId = 142010004,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						142010005,
						142011004
					}
				}
			}
		}
	},
	[1420111] = {
		bhEvent = "skill.1420111",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						142010006,
						142011005
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1420109,
				flyCueId = 142010007,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						142010009,
						142011008
					}
				}
			},
			{
				randomTargetNumber = 1,
				boxId = 1420110,
				unitDelay = 0.15,
				boxType = 1,
				disablePassive = 1,
				flyCueId = 142010008,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						142010009
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
