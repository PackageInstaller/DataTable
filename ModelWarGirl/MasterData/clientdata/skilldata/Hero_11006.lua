-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11006.lua

local Data = {
	cueFile = "11006",
	[1100609] = {
		bhEvent = "skill.1100609",
		atkEvents = {
			[0] = {
				boxId = 1100609,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110060002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110060001,
						110061003
					}
				}
			}
		}
	},
	[1100610] = {
		bhEvent = "skill.1100610",
		atkEvents = {
			[0] = {
				boxId = 1100609,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110060004
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110060003,
						110061004
					}
				}
			}
		}
	},
	[1100629] = {
		bhEvent = "skill.1100629",
		atkEvents = {
			[0] = {
				boxId = 1100629,
				targetChoose = 2,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110060007
					}
				}
			},
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						110060005,
						110060006,
						110061005
					}
				},
				hitCue = {
					cueList = {
						110060001
					}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 5,
							stateId = 1100601
						}
					},
					[3] = {
						addManaNumber = 5,
						state = {
							duration = 5,
							stateId = 1100601
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				boxId = 1100660,
				targetArea = 3,
				disablePassive = 1,
				state = {}
			},
			[1002] = {
				subEventId = 1003,
				targetChoose = 2,
				subEventSkill = 1100629,
				state = {}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1100620
				}
			},
			[1004] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					stateId = 1101101,
					chooseStateMode = 2,
					duration = 20,
					chooseStateIds = {
						1100620
					}
				}
			}
		}
	},
	[1100659] = {
		hideTime = 10,
		videoActTime = 40,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 40,
		actTime = 65,
		bhEvent = "skill.1100659",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						110060008,
						110060009
					}
				}
			},
			[0] = {
				boxId = 1100659,
				targetChoose = 2,
				hitedAnim = "Hit",
				eventType = 1,
				state = {
					duration = 8,
					stateId = 1000001
				},
				atkCue = {
					cueList = {
						110063001
					}
				},
				hitCue = {
					cueList = {
						110060010,
						10006003
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {},
					[4] = {
						state = {}
					},
					[5] = {
						state = {
							duration = 10
						}
					},
					[6] = {
						state = {
							duration = 10
						}
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						110065001,
						110060011,
						110061006
					}
				}
			},
			[2] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 8,
							stateId = 1100604
						}
					},
					[3] = {
						state = {
							duration = 8,
							stateId = 1100604
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 1,
							stateId = 1100603
						}
					},
					[4] = {
						state = {
							duration = 1,
							stateId = 1100603
						}
					},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				boxId = 1100660,
				targetArea = 3,
				disablePassive = 1,
				state = {}
			},
			[99] = {
				state = {},
				atkCue = {
					cueList = {
						110060009
					}
				}
			},
			[33] = {
				state = {},
				hitCue = {
					cueList = {
						110061002
					}
				}
			},
			[90] = {
				hitedAnim = "end",
				targetChoose = 2,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				110068001,
				110061001
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
