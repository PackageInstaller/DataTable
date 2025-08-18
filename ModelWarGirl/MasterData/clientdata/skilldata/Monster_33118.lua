-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Monster_33118.lua

local Data = {
	cueFile = "33118",
	[3311801] = {
		bhEvent = "skill.3311801",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331180001,
						331181001
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 3311801,
				flyCueId = 331180002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331180004,
						331181002
					}
				}
			},
			{
				unitDelay = 0.12,
				boxId = 3311801,
				flyCueId = 331180003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331180004,
						331181002
					}
				}
			}
		}
	},
	[3311802] = {
		bhEvent = "skill.3311802",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331180022,
						331181003
					}
				}
			},
			[10] = {
				state = {}
			},
			{
				boxId = 3311802,
				targetChoose = 4,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331180023
					}
				}
			}
		}
	},
	[3311803] = {
		bhEvent = "skill.3311803",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331180005,
						331181004
					}
				}
			},
			{
				unitDelay = 0.1,
				boxId = 3311803,
				flyCueId = 331180007,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331180008,
						331181005
					}
				}
			},
			[11] = {
				unitDelay = 0.1,
				flyCueId = 331180006,
				boxType = 1,
				state = {},
				hitCue = {
					cueList = {
						331180008
					}
				}
			}
		}
	},
	[3311821] = {
		actTime = 45,
		skillTarget = 1,
		bhEvent = "skill.3311821",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331180009,
						331189001,
						331181006
					}
				}
			},
			{
				targetArea = 3,
				summonMonsters = "0",
				state = {}
			},
			{
				targetArea = 3,
				summonMonsters = "0",
				state = {}
			},
			[10] = {
				state = {}
			},
			[99] = {
				state = {},
				atkCue = {
					cueList = {
						331180010
					}
				}
			}
		}
	},
	[3311831] = {
		actTime = 50,
		bhEvent = "skill.3311831",
		atkEvents = {
			[0] = {
				state = {}
			},
			{
				targetChoose = 7,
				targetArea = 3,
				state = {}
			},
			[100] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3311802
					}
				},
				atkCue = {
					cueList = {
						331189001,
						331180024,
						331181007
					}
				}
			},
			[1001] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3311827,
					chooseStateMode = 2,
					chooseStateIds = {
						3311828
					}
				}
			}
		}
	},
	[3311841] = {
		bhEvent = "skill.3311841",
		atkEvents = {
			[100] = {
				state = {}
			},
			{
				flyCueId = 331180012,
				unitDelay = 0.12,
				boxId = 3311841,
				targetChoose = 19,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331180013,
						331180017,
						331181008
					}
				}
			}
		}
	},
	[3311842] = {
		bhEvent = "skill.3311842",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331180014,
						331181009
					}
				}
			},
			{
				randomTargetNumber = 3,
				boxId = 3311842,
				unitDelay = 0.12,
				boxType = 1,
				eventType = 1,
				flyCueId = 331180015,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						331180016
					}
				}
			}
		}
	},
	[3311851] = {
		actTime = 85,
		skillTarget = 1,
		bhEvent = "skill.3311851",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331181011
					}
				}
			},
			{
				randomTargetNumber = 1,
				boxId = 3311851,
				delay = 0.1,
				boxType = 1,
				eventType = 1,
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						331180018
					}
				},
				hitCue = {
					cueList = {
						331180019,
						331181012
					}
				}
			}
		}
	},
	[3311852] = {
		actTime = 35,
		bhEvent = "skill.3311852",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331180026,
						331181013
					}
				}
			},
			{
				controlTime = 2,
				controlAniName = "Float",
				boxId = 3311852,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331180027
					}
				}
			}
		}
	},
	[3311853] = {
		actTime = 100,
		skillTarget = 1,
		bhEvent = "skill.3311853",
		atkEvents = {
			[100] = {
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						331180020,
						331181014
					}
				},
				hitCue = {
					cueList = {
						331180021
					}
				}
			},
			{
				delay = 0.1,
				boxId = 3311853,
				boxType = 1,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10005008,
						10003001
					}
				}
			},
			{
				delay = 0.1,
				boxId = 3311853,
				boxType = 1,
				targetChoose = 7,
				eventType = 1,
				state = {
					duration = 5,
					stateId = 3311801
				},
				hitCue = {
					cueList = {
						10005008,
						10003001
					}
				}
			},
			[1001] = {
				boxId = 3311860,
				disablePassive = 1,
				eventType = 1,
				state = {}
			}
		}
	},
	[3311854] = {
		actTime = 60,
		bhEvent = "skill.3311854",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331180028,
						331181015
					}
				}
			},
			{
				unitDelay = 0.15,
				boxId = 3311854,
				flyCueId = 331180029,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						331180030,
						331181016
					}
				}
			}
		}
	},
	[3311822] = {
		actTime = 45,
		skillTarget = 1,
		bhEvent = "skill.3311823",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331180009,
						331189001,
						331181006
					}
				}
			},
			{
				summonLineChoose = 3,
				targetArea = 3,
				summonMonsters = "40302022",
				state = {}
			},
			{
				targetArea = 3,
				summonMonsters = "0",
				state = {}
			},
			[99] = {
				state = {},
				atkCue = {
					cueList = {
						331180010
					}
				}
			},
			[10] = {
				state = {}
			}
		}
	},
	[3311823] = {
		actTime = 45,
		skillTarget = 1,
		bhEvent = "skill.3311823",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						331180009,
						331189001,
						331181006
					}
				}
			},
			{
				summonLineChoose = 3,
				targetArea = 3,
				summonMonsters = "40302032",
				state = {}
			},
			{
				targetArea = 3,
				summonMonsters = "0",
				state = {}
			},
			[99] = {
				state = {},
				atkCue = {
					cueList = {
						331180010
					}
				}
			}
		}
	},
	[3311824] = {
		actTime = 45,
		skillTarget = 1,
		bhEvent = "skill.3311824",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331180009,
						331189001,
						331181006
					}
				}
			},
			{
				summonLineChoose = 1,
				targetArea = 3,
				summonMonsters = "40302042",
				state = {}
			},
			{
				summonLineChoose = 3,
				targetArea = 3,
				summonMonsters = "40302043",
				state = {}
			},
			[99] = {
				state = {},
				atkCue = {
					cueList = {
						331180010
					}
				}
			}
		}
	},
	[3311825] = {
		actTime = 45,
		skillTarget = 1,
		bhEvent = "skill.3311825",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331180009,
						331189001,
						331181006
					}
				}
			},
			{
				summonLineChoose = 1,
				targetArea = 3,
				summonMonsters = "40302052",
				state = {}
			},
			{
				summonLineChoose = 3,
				targetArea = 3,
				summonMonsters = "40302053",
				state = {}
			},
			[99] = {
				state = {},
				atkCue = {
					cueList = {
						331180010
					}
				}
			}
		}
	},
	[3311826] = {
		actTime = 45,
		skillTarget = 1,
		bhEvent = "skill.3311826",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331180008,
						331189001,
						331181006
					}
				}
			},
			{
				summonLineChoose = 1,
				targetArea = 3,
				summonMonsters = "40302062",
				state = {}
			},
			{
				summonLineChoose = 3,
				targetArea = 3,
				summonMonsters = "40302063",
				state = {}
			},
			[99] = {
				state = {},
				atkCue = {
					cueList = {
						331180010
					}
				}
			}
		}
	},
	[3311827] = {
		actTime = 45,
		skillTarget = 1,
		bhEvent = "skill.3311827",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331180009,
						331189001,
						331181006
					}
				}
			},
			{
				summonLineChoose = 1,
				targetArea = 3,
				summonMonsters = "40302072",
				state = {}
			},
			{
				summonLineChoose = 3,
				targetArea = 3,
				summonMonsters = "40302073",
				state = {}
			},
			[99] = {
				state = {},
				atkCue = {
					cueList = {
						331180010
					}
				}
			},
			[10] = {
				state = {}
			}
		}
	},
	[3311832] = {
		actTime = 50,
		skillTarget = 1,
		bhEvent = "skill.3311832",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						3311802
					}
				},
				atkCue = {
					cueList = {
						331189001,
						331180024,
						331181007
					}
				}
			},
			{
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3311803
				}
			},
			[1001] = {
				targetArea = 3,
				boxId = 3311832,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						10000008,
						10000045
					}
				}
			}
		}
	},
	[3311828] = {
		actTime = 45,
		skillTarget = 1,
		bhEvent = "skill.3311828",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331180009,
						331189001,
						331181006
					}
				}
			},
			[10] = {
				state = {}
			},
			[99] = {
				state = {},
				atkCue = {
					cueList = {
						331180010
					}
				}
			},
			{
				summonLineChoose = 1,
				targetArea = 3,
				summonMonsters = "40302082",
				state = {}
			},
			{
				summonLineChoose = 3,
				targetArea = 3,
				summonMonsters = "40302083",
				state = {}
			}
		}
	},
	[3311829] = {
		actTime = 45,
		skillTarget = 1,
		bhEvent = "skill.3311829",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331180009,
						331189001,
						331181006
					}
				}
			},
			[10] = {
				state = {}
			},
			[99] = {
				state = {},
				atkCue = {
					cueList = {
						331180010
					}
				}
			},
			{
				summonLineChoose = 1,
				targetArea = 3,
				summonMonsters = "40302092",
				state = {}
			},
			{
				summonLineChoose = 3,
				targetArea = 3,
				summonMonsters = "40302093",
				state = {}
			}
		}
	},
	[3311855] = {
		actTime = 60,
		bhEvent = "skill.3311854",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331180028,
						331181015
					}
				}
			},
			{
				controlTime = 5,
				boxType = 1,
				flyCueId = 331180029,
				boxId = 3311856,
				unitDelay = 0.15,
				controlAniName = "freeze",
				state = {
					duration = 5,
					stateId = 3311805
				},
				hitCue = {
					cueList = {
						331180030,
						331181016
					}
				}
			},
			[1001] = {
				boxId = 3311855,
				disablePassive = 1,
				eventType = 1,
				state = {}
			}
		}
	},
	[3311830] = {
		actTime = 45,
		skillTarget = 1,
		bhEvent = "skill.3311830",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331180009,
						331189001,
						331181006
					}
				}
			},
			{
				summonLineChoose = 1,
				targetArea = 3,
				summonMonsters = "40302102",
				state = {}
			},
			[99] = {
				state = {},
				atkCue = {
					cueList = {
						331180035
					}
				}
			},
			{
				state = {}
			},
			[10] = {
				state = {}
			}
		}
	},
	[3311833] = {
		actTime = 60,
		bhEvent = "skill.3311821",
		atkEvents = {
			[100] = {
				state = {}
			},
			{
				boxId = 3311833,
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 3311806
				}
			},
			{
				targetChoose = 7,
				state = {
					duration = 5,
					stateId = 3311807
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 3311809
				}
			},
			[10] = {
				state = {}
			},
			[99] = {
				state = {}
			},
			[1002] = {
				targetArea = 3,
				stunTime = 5,
				state = {
					duration = -999,
					stateId = 3311810
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = 5,
					stateId = 3311821
				}
			}
		}
	},
	[3311843] = {
		bhEvent = "skill.3311842",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331180014,
						331181009
					}
				}
			},
			{
				randomTargetNumber = 3,
				boxId = 3311842,
				unitDelay = 0.12,
				boxType = 1,
				subEventSkill = 3311843,
				subEventId = 1001,
				eventType = 1,
				flyCueId = 331180015,
				targetChoose = 7,
				state = {},
				hitCue = {
					cueList = {
						331180016
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1000002,
						1000004,
						1000006
					}
				}
			}
		}
	},
	[3311856] = {
		actTime = 85,
		bhEvent = "skill.3311851",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331181011
					}
				}
			},
			{
				randomTargetNumber = 1,
				boxId = 3311851,
				delay = 0.1,
				boxType = 1,
				randomRule = 6,
				eventType = 1,
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						331180018
					}
				},
				hitCue = {
					cueList = {
						331180019,
						331181012
					}
				}
			}
		}
	},
	[3311834] = {
		actTime = 45,
		bhEvent = "skill.3311830",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331180009,
						331189001,
						331181006
					}
				}
			},
			[99] = {
				state = {},
				atkCue = {
					cueList = {
						331180035
					}
				}
			},
			{
				summonLineChoose = 1,
				targetArea = 3,
				summonMonsters = "40302202",
				state = {}
			},
			{
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3311824
				}
			},
			[10] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 3311823
				}
			},
			[1001] = {
				targetChoose = 16,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3312003
				}
			}
		}
	},
	[3311835] = {
		actTime = 45,
		bhEvent = "skill.3311830",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						331180009,
						331189001,
						331181006
					}
				}
			},
			[10] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 3311823
				}
			},
			[99] = {
				state = {},
				atkCue = {
					cueList = {
						331180035
					}
				}
			},
			{
				summonLineChoose = 1,
				targetArea = 3,
				summonMonsters = "40302302",
				state = {}
			},
			{
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3311824
				}
			},
			[1001] = {
				targetChoose = 16,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 3312003
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
