-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11201.lua

local Data = {
	cueFile = "11201",
	[1120101] = {
		bhEvent = "skill.1120101",
		atkEvents = {
			{
				boxId = 1120109,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						112010001,
						112011001
					}
				}
			}
		}
	},
	[1120102] = {
		bhEvent = "skill.1120102",
		atkEvents = {
			{
				boxId = 1120109,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[100] = {
				targetArea = 2,
				state = {},
				atkCue = {
					cueList = {
						112010002,
						112011002
					}
				}
			}
		}
	},
	[1120121] = {
		bhEvent = "skill.1120121",
		atkEvents = {
			{
				boxId = 1120129,
				eventType = 1,
				state = {}
			},
			{
				targetArea = 3,
				state = {
					duration = 2,
					stateId = 1120102
				}
			},
			[1001] = {
				boxId = 1120130,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						addManaNumber = 10
					},
					[3] = {
						addManaNumber = 10
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
						112010003,
						112011003
					}
				}
			},
			[5] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = -999,
							stateId = 1120104
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
			[1002] = {
				targetArea = 2,
				subEventSkill = 1120121,
				boxId = 1120159,
				targetChoose = 21,
				subEventId = 1003,
				state = {},
				hitCue = {
					cueList = {
						112010013
					}
				}
			},
			[1003] = {
				boxId = 1120160,
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						10000047
					}
				}
			},
			[1004] = {
				addManaNumber = 45,
				targetArea = 3,
				state = {}
			},
			[1005] = {
				randomTargetNumber = 1,
				subEventId = 1006,
				subEventSkill = 1120121,
				targetChoose = 19,
				state = {}
			},
			[1006] = {
				boxType = 1,
				subEventSkill = 1120121,
				boxId = 1120131,
				targetChoose = 4,
				subEventId = 1007,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						112010005
					}
				}
			},
			[1007] = {
				boxId = 1120132,
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1008] = {
				targetChoose = 21,
				targetArea = 2,
				state = {
					duration = 1.1,
					stateId = 1120108
				}
			},
			[1009] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1120107
					}
				}
			}
		}
	},
	[1120151] = {
		hideEffect = 1,
		actTime = 90,
		videoActTime = 64,
		skillTarget = 1,
		bhEvent = "skill.1120151",
		atkEvents = {
			{
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						112016001,
						112010008,
						112010014
					}
				}
			},
			[100] = {
				state = {},
				baseCue = {
					cueList = {
						112010007
					}
				}
			},
			[1001] = {
				subEventId = 1003,
				boxId = 1120159,
				targetArea = 2,
				eventType = 1,
				disablePassive = 1,
				subEventSkill = 1120121,
				targetChoose = 21,
				state = {},
				hitCue = {
					cueList = {
						112010013
					}
				}
			},
			{
				subEventId = 1005,
				targetArea = 2,
				subEventSkill = 1120151,
				state = {
					stateOperation = 1,
					stateId = 1120101,
					chooseStateMode = 2,
					duration = -999,
					chooseStateIds = {
						1110201
					}
				}
			},
			[1002] = {
				targetArea = 2,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1120101
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						addManaNumber = 20
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1003] = {
				delay = 0.1,
				boxId = 1120160,
				targetArea = 2,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						10000047
					}
				}
			},
			[1004] = {
				targetArea = 2,
				state = {
					duration = 0.1,
					stateId = 1120105
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						112010019,
						112015001,
						112011006
					}
				}
			},
			[1005] = {
				addManaNumber = 99,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1120101
				}
			}
		},
		videoActCue = {
			cueList = {
				112018001,
				112011007
			}
		}
	},
	[1120103] = {
		bhEvent = "skill.1120103",
		atkEvents = {
			{
				state = {},
				hitCue = {
					cueList = {
						112010005
					}
				}
			},
			[100] = {
				boxId = 1120109,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						112010004,
						112011004
					}
				}
			}
		}
	},
	[1120122] = {
		bhEvent = "skill.1120122",
		atkEvents = {
			[2] = {
				targetArea = 2,
				state = {
					duration = 2,
					stateId = 1120102
				}
			},
			{
				boxId = 1120129,
				targetChoose = 1,
				eventType = 1,
				state = {}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						112010006,
						112011005
					}
				}
			},
			[5] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = -999,
							stateId = 1120104
						}
					},
					[4] = {
						state = {
							duration = -999,
							stateId = 1120104
						}
					},
					[5] = {
						state = {
							duration = -999,
							stateId = 1120104
						}
					},
					[6] = {
						state = {
							duration = -999,
							stateId = 1120104
						}
					}
				}
			}
		}
	},
	[1120152] = {
		actTime = 90,
		skillTarget = 1,
		bhEvent = "skill.1120152",
		atkEvents = {
			[100] = {
				targetArea = 2,
				state = {
					chooseStateMode = 2
				},
				atkCue = {
					cueList = {
						112010009,
						112010015,
						112010016,
						112010018,
						112010017,
						112011008
					}
				}
			},
			{
				targetArea = 2,
				state = {
					chooseStateMode = 2
				},
				atkCue = {
					cueList = {
						112016002,
						112010010
					}
				}
			},
			{
				targetArea = 2,
				state = {
					chooseStateMode = 2
				}
			},
			[99] = {
				hitedAnim = "end",
				targetArea = 2,
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
