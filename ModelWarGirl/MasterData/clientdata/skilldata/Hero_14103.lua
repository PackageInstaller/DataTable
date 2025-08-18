-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14103.lua

local Data = {
	cueFile = "14103",
	[1410309] = {
		bhEvent = "skill.1410309",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						141030001,
						141031001
					}
				}
			},
			[10] = {
				state = {}
			},
			[0] = {
				boxId = 1410309,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						141030002
					}
				}
			}
		}
	},
	[1410329] = {
		bhEvent = "skill.1410329",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						141030004,
						141031005
					}
				}
			},
			[1001] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1410302
				}
			},
			[1002] = {
				targetArea = 1,
				state = {
					duration = -999,
					stateId = 1410302
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = 1,
					stateId = 1410303
				}
			},
			[1004] = {
				boxId = 1410329,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						141030005
					}
				}
			},
			[1005] = {
				boxId = 1410330,
				targetArea = 3,
				targetChoose = 11,
				state = {}
			},
			[0] = {
				targetArea = 3,
				summonMonsters = "1620801",
				state = {},
				levelAtkEvents = {
					[2] = {
						summonMonsters = "1620802"
					},
					[3] = {
						summonMonsters = "1620803"
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1006] = {
				summonMonsters = "1620803",
				state = {}
			},
			[1007] = {
				boxId = 8350390,
				targetChoose = 23,
				eventType = 1,
				state = {}
			},
			[1008] = {
				randomTargetNumber = 1,
				targetArea = 3,
				boxId = 1410331,
				targetChoose = 10,
				state = {
					duration = 6,
					stateId = 1410311
				}
			},
			[1009] = {
				targetChoose = 23,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 4,
							stateId = 1410312
						}
					},
					[4] = {
						state = {
							duration = 4,
							stateId = 1410312
						}
					},
					[5] = {
						state = {
							duration = 4,
							stateId = 1410312
						}
					},
					[6] = {
						state = {
							duration = 4,
							stateId = 1410312
						}
					}
				}
			},
			{
				state = {}
			},
			{
				state = {}
			},
			[1010] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = 7,
					stateId = 8791641
				}
			}
		}
	},
	[1410359] = {
		hideEffect = 1,
		actTime = 85,
		videoActTime = 60,
		bhEvent = "skill.1410359",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						141030009,
						141030010
					}
				}
			},
			[0] = {
				boxId = 1410359,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						141030005
					}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						summonMonsters = "1620802"
					},
					[3] = {
						summonMonsters = "1620803"
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				targetChoose = 7,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 6,
							stateId = 1410351
						}
					},
					[4] = {
						state = {
							duration = 6,
							stateId = 1410351
						}
					},
					[5] = {
						state = {
							duration = 6,
							stateId = 1410351
						}
					},
					[6] = {
						state = {
							duration = 6,
							stateId = 1410351
						}
					}
				}
			},
			{
				targetChoose = 16,
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 6,
							stateId = 1410352
						}
					},
					[4] = {
						state = {
							duration = 6,
							stateId = 1410352
						}
					},
					[5] = {
						state = {
							duration = 6,
							stateId = 1410352
						}
					},
					[6] = {
						state = {
							duration = 6,
							stateId = 1410352
						}
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						141030011,
						141035001,
						141031007
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				141038001,
				141031006
			}
		}
	},
	[1410310] = {
		bhEvent = "skill.1410310",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						141030003,
						141031002
					}
				}
			},
			[0] = {
				boxId = 1410309,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						141030002
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
