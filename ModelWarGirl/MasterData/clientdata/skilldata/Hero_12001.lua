-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12001.lua

local Data = {
	cueFile = "12001",
	[1200101] = {
		bhEvent = "skill.1200101",
		atkEvents = {
			{
				boxId = 1200109,
				eventType = 1,
				state = {}
			}
		}
	},
	[1200102] = {
		bhEvent = "skill.1200102",
		atkEvents = {
			{
				boxId = 1200109,
				eventType = 1,
				state = {}
			}
		}
	},
	[1200121] = {
		actTime = 45,
		skillTarget = 1,
		bhEvent = "skill.1200121",
		atkEvents = {
			{
				targetArea = 3,
				state = {
					duration = 12,
					stateId = 1200101
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 16,
							stateId = 1200101
						}
					},
					[4] = {
						state = {
							duration = 16,
							stateId = 1200101
						}
					},
					[5] = {
						state = {
							duration = 18,
							stateId = 1200101
						}
					},
					[6] = {
						state = {
							duration = 15,
							stateId = 1200101
						}
					}
				}
			},
			[1001] = {
				randomTargetNumber = 1,
				targetArea = 2,
				boxId = 1200161,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120010004
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120010006
					}
				}
			},
			[1002] = {
				eventCondition = "1,1,1200101",
				targetArea = 3,
				state = {
					duration = 1.1,
					stateId = 1200104
				}
			},
			[1003] = {
				randomTargetNumber = 1,
				boxId = 1200129,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[1004] = {
				eventCondition = "1,1,1200101",
				targetArea = 3,
				state = {
					duration = 1.1,
					stateId = 1200106
				}
			}
		}
	},
	[1200151] = {
		hideTime = 10,
		hideEvent = 1,
		videoActTime = 43,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 45,
		actTime = 64,
		bhEvent = "skill.1200151",
		atkEvents = {
			[10] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						120010005
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 1,
							stateId = 1200102
						}
					},
					[3] = {
						state = {
							duration = 1,
							stateId = 1200102
						}
					},
					[4] = {
						state = {
							duration = 1,
							stateId = 1200102
						}
					},
					[5] = {},
					[6] = {}
				}
			},
			{
				boxId = 1200159,
				hitedAnim = "Hit",
				eventType = 1,
				state = {}
			},
			[1001] = {
				stunTime = 3,
				state = {}
			},
			[20] = {
				state = {},
				atkCue = {
					cueList = {
						120015002,
						120010003,
						120011002
					}
				}
			},
			[1002] = {
				targetArea = 3,
				addManaNumber = 30,
				state = {
					duration = 5,
					stateOperation = 2,
					chooseStateMode = 2,
					chooseStateIds = {
						1200101
					}
				},
				hitCue = {
					cueList = {
						10000035
					}
				}
			},
			{
				boxId = 1200160,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[0] = {
				state = {}
			},
			[27] = {
				hitedAnim = "Hit",
				state = {},
				atkCue = {
					cueList = {
						120013002
					}
				}
			},
			[90] = {
				hitedAnim = "end",
				state = {}
			},
			[26] = {
				state = {},
				atkCue = {
					cueList = {
						120013001
					}
				},
				hitCue = {
					cueList = {
						120010002
					}
				}
			},
			[1003] = {
				boxId = 1200162,
				targetChoose = 23,
				eventType = 1,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				120018002,
				120011001
			}
		}
	},
	[1200103] = {
		bhEvent = "skill.1200103",
		atkEvents = {
			{
				boxId = 1200109,
				eventType = 1,
				state = {}
			}
		}
	},
	[1200191] = {
		bhEvent = "skill.1200191",
		atkEvents = {
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						120010005
					}
				}
			},
			{
				boxId = 1200159,
				state = {},
				hitCue = {
					cueList = {
						120011002,
						120010002
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
