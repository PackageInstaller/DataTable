-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12108.lua

local Data = {
	cueFile = "12108",
	[1210809] = {
		bhEvent = "skill.1210809",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121080001,
						121081002
					}
				}
			},
			[2] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1210801
				},
				atkCue = {
					cueList = {
						121080025
					}
				}
			},
			{
				subEventType = 1,
				boxId = 1210809,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						121080002
					}
				}
			},
			[1002] = {
				subEventType = 1,
				boxId = 1210860,
				targetChoose = 23,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						121080002
					}
				}
			},
			[5] = {
				subEventId = 1002,
				eventCondition = "1,1,1210811",
				subEventSkill = 1210809,
				targetArea = 3,
				state = {}
			}
		}
	},
	[1210810] = {
		bhEvent = "skill.1210810",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121080003,
						121081001
					}
				}
			},
			[2] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1210801
				},
				atkCue = {
					cueList = {
						121080025
					}
				}
			},
			{
				boxId = 1210809,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						121080004
					}
				}
			},
			[1002] = {
				subEventType = 1,
				boxId = 1210860,
				targetChoose = 23,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						121080004
					}
				}
			},
			[5] = {
				subEventId = 1002,
				eventCondition = "1,1,1210811",
				subEventSkill = 1210810,
				targetArea = 3,
				state = {}
			}
		}
	},
	[1210829] = {
		bhEvent = "skill.1210829",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121081004
					}
				}
			},
			{
				boxId = 1210829,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						121080012
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1210802
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1210803
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1210804
				}
			},
			{
				subEventType = 1,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = -999,
							stateId = 1210805
						}
					},
					[4] = {
						state = {
							duration = -999,
							stateId = 1210805
						}
					},
					[5] = {
						state = {
							duration = -999,
							stateId = 1210805
						}
					},
					[6] = {
						state = {
							duration = -999,
							stateId = 1210805
						}
					}
				}
			},
			{
				subEventType = 1,
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1210805
					}
				}
			},
			{
				subEventType = 1,
				subEventSkill = 1210829,
				summonMonsters = "1620700",
				subEventId = 1022,
				targetArea = 3,
				eventCondition = "4,1,skin,0",
				state = {
					duration = -999,
					stateId = 1210806
				},
				levelAtkEvents = {
					[2] = {
						summonMonsters = "1620701"
					},
					[3] = {
						summonMonsters = "1620702"
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1004] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1210808
				}
			},
			[1005] = {
				randomTargetNumber = 1,
				delay = 1,
				boxId = 1210832,
				boxType = 1,
				targetArea = 3,
				randomRule = 3,
				eventType = 1,
				eventCondition = "1,1,1210808",
				targetChoose = 17,
				state = {
					chooseStateMode = 1,
					stateOperation = 1
				}
			},
			[7] = {
				subEventId = 1006,
				subEventType = 1,
				subEventSkill = 1210829,
				eventCondition = "7,0,1,1210802,0,1,8350330",
				targetArea = 3,
				state = {}
			},
			[1006] = {
				targetChoose = 7,
				subEventType = 1,
				subEventSkill = 1210829,
				subEventId = 1019,
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1210825
				}
			},
			[8] = {
				subEventId = 1024,
				eventCondition = "7,0,1,1210803,0,1,8350331",
				subEventSkill = 1210829,
				targetArea = 3,
				state = {}
			},
			[1010] = {
				subEventId = 1011,
				eventCondition = "7,0,1,1210804,0,1,8350332",
				subEventSkill = 1210829,
				targetArea = 3,
				state = {}
			},
			[1011] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1210822
				}
			},
			[1012] = {
				subEventId = 1013,
				targetArea = 3,
				subEventSkill = 1210829,
				state = {
					stateId = 1210806,
					stateOperation = 4,
					delLayer = 1
				}
			},
			[1013] = {
				subEventId = 1023,
				targetArea = 3,
				subEventSkill = 1210829,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1210808
					}
				}
			},
			[9] = {
				subEventType = 1,
				subEventSkill = 1210829,
				subEventId = 1014,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1210801
				},
				atkCue = {
					cueList = {
						121080025
					}
				}
			},
			[1014] = {
				subEventType = 1,
				subEventSkill = 1210829,
				subEventId = 1015,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1210801
				},
				atkCue = {
					cueList = {
						121080025
					}
				}
			},
			[1015] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1210801
				},
				atkCue = {
					cueList = {
						121080025
					}
				}
			},
			[1016] = {
				targetChoose = 17,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1210817
				}
			},
			[1017] = {
				subEventType = 1,
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1210818
				}
			},
			[1018] = {
				subEventType = 1,
				subEventSkill = 1210829,
				boxId = 1210829,
				targetChoose = 23,
				subEventId = 1025,
				eventType = 1,
				state = {
					duration = 3,
					stateId = 1210809
				},
				hitCue = {
					cueList = {
						121080009,
						121081009
					}
				}
			},
			[1019] = {
				targetChoose = 23,
				state = {
					duration = 5,
					stateId = 1210809
				}
			},
			[1022] = {
				subEventId = 1005,
				subEventSkill = 1210829,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = -999,
							stateId = 1210807
						}
					},
					[3] = {
						state = {
							duration = -999,
							stateId = 1210807
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1023] = {
				targetArea = 3,
				state = {
					stateId = 1210807,
					stateOperation = 4,
					delLayer = 1
				}
			},
			[1024] = {
				boxId = 1210830,
				targetArea = 3,
				state = {}
			},
			[1025] = {
				subEventId = 1026,
				subEventType = 1,
				subEventSkill = 1210829,
				boxId = 1210829,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1026] = {
				subEventId = 1027,
				subEventType = 1,
				subEventSkill = 1210829,
				boxId = 1210829,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1027] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 1210819
				}
			},
			[1028] = {
				subEventType = 1,
				subEventSkill = 1210829,
				summonMonsters = "1620706",
				subEventId = 1029,
				targetArea = 3,
				eventCondition = "4,1,skin,0",
				state = {
					duration = -999,
					stateId = 1210806
				},
				levelAtkEvents = {
					[2] = {
						summonMonsters = "1620707"
					},
					[3] = {
						summonMonsters = "1620708"
					},
					[4] = {
						summonMonsters = "1620700"
					},
					[5] = {
						summonMonsters = "1620700"
					},
					[6] = {
						summonMonsters = "1620700"
					}
				}
			},
			[1029] = {
				subEventId = 1034,
				subEventType = 1,
				subEventSkill = 1210829,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1210807
				}
			},
			{
				subEventType = 1,
				subEventSkill = 1210829,
				summonMonsters = "1620703",
				subEventId = 1022,
				targetArea = 3,
				eventCondition = "4,1,skin,1",
				state = {
					duration = -999,
					stateId = 1210806
				},
				levelAtkEvents = {
					[2] = {
						summonMonsters = "1620704"
					},
					[3] = {
						summonMonsters = "1620705"
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[11] = {
				state = {},
				atkCue = {
					cueList = {
						121080011
					}
				}
			},
			[12] = {
				state = {},
				atkCue = {
					cueList = {
						121080010,
						121086003
					}
				}
			},
			[1030] = {
				subEventType = 1,
				subEventSkill = 1210829,
				summonMonsters = "1620709",
				subEventId = 1029,
				targetArea = 3,
				eventCondition = "4,1,skin,1",
				state = {
					duration = -999,
					stateId = 1210806
				},
				levelAtkEvents = {
					[2] = {
						summonMonsters = "1620710"
					},
					[3] = {
						summonMonsters = "1620711"
					},
					[4] = {
						summonMonsters = "1620703"
					},
					[5] = {
						summonMonsters = "1620703"
					},
					[6] = {
						summonMonsters = "1620703"
					}
				}
			},
			[1031] = {
				subEventType = 1,
				subEventSkill = 1210829,
				boxId = 1210829,
				targetChoose = 23,
				subEventId = 1032,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						121081009,
						121080009
					}
				}
			},
			[1032] = {
				subEventId = 1033,
				subEventType = 1,
				subEventSkill = 1210829,
				boxId = 1210829,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1033] = {
				boxId = 1210829,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1034] = {
				targetChoose = 17,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1210817
				}
			}
		}
	},
	[1210859] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 72,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 40,
		actTime = 96,
		bhEvent = "skill.1210859",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						121080014,
						121080017
					}
				}
			},
			{
				boxId = 1210859,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						121080024,
						121083001
					}
				},
				hitCue = {
					cueList = {
						121080019
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						delay = 999999,
						boxType = 1
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						targetArea = 3,
						state = {
							duration = -999,
							stateId = 1210812
						},
						atkCue = {
							cueList = {
								121080013
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						targetArea = 3,
						state = {
							duration = -999,
							stateId = 1210813
						},
						atkCue = {
							cueList = {
								121080015,
								121080016
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						targetArea = 3,
						state = {
							duration = -999,
							stateId = 1210814
						},
						atkCue = {
							cueList = {
								121082001,
								121080016
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1006] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 1210811
				}
			},
			[1007] = {
				targetChoose = 23,
				state = {
					duration = 5,
					stateId = 1210811
				}
			},
			[7] = {
				subEventType = 1,
				targetArea = 3,
				eventCondition = "7,0,1,1210802,0,1,8350330",
				state = {
					duration = -999,
					stateId = 1210815
				}
			},
			[8] = {
				subEventId = 1008,
				eventCondition = "7,0,1,1210803,0,1,8350331",
				subEventSkill = 1210859,
				targetArea = 3,
				state = {}
			},
			[9] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1210815
					}
				}
			},
			[1008] = {
				targetChoose = 23,
				state = {
					duration = 5,
					stateId = 1210816
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						121085001,
						121080018,
						121080023,
						121081006
					}
				}
			},
			[10] = {
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						subRandomNum = 1,
						subEventSkill = 1210859,
						subRandomEvents = "2,3,4"
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1009] = {
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						subEventId = 1012,
						subEventSkill = 1210859,
						boxId = 1210861,
						targetChoose = 23,
						eventType = 1,
						hitCue = {
							cueList = {
								121080019,
								121083001,
								121080024
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1010] = {
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						subEventId = 1012,
						subEventSkill = 1210859,
						boxId = 1210862,
						targetChoose = 23,
						eventType = 1,
						hitCue = {
							cueList = {
								121080019,
								121083001,
								121080024
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1011] = {
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						subEventId = 1012,
						subEventSkill = 1210859,
						boxId = 1210863,
						targetChoose = 23,
						eventType = 1,
						hitCue = {
							cueList = {
								121083001,
								121080024,
								121080019
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[11] = {
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						eventCondition = "1,1,1210812",
						targetArea = 3,
						subEventSkill = 1210859,
						subEventId = 1009
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[21] = {
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						eventCondition = "1,1,1210813",
						targetArea = 3,
						subEventSkill = 1210859,
						subEventId = 1010
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[31] = {
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						eventCondition = "1,1,1210814",
						targetArea = 3,
						subEventSkill = 1210859,
						subEventId = 1011
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1012] = {
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						targetArea = 3,
						state = {
							stateOperation = 1,
							chooseStateMode = 2,
							chooseStateIds = {
								1210812,
								1210813,
								1210814
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		},
		videoActCue = {
			cueList = {
				121088001,
				121081007
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
