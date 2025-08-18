-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11104.lua

local Data = {
	cueFile = "11104",
	[1110409] = {
		bhEvent = "skill.1110409",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						111040001,
						111040005,
						111040006,
						111041001
					}
				}
			},
			{
				boxId = 1110409,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						111040002
					}
				}
			},
			{
				boxId = 1110410,
				targetArea = 3,
				disablePassive = 1,
				state = {}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1110409
				}
			},
			{
				state = {}
			}
		}
	},
	[1110410] = {
		bhEvent = "skill.1110410",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						111040003,
						111040005,
						111040006,
						111041002
					}
				}
			},
			{
				boxId = 1110409,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						111040004
					}
				}
			},
			{
				boxId = 1110410,
				targetArea = 3,
				state = {}
			},
			{
				state = {}
			}
		}
	},
	[1110429] = {
		bhEvent = "skill.1110429",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {
					duration = 4,
					stateId = 1110403
				},
				atkCue = {
					cueList = {
						111040007,
						111040008,
						111040009,
						111041003
					}
				}
			},
			[1001] = {
				targetArea = 3,
				state = {
					duration = 4,
					stateId = 1110402
				}
			},
			[101] = {
				targetArea = 3,
				state = {
					duration = 3,
					stateId = 1110401
				}
			},
			{
				boxId = 1110429,
				targetChoose = 7,
				eventType = 1,
				state = {}
			},
			[99] = {
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1110401
					}
				}
			},
			{
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1110402,
						1110403
					}
				}
			},
			{
				targetChoose = 7,
				stunTime = 1,
				state = {}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1110433
					},
					[3] = {
						boxId = 1110433
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			},
			[1002] = {
				boxId = 1110430,
				targetArea = 3,
				disablePassive = 1,
				state = {}
			},
			[1003] = {
				targetChoose = 3,
				targetArea = 3,
				state = {
					duration = 4,
					stateId = 1110412
				}
			},
			[1004] = {
				boxId = 1110431,
				targetArea = 1,
				state = {}
			},
			[1005] = {
				targetChoose = 10,
				targetArea = 3,
				state = {
					duration = 6,
					stateId = 8350340
				}
			},
			[1006] = {
				boxId = 1110432,
				targetArea = 3,
				targetChoose = 10,
				state = {}
			},
			[1007] = {
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8350341
				}
			},
			[1008] = {
				targetChoose = 3,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = 3,
					stateId = 1110413
				}
			},
			[1009] = {
				targetChoose = 7,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 8350342
				}
			},
			[1010] = {
				targetChoose = 10,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = 6,
					stateId = 1110404
				}
			},
			[1011] = {
				targetArea = 3,
				state = {
					duration = 12,
					stateId = 1110404
				}
			},
			[1012] = {
				eventCondition = "1,1,1110404",
				targetArea = 3,
				state = {
					duration = 4,
					stateId = 1110455
				}
			},
			[1013] = {
				eventCondition = "1,1,1110404",
				targetArea = 3,
				state = {
					stateOperation = 1,
					chooseStateMode = 2,
					chooseStateIds = {
						1110404
					}
				}
			},
			[1014] = {
				addManaNumber = -20,
				targetChoose = 7,
				state = {
					duration = 5,
					stateId = 8791571
				}
			}
		}
	},
	[1110459] = {
		hideEffect = 1,
		actTime = 115,
		videoActTime = 60,
		bhEvent = "skill.1110459",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						111040010
					}
				}
			},
			{
				boxId = 1110459,
				targetChoose = 7,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						111040012
					}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 6,
							stateId = 1110452
						}
					},
					[3] = {
						state = {
							duration = 6,
							stateId = 1110452
						}
					},
					[4] = {
						state = {
							duration = 6
						}
					},
					[5] = {
						state = {
							duration = 6
						}
					},
					[6] = {
						state = {
							duration = 6
						}
					}
				}
			},
			[5] = {
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						state = {
							duration = 3,
							stateId = 1110451
						}
					},
					[3] = {
						state = {
							duration = 3,
							stateId = 1110451
						}
					},
					[4] = {
						state = {
							duration = 3
						}
					},
					[5] = {
						state = {
							duration = 3
						}
					},
					[6] = {
						state = {
							duration = 3
						}
					}
				}
			},
			[1001] = {
				boxId = 1110460,
				targetArea = 3,
				disablePassive = 1,
				state = {}
			},
			[90] = {
				state = {}
			},
			{
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 1110453
				}
			},
			[6] = {
				boxId = 1110461,
				targetArea = 3,
				state = {}
			},
			[1002] = {
				disablePassive = 1,
				eventCondition = "1,1,1110455,1",
				boxId = 1110460,
				targetArea = 3,
				state = {}
			},
			{
				targetChoose = 10,
				targetArea = 3,
				excludeTarget = 1,
				state = {},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 6,
							stateId = 1110454
						}
					},
					[4] = {
						state = {
							duration = 6
						}
					},
					[5] = {
						state = {
							duration = 6
						}
					},
					[6] = {
						state = {
							duration = 6
						}
					}
				}
			},
			[1003] = {
				targetArea = 3,
				state = {
					duration = 0.5,
					stateId = 1110455
				}
			},
			[13] = {
				state = {},
				atkCue = {
					cueList = {
						111040013,
						111045001,
						111041005
					}
				}
			},
			[83] = {
				state = {},
				atkCue = {
					cueList = {
						111040011
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				111048001,
				111041004
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
