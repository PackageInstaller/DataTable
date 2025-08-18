-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14017.lua

local Data = {
	cueFile = "14017",
	[1401709] = {
		bhEvent = "skill.1401709",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140170001,
						140171001
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 1401709,
				flyCueId = 140170003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140170005,
						140171003
					}
				}
			}
		}
	},
	[1401710] = {
		bhEvent = "skill.1401710",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140170002,
						140171002
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 1401709,
				flyCueId = 140170004,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						140170005,
						140171003
					}
				}
			}
		}
	},
	[1401729] = {
		bhEvent = "skill.1401729",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						140170006,
						140171004
					}
				}
			},
			[0] = {
				unitDelay = 0.16,
				flyCueId = 140170007,
				boxType = 1,
				eventType = 1,
				state = {
					duration = 0.2,
					stateId = 1401702
				},
				hitCue = {
					cueList = {
						140170008,
						140170014,
						140171005
					}
				}
			},
			[4] = {
				targetArea = 3,
				state = {
					stateId = 1401701,
					stateOperation = 4,
					delLayer = 1
				}
			},
			[1001] = {
				boxId = 1401729,
				eventType = 1,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							stateProbId = 1401701,
							stateId = 1000013,
							duration = 5
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1002] = {
				excludeTarget = 1,
				boxId = 1401730,
				targetChoose = 3,
				eventType = 1,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							stateProbId = 1401701,
							stateId = 1000013,
							duration = 5
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1003] = {
				excludeTarget = 1,
				targetChoose = 3,
				eventCondition = "1,1,1401711",
				state = {
					duration = 0.5,
					stateId = 1401721
				}
			},
			[1004] = {
				eventCondition = "1,1,1401711",
				state = {
					duration = 1,
					stateId = 1401716
				}
			},
			[1005] = {
				unitDelay = 0.16,
				flyCueId = 140170007,
				boxType = 1,
				targetChoose = 23,
				eventType = 1,
				state = {
					duration = 0.2,
					stateId = 1401702
				},
				hitCue = {
					cueList = {
						140170008,
						140170014
					}
				}
			},
			[1006] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 8791384
				}
			},
			[1007] = {
				targetChoose = 7,
				state = {
					duration = -999,
					stateId = 1401730
				}
			},
			[1008] = {
				targetArea = 3,
				boxId = 1401770,
				targetChoose = 14,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			[1009] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1401701
				}
			},
			[1010] = {
				eventCondition = "4,2,inControlled,1",
				state = {
					duration = 1,
					stateId = 1401722
				}
			},
			[1011] = {
				eventCondition = "1,2,1401722,1",
				stunTime = 0.2,
				state = {
					chooseStateMode = 2
				}
			},
			[1012] = {
				unitDelay = 0.16,
				flyCueId = 140170007,
				boxType = 1,
				targetChoose = 9,
				eventType = 1,
				state = {
					duration = 0.2,
					stateId = 1401702
				},
				hitCue = {
					cueList = {
						140170008,
						140170014
					}
				}
			}
		}
	},
	[1401759] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 40,
		prepareCamera = 1,
		prepareCamDruation = 20,
		actTime = 60,
		bhEvent = "skill.1401759",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						140170016
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 1401759,
				flyCueId = 140170011,
				boxType = 1,
				eventType = 1,
				state = {
					duration = 1,
					stateId = 1401716
				},
				hitCue = {
					cueList = {
						140170013,
						140171008
					}
				}
			},
			[1001] = {
				targetArea = 1,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1401712,
						1401736,
						1401737,
						1401738
					}
				}
			},
			[1002] = {
				boxId = 1401760,
				disablePassive = 1,
				eventType = 1,
				state = {
					duration = 1,
					stateId = 1401717
				}
			},
			[1003] = {
				boxId = 1401761,
				targetArea = 1,
				disablePassive = 1,
				state = {}
			},
			[1004] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1401701
				}
			},
			[1005] = {
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 5,
							stateId = 1401715
						}
					},
					[3] = {
						state = {
							duration = 5,
							stateId = 1401715
						}
					},
					[4] = {
						state = {
							duration = 4,
							stateId = 1401715
						}
					},
					[5] = {
						state = {
							duration = 4,
							stateId = 1401715
						}
					},
					[6] = {
						state = {
							duration = 4,
							stateId = 1401715
						}
					}
				}
			},
			[1006] = {
				controlTime = 3,
				controlAniName = "idle",
				state = {}
			},
			[1007] = {
				eventCondition = "4,2,inControlled,1",
				state = {
					duration = 3,
					stateId = 1401712
				}
			},
			[1008] = {
				eventCondition = "4,2,inControlled,1",
				state = {
					duration = 5,
					stateId = 1401713
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						140170015,
						140175001,
						140171007
					}
				}
			},
			[14] = {
				state = {},
				atkCue = {
					cueList = {
						140170010,
						140173001
					}
				}
			},
			[1009] = {
				state = {
					duration = 0.5,
					stateId = 1401718
				}
			},
			[1010] = {
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1401717,
						1401732
					}
				}
			},
			[1011] = {
				eventCondition = "1,1,1401733",
				state = {
					duration = 0.1,
					stateId = 1401743
				}
			},
			[1012] = {
				eventCondition = "1,1,1401734",
				state = {
					duration = 0.1,
					stateId = 1401744
				}
			},
			[1013] = {
				eventCondition = "1,1,1401735",
				state = {
					duration = 0.1,
					stateId = 1401745
				}
			},
			[1014] = {
				eventCondition = "4,2,inControlled,1",
				state = {
					duration = 3,
					stateId = 1401736
				}
			},
			[1015] = {
				eventCondition = "4,2,inControlled,1",
				state = {
					duration = 3,
					stateId = 1401737
				}
			},
			[1016] = {
				eventCondition = "4,2,inControlled,1",
				state = {
					duration = 3,
					stateId = 1401738
				}
			},
			[1017] = {
				boxId = 1401762,
				eventType = 1,
				state = {
					duration = 1,
					stateId = 1401732
				}
			},
			[1018] = {
				boxId = 1401763,
				eventType = 1,
				state = {
					duration = 1,
					stateId = 1401732
				}
			},
			[1019] = {
				boxId = 1401764,
				eventType = 1,
				state = {
					duration = 1,
					stateId = 1401732
				}
			},
			[1020] = {
				randomTargetNumber = 1,
				randomRule = 1,
				targetChoose = 7,
				excludeTarget = 1,
				state = {
					duration = 1,
					stateId = 1401716
				}
			}
		},
		videoActCue = {
			cueList = {
				140178001,
				140171006
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
