-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14102.lua

local Data = {
	cueFile = "14102",
	[1410209] = {
		bhEvent = "skill.1410209",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						141020001,
						141021001
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1410209,
				flyCueId = 141020003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						141020004,
						141021003
					}
				}
			}
		}
	},
	[1410229] = {
		actTime = 50,
		bhEvent = "skill.1410229",
		atkEvents = {
			[100] = {
				targetChoose = 7,
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						141020005,
						141021004
					}
				},
				hitCue = {
					cueList = {
						141020006
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1410201
				}
			},
			[3] = {
				state = {}
			},
			[1001] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1410211
				}
			},
			[1002] = {
				state = {
					duration = 7,
					stateId = 1410212
				}
			},
			[1003] = {
				state = {
					duration = 7,
					stateId = 1000003
				}
			},
			[1004] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8791371
				}
			},
			[1005] = {
				targetArea = 1,
				state = {
					duration = 3,
					stateId = 8791372
				}
			},
			[1006] = {
				targetChoose = 3,
				state = {
					duration = 5,
					stateId = 1000003
				}
			},
			{
				state = {}
			}
		}
	},
	[1410259] = {
		hideTime = 10,
		hideEvent = 1,
		videoActTime = 45,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 45,
		actTime = 87,
		bhEvent = "skill.1410259",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						141020007,
						141020008,
						141020009
					}
				}
			},
			[2] = {
				targetChoose = 4,
				targetArea = 3,
				state = {
					duration = 7,
					stateId = 1410251
				}
			},
			{
				boxId = 1410259,
				hitedAnim = "Hit",
				state = {},
				hitCue = {
					cueList = {
						141020010,
						141023001
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 7,
							stateId = 1410252
						}
					},
					[3] = {
						state = {
							duration = 7,
							stateId = 1410252
						}
					},
					[4] = {
						state = {
							duration = 7
						}
					},
					[5] = {
						state = {
							duration = 7
						}
					},
					[6] = {
						state = {
							duration = 7
						}
					}
				}
			},
			[3] = {
				targetChoose = 7,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = -999,
							stateId = 1410253
						}
					},
					[3] = {
						state = {
							duration = -999,
							stateId = 1410253
						}
					},
					[4] = {
						state = {
							duration = -999
						}
					},
					[5] = {
						state = {
							duration = -999
						}
					},
					[6] = {
						state = {
							duration = -999
						}
					}
				}
			},
			[4] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = -999,
							stateId = 1410254
						}
					},
					[4] = {
						state = {
							duration = -999,
							stateId = 1410254
						}
					},
					[5] = {
						state = {
							duration = -999,
							stateId = 1410254
						}
					},
					[6] = {
						state = {
							duration = -999,
							stateId = 1410254
						}
					}
				}
			},
			[1001] = {
				addManaNumber = 100,
				targetArea = 3,
				state = {}
			},
			[1002] = {
				targetChoose = 23,
				subEventId = 1003,
				subEventSkill = 1410259,
				targetArea = 3,
				state = {}
			},
			[1003] = {
				subEventId = 1004,
				targetChoose = 7,
				subEventSkill = 1410259,
				state = {}
			},
			[1004] = {
				boxId = 1410260,
				eventCondition = "1,2,1410252",
				state = {}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						141020012,
						141025001,
						141021006
					}
				}
			},
			[90] = {
				hitedAnim = "end",
				state = {}
			},
			[1005] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8350270
				}
			}
		},
		videoActCue = {
			cueList = {
				141028001,
				141021005
			}
		}
	},
	[1410210] = {
		bhEvent = "skill.1410210",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						141020002,
						141021002
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 1410209,
				flyCueId = 141020003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						141020004,
						141021003
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
