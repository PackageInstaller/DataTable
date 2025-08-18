-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13001.lua

local Data = {
	cueFile = "13001",
	[1300101] = {
		bhEvent = "skill.1300101",
		atkEvents = {
			{
				unitDelay = 0.25,
				boxId = 1300109,
				flyCueId = 130010001,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000063,
						130011004
					}
				}
			},
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						130010003,
						130011003
					}
				}
			}
		}
	},
	[1300102] = {
		bhEvent = "skill.1300102",
		atkEvents = {
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						130010011,
						130011005
					}
				}
			},
			{
				unitDelay = 0.08,
				boxId = 1300109,
				flyCueId = 130010012,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130010013,
						130011006
					}
				}
			},
			[1001] = {
				randomTargetNumber = 1,
				boxId = 1300129,
				delay = 0.15,
				boxType = 1,
				targetChoose = 3,
				eventType = 1,
				state = {}
			},
			[1002] = {
				boxId = 1300130,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			}
		}
	},
	[1300151] = {
		hideTime = 10,
		hideEvent = 12,
		videoActTime = 30,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 20,
		actTime = 97,
		bhEvent = "skill.1300151",
		atkEvents = {
			{
				randomTargetNumber = 1,
				hitedAnim = "Hit",
				boxId = 1300159,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130010007,
						10006003
					}
				}
			},
			[12] = {
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						130015004,
						130010009
					}
				}
			},
			[20] = {
				state = {},
				atkCue = {
					cueList = {
						130010010
					}
				}
			},
			[30] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1300102
				},
				atkCue = {
					cueList = {
						130015004,
						130010009
					}
				}
			},
			{
				targetChoose = 7,
				state = {},
				levelAtkEvents = {
					[2] = {
						randomTargetNumber = 1,
						hitedAnim = "Hit",
						boxId = 1300159,
						eventType = 1,
						hitCue = {
							cueList = {
								130010007,
								10006003
							}
						}
					},
					[3] = {
						randomTargetNumber = 1,
						hitedAnim = "Hit",
						boxId = 1300159,
						eventType = 1,
						hitCue = {
							cueList = {
								130010007,
								10006003
							}
						}
					},
					[4] = {
						boxId = 1300159,
						randomTargetNumber = 1,
						eventType = 1,
						hitCue = {
							cueList = {
								130010007
							}
						}
					},
					[5] = {},
					[6] = {}
				}
			},
			[13] = {
				hitedAnim = "end",
				targetChoose = 7,
				state = {}
			},
			[1001] = {
				disablePassive = 1,
				boxId = 1300160,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000078
					}
				}
			},
			[1002] = {
				stunTime = 2,
				eventProbId = 1300102,
				state = {}
			},
			[1003] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1300105
					}
				}
			},
			[1004] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1300105
				}
			},
			{
				targetChoose = 7,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						randomTargetNumber = 1,
						hitedAnim = "Hit",
						boxId = 1300159,
						eventType = 1,
						hitCue = {
							cueList = {
								130010007,
								10006003
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[5] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 3311410
				}
			},
			[1005] = {
				randomTargetNumber = 2,
				delay = 0.1,
				stunTime = 2,
				boxType = 1,
				targetChoose = 7,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				130018002,
				130011007
			}
		}
	},
	[1300191] = {
		bhEvent = "skill.1300191",
		atkEvents = {
			[20] = {
				state = {},
				atkCue = {
					cueList = {
						130010010
					}
				}
			},
			{
				randomTargetNumber = 1,
				boxId = 1300159,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						130011002,
						130010007
					}
				}
			}
		}
	},
	[1300103] = {
		bhEvent = "skill.1300103",
		atkEvents = {
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						130010011,
						130011005
					}
				}
			},
			{
				randomTargetNumber = 3,
				boxId = 1300109,
				unitDelay = 0.08,
				boxType = 1,
				randomRule = 2,
				eventType = 1,
				flyCueId = 130010012,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						130010013,
						130011006
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
