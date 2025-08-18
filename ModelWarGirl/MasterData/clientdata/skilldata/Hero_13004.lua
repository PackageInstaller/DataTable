-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_13004.lua

local Data = {
	cueFile = "13004",
	[1300409] = {
		bhEvent = "skill.1300409",
		atkEvents = {
			[0] = {
				unitDelay = 0.08,
				boxId = 1300409,
				flyCueId = 130040001,
				boxType = 1,
				eventType = 1,
				state = {
					duration = 3,
					stateId = 1300402
				},
				hitCue = {
					cueList = {
						10000062,
						130041002
					}
				}
			},
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130041001
					}
				}
			}
		}
	},
	[1300459] = {
		hideTime = 10,
		hideEvent = 100,
		videoActTime = 51,
		hideEffect = 1,
		prepareCamera = 1,
		prepareCamDruation = 30,
		actTime = 55,
		bhEvent = "skill.1300459",
		atkEvents = {
			[100] = {
				targetChoose = 7,
				state = {}
			},
			[0] = {
				boxId = 1300459,
				hitedAnim = "Hit",
				delay = 0.15,
				targetArea = 2,
				eventType = 1,
				flyCueId = 90010021,
				targetChoose = 7,
				state = {},
				atkCue = {
					cueList = {
						130043001
					}
				},
				hitCue = {
					cueList = {
						130040007,
						130041007,
						10006003
					}
				}
			},
			[11] = {
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 1300401
				},
				atkCue = {
					cueList = {
						130040005
					}
				}
			},
			[12] = {
				state = {},
				atkCue = {
					cueList = {
						130040006
					}
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						130045001,
						130040008,
						130041006
					}
				}
			},
			[14] = {
				targetChoose = 7,
				targetArea = 2,
				hitedAnim = "end",
				state = {}
			},
			[1001] = {
				controlTime = 2,
				controlAniName = "freeze",
				state = {}
			},
			[1002] = {
				disablePassive = 1,
				boxType = 1,
				delay = 0.1,
				boxId = 1300461,
				eventType = 1,
				state = {}
			},
			[90] = {
				targetChoose = 7,
				targetArea = 2,
				hitedAnim = "end",
				state = {}
			},
			[1003] = {
				boxId = 1300462,
				boxType = 1,
				eventCondition = "1,2,1300402",
				delay = 0.2,
				eventType = 1,
				disablePassive = 1,
				flyCueId = 130040001,
				targetChoose = 7,
				baseToTarget = 1,
				state = {},
				hitCue = {
					cueList = {
						130040002
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				130048001,
				130041005
			}
		}
	},
	[1300429] = {
		bhEvent = "skill.1300429",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						130040003,
						130041003
					}
				}
			},
			[0] = {
				boxId = 1300460,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						130040004,
						130041004
					}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						addManaNumber = 10,
						hitCue = {
							cueList = {
								10000035
							}
						}
					},
					[3] = {
						addManaNumber = 10,
						hitCue = {
							cueList = {
								10000035
							}
						}
					},
					[4] = {},
					[5] = {},
					[6] = {}
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
