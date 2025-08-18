-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13014.lua

local Data = {
	cueFile = "13014",
	[1301409] = {
		bhEvent = "skill.1301409",
		atkEvents = {
			{
				unitDelay = 0.15,
				boxId = 1301409,
				flyCueId = 130140002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130140003
					}
				}
			},
			[1001] = {
				boxId = 1301410,
				eventType = 1,
				state = {}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130140001,
						130141001
					}
				}
			},
			[1002] = {
				randomTargetNumber = 1,
				boxId = 1301415,
				unitDelay = 0.15,
				boxType = 1,
				excludeTarget = 1,
				eventType = 1,
				flyCueId = 130140002,
				targetChoose = 7,
				state = {
					duration = 0.2,
					stateId = 21301422
				}
			},
			[1003] = {
				boxId = 1301416,
				eventType = 1,
				state = {}
			}
		}
	},
	[1301410] = {
		bhEvent = "skill.1301410",
		atkEvents = {
			{
				unitDelay = 0.15,
				boxId = 1301409,
				flyCueId = 130140005,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130140003
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130140004,
						130141001
					}
				}
			}
		}
	},
	[1301459] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 70,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 25,
		actTime = 75,
		bhEvent = "skill.1301459",
		atkEvents = {
			[1001] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1301407
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 7,
							stateId = 1301407
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				boxType = 1,
				hitedAnim = "Hit",
				subEventSkill = 1301459,
				boxId = 1301459,
				subEventId = 1001,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 1000001
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 7,
							stateId = 1000001
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					chooseStateMode = 2,
					chooseStateIds = {
						1301408
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							stateOperation = 1,
							chooseStateMode = 2,
							chooseStateIds = {
								1301408
							}
						}
					},
					[3] = {
						state = {
							stateOperation = 1,
							chooseStateMode = 2,
							chooseStateIds = {
								1301408
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1003] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							stateOperation = 1,
							chooseStateMode = 2,
							chooseStateIds = {
								1301409
							}
						}
					},
					[3] = {
						state = {
							stateOperation = 1,
							chooseStateMode = 2,
							chooseStateIds = {
								1301409
							}
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
						130140009,
						130140010
					}
				}
			},
			[35] = {
				state = {},
				hitCue = {
					cueList = {
						130140012
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						130140013,
						130145001,
						130141004
					}
				}
			},
			[15] = {
				state = {},
				hitCue = {
					cueList = {
						130140011
					}
				}
			},
			[90] = {
				hitedAnim = "end",
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				130148001,
				130141003
			}
		}
	},
	[1301429] = {
		bhEvent = "skill.1301429",
		atkEvents = {
			[1001] = {
				unitDelay = 0.3,
				boxId = 1301429,
				flyCueId = 130140007,
				boxType = 1,
				targetChoose = 23,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130140008
					}
				}
			},
			[1002] = {
				addManaNumber = 30,
				targetArea = 3,
				state = {}
			},
			[1003] = {
				subEventId = 1001,
				subEventSkill = 1301429,
				targetChoose = 23,
				state = {},
				atkCue = {
					cueList = {
						130140006,
						130141002
					}
				}
			},
			[1004] = {
				targetArea = 1,
				addManaNumber = 20,
				state = {},
				hitCue = {
					cueList = {
						10000035
					}
				}
			},
			[1005] = {
				state = {}
			},
			[1006] = {
				targetArea = 3,
				addManaNumber = 6,
				state = {},
				hitCue = {
					cueList = {
						10000035
					}
				}
			},
			[1007] = {
				unitDelay = 0.3,
				targetChoose = 4,
				flyCueId = 130140007,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 21301431
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
