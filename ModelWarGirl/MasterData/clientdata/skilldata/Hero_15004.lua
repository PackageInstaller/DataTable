-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_15004.lua

local Data = {
	cueFile = "15004",
	[1500409] = {
		bhEvent = "skill.1500409",
		atkEvents = {
			[0] = {
				unitDelay = 0.12,
				boxId = 1500409,
				flyCueId = 150040002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						150040003,
						150041003
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						150040001,
						150041006
					}
				}
			},
			{
				state = {}
			}
		}
	},
	[1500410] = {
		bhEvent = "skill.1500410",
		atkEvents = {
			[0] = {
				unitDelay = 0.08,
				boxId = 1500409,
				flyCueId = 90010003,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						150040001
					}
				}
			}
		}
	},
	[1500459] = {
		hideTime = 10,
		videoActTime = 83,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 50,
		bhEvent = "skill.1500459",
		atkEvents = {
			[100] = {
				state = {}
			},
			[0] = {
				targetArea = 3,
				boxId = 1500459,
				targetChoose = 10,
				state = {},
				hitCue = {
					cueList = {
						150040007
					}
				}
			},
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						150040009
					}
				}
			},
			{
				randomTargetNumber = 2,
				recordSkillTargets = 1,
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						150040006,
						150041002
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 5,
							stateId = 1000003
						}
					},
					[3] = {
						state = {
							duration = 5,
							stateId = 1000003
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				targetChoose = 10,
				excludeTarget = 1,
				targetArea = 3,
				addManaNumber = 16,
				state = {},
				levelAtkEvents = {
					[2] = {
						addManaNumber = 20
					},
					[3] = {
						addManaNumber = 24
					},
					[4] = {
						addManaNumber = 24
					},
					[5] = {
						addManaNumber = 20
					},
					[6] = {
						addManaNumber = 20
					}
				}
			},
			{
				targetChoose = 12,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 5,
							stateId = 1500403
						}
					},
					[3] = {
						state = {
							duration = 5,
							stateId = 1500403
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						150040008,
						150045001
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				150048002,
				150041001
			}
		}
	},
	[1500460] = {
		actTime = 50,
		videoActTime = 83,
		hideTime = 10,
		prepareCamDruation = 30,
		prepareCamera = 1,
		bhEvent = "skill.1500460",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						150040001
					}
				}
			},
			[0] = {
				targetChoose = 7,
				excludeTarget = 1,
				targetArea = 3,
				addManaNumber = 80,
				state = {},
				hitCue = {
					cueList = {
						150040007
					}
				}
			},
			[10] = {
				state = {}
			},
			{
				state = {},
				atkCue = {
					cueList = {
						150040006
					}
				}
			},
			[3] = {
				state = {}
			},
			{
				state = {}
			},
			[13] = {
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				150048002,
				150041005
			}
		}
	},
	[1500429] = {
		actTime = 30,
		skillTarget = 1,
		bhEvent = "skill.1500429",
		atkEvents = {
			[100] = {
				targetChoose = 3,
				recordSkillTargets = 1,
				targetArea = 3,
				excludeTarget = 1,
				state = {},
				atkCue = {
					cueList = {
						150040004
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						targetChoose = 7
					},
					[4] = {
						targetChoose = 4
					},
					[5] = {
						targetChoose = 4
					},
					[6] = {
						targetChoose = 4
					}
				}
			},
			{
				targetChoose = 12,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1500402
				},
				hitCue = {
					cueList = {
						150040005,
						150041004
					}
				}
			},
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						150041007
					}
				}
			},
			[1001] = {
				targetChoose = 18,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 82150041
				}
			},
			[1002] = {
				targetChoose = 10,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 1500404
				}
			},
			[1003] = {
				boxId = 1500429,
				targetArea = 1,
				state = {}
			},
			[1004] = {
				boxType = 1,
				delay = 0.1,
				boxId = 1500430,
				targetArea = 1,
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
