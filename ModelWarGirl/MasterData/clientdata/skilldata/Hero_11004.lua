-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11004.lua

local Data = {
	cueFile = "10001",
	[1100401] = {
		bhEvent = "skill.1100401",
		atkEvents = {
			[0] = {
				boxId = 1100409,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[99] = {
				state = {},
				atkCue = {
					cueList = {
						100011004
					}
				}
			}
		}
	},
	[1100402] = {
		bhEvent = "skill.1100402",
		atkEvents = {
			[0] = {
				boxId = 1100409,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[99] = {
				state = {},
				atkCue = {
					cueList = {
						100011005
					}
				}
			}
		}
	},
	[1100421] = {
		skillTarget = 1,
		bhEvent = "skill.1100421",
		atkEvents = {
			{
				targetArea = 1,
				boxId = 1100429,
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						100011003
					}
				},
				hitCue = {
					cueList = {
						10000025
					}
				},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 10,
							stateId = 1100403
						}
					},
					[3] = {
						state = {
							duration = 15,
							stateId = 1100403
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				state = {}
			}
		}
	},
	[1100451] = {
		actTime = 110,
		prepareCamDruation = 20,
		prepareCamera = 1,
		bhEvent = "skill.1100451",
		atkEvents = {
			{
				targetArea = 2,
				hitedAnim = "Hit",
				boxId = 1100451,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						100010004
					}
				}
			},
			[10] = {
				state = {},
				hitCue = {
					cueList = {
						100010003
					}
				}
			},
			{
				hitedAnim = "Hit",
				boxId = 1100452,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						100010003
					}
				}
			},
			[11] = {
				state = {},
				atkCue = {
					cueList = {
						100015001,
						100010005,
						100011001
					}
				}
			},
			[13] = {
				hitedAnim = "end",
				targetChoose = 3,
				state = {}
			}
		}
	},
	[1100452] = {
		actTime = 51,
		bhEvent = "skill.1100452",
		atkEvents = {
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						10000012,
						10001001,
						100011001
					}
				}
			},
			[2] = {
				state = {},
				hitCue = {
					cueList = {
						100010003,
						10006003
					}
				}
			},
			{
				boxId = 1100452,
				eventType = 1,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 5,
							stateId = 1000006
						}
					},
					[3] = {
						state = {
							duration = 5,
							stateId = 1000006
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[3] = {
				state = {
					duration = 10,
					stateId = 1100402
				}
			}
		}
	},
	[1100422] = {
		skillTarget = 1,
		bhEvent = "skill.1100422",
		atkEvents = {
			{
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 1110101
				},
				hitCue = {
					cueList = {
						10000008,
						100011003
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 15,
							stateId = 1110101
						}
					},
					[4] = {
						state = {
							duration = 15,
							stateId = 1110101
						}
					},
					[5] = {},
					[6] = {}
				}
			},
			{
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							chooseStateType = 2,
							stateOperation = 1,
							chooseStateMode = 1
						}
					},
					[3] = {
						state = {
							chooseStateType = 2,
							stateOperation = 1,
							chooseStateMode = 1
						}
					},
					[4] = {
						state = {
							chooseStateType = 2,
							stateOperation = 1,
							chooseStateMode = 1
						}
					},
					[5] = {},
					[6] = {}
				}
			}
		}
	},
	[1100453] = {
		actTime = 60,
		bhEvent = "skill.1100453",
		atkEvents = {
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						10002001,
						100019001,
						100011001,
						10001001
					}
				}
			},
			[2] = {
				state = {},
				hitCue = {
					cueList = {
						100010007
					}
				}
			},
			[3] = {
				state = {}
			},
			{
				boxId = 1110160,
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
