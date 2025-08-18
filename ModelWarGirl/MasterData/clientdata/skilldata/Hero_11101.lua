-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11101.lua

local Data = {
	cueFile = "11101",
	[1110109] = {
		bhEvent = "skill.1110109",
		atkEvents = {
			{
				boxId = 1110109,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						111010002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						111010001
					}
				}
			}
		}
	},
	[1110110] = {
		bhEvent = "skill.1110110",
		atkEvents = {
			{
				boxId = 1110109,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						111010002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						111010003
					}
				}
			}
		}
	},
	[1110129] = {
		skillTarget = 1,
		bhEvent = "skill.1110129",
		atkEvents = {
			[0] = {
				targetArea = 3,
				state = {}
			},
			[1001] = {
				randomTargetNumber = 1,
				boxId = 1110129,
				targetChoose = 3,
				targetArea = 2,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						111010010,
						111011006
					}
				},
				hitCue = {
					cueList = {
						111010011
					}
				}
			},
			[100] = {
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 1110104
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 4,
							stateId = 1110104
						}
					},
					[4] = {
						state = {
							duration = 4,
							stateId = 1110104
						}
					},
					[5] = {},
					[6] = {}
				}
			},
			[1002] = {
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 1110104,
					chooseStateMode = 2,
					chooseStateIds = {
						1110104
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 4,
							stateId = 1110104,
							chooseStateMode = 2,
							chooseStateIds = {
								1110104
							}
						}
					},
					[4] = {
						state = {
							duration = 4,
							stateId = 1110104,
							chooseStateMode = 2,
							chooseStateIds = {
								1110104
							}
						}
					},
					[5] = {},
					[6] = {}
				}
			},
			[1003] = {
				state = {}
			}
		}
	},
	[1110159] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 71,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 37,
		actTime = 69,
		bhEvent = "skill.1110159",
		atkEvents = {
			[2] = {
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 1110101
				},
				levelAtkEvents = {
					[2] = {
						targetChoose = 4
					},
					[3] = {
						targetChoose = 4
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			{
				hitedAnim = "Hit",
				boxId = 1110159,
				eventType = 1,
				state = {},
				atkCue = {
					cueList = {
						111013001
					}
				},
				hitCue = {
					cueList = {
						111010007,
						111011005,
						10006003
					}
				}
			},
			[3] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 2,
							stateId = 1110102
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
						111010006
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						111015001,
						111010008,
						111011004
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
				111018001,
				111011003
			}
		}
	},
	[1110160] = {
		shortVideoActTime = 70,
		videoActTime = 71,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 105,
		actTime = 78,
		bhEvent = "skill.1110160",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						111010006
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						111010008,
						111015001,
						111011004
					}
				}
			},
			[2] = {
				state = {}
			},
			{
				boxId = 1110159,
				hitedAnim = "Hit",
				state = {},
				atkCue = {
					cueList = {
						111013001
					}
				},
				hitCue = {
					cueList = {
						111010007,
						111011005
					}
				}
			},
			[3] = {
				state = {}
			},
			[90] = {
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				111018001,
				111011003
			}
		},
		shortVideoActCue = {
			cueList = {
				111018001,
				111011003
			}
		}
	},
	[1110191] = {
		bhEvent = "skill.1110191",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						111010006
					}
				}
			},
			{
				boxId = 1110159,
				state = {},
				hitCue = {
					cueList = {
						111010007,
						111011005
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
