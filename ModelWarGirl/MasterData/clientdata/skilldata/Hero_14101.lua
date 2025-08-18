-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_14101.lua

local Data = {
	cueFile = "14101",
	[1410109] = {
		bhEvent = "skill.1410109",
		atkEvents = {
			[0] = {
				unitDelay = 0.1,
				boxId = 1410109,
				flyCueId = 141010002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						141010003,
						141011002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						141010001,
						141011001
					}
				}
			}
		}
	},
	[1410129] = {
		skillTarget = 1,
		bhEvent = "skill.1410129",
		atkEvents = {
			[0] = {
				boxId = 1410129,
				delay = 0.15,
				targetArea = 2,
				eventType = 1,
				flyCueId = 90010005,
				targetChoose = 4,
				state = {},
				hitCue = {
					cueList = {
						141010005
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 8,
							stateId = 1410102
						}
					},
					[3] = {
						state = {
							duration = 8,
							stateId = 1410102
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
							duration = 2,
							stateId = 1410103
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				targetChoose = 4,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1410104
				}
			},
			[100] = {
				targetArea = 2,
				state = {},
				atkCue = {
					cueList = {
						141010004
					}
				}
			},
			[15] = {
				state = {},
				atkCue = {
					cueList = {
						141011003
					}
				}
			}
		}
	},
	[1410159] = {
		hideTime = 15,
		videoActTime = 70,
		hideEffect = 1,
		skillTarget = 5,
		prepareCamera = 1,
		prepareCamDruation = 40,
		actTime = 75,
		bhEvent = "skill.1410159",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						141010006,
						141010011,
						141010012,
						141010013,
						141010014,
						141010015,
						141010016
					}
				}
			},
			[0] = {
				boxId = 1410159,
				flyCueId = 90010005,
				delay = 0.15,
				targetChoose = 4,
				eventType = 1,
				state = {}
			},
			{
				delay = 0.2,
				boxType = 1,
				targetChoose = 9,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1410160,
						eventType = 1,
						state = {
							duration = 5,
							stateId = 1410101
						}
					},
					[3] = {
						boxId = 1410160,
						eventType = 1,
						state = {
							duration = 5,
							stateId = 1410101
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1001] = {
				addManaNumber = 20,
				targetArea = 3,
				state = {}
			},
			{
				state = {}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						141010009,
						141015001
					}
				}
			},
			[90] = {
				hitedAnim = "end",
				targetChoose = 4,
				state = {}
			},
			[27] = {
				targetChoose = 4,
				hitedAnim = "Hit",
				state = {},
				atkCue = {
					cueList = {
						141013001
					}
				}
			},
			[26] = {
				state = {},
				atkCue = {
					cueList = {
						141011005
					}
				},
				hitCue = {
					cueList = {
						141010007
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				141018001,
				141011004
			}
		}
	},
	[1410160] = {
		shortVideoActTime = 70,
		videoActTime = 70,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 110,
		actTime = 65,
		bhEvent = "skill.1410160",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						141010006
					}
				}
			},
			[0] = {
				boxId = 1410159,
				hitedAnim = "Hit",
				state = {}
			},
			{
				state = {}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						141019001,
						141010009,
						141015001
					}
				}
			},
			{
				hitedAnim = "Hit",
				state = {}
			},
			[90] = {
				hitedAnim = "end",
				state = {}
			},
			[26] = {
				state = {},
				atkCue = {
					cueList = {
						141011005
					}
				},
				hitCue = {
					cueList = {
						141010007
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				141018001,
				141011004
			}
		},
		shortVideoActCue = {
			cueList = {
				141018001,
				141011004
			}
		}
	},
	[1410110] = {
		bhEvent = "skill.1410110",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						141011001,
						141010017
					}
				}
			},
			{
				unitDelay = 0.1,
				flyCueId = 141010018,
				boxType = 1,
				state = {},
				hitCue = {
					cueList = {
						141011002
					}
				}
			},
			[0] = {
				unitDelay = 0.1,
				boxId = 1410109,
				flyCueId = 141010019,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						141010003,
						141011002
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
