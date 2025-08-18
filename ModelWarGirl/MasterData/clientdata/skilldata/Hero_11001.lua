-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_11001.lua

local Data = {
	cueFile = "11001",
	[1100101] = {
		bhEvent = "skill.1100101",
		atkEvents = {
			[0] = {
				boxId = 1100109,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000062
					}
				}
			},
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						110010002,
						110011004
					}
				}
			}
		}
	},
	[1100121] = {
		bhEvent = "skill.1100121",
		atkEvents = {
			[0] = {
				targetArea = 2,
				boxId = 1100129,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110010003
					}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1100130,
						atkCue = {
							cueList = {
								10000008
							}
						}
					},
					[3] = {
						boxId = 1100130,
						atkCue = {
							cueList = {
								10000008
							}
						}
					},
					[4] = {
						boxId = 1100130,
						atkCue = {
							cueList = {
								10000008
							}
						}
					},
					[5] = {
						boxId = 1100130,
						atkCue = {
							cueList = {
								10000008
							}
						}
					},
					[6] = {}
				}
			}
		}
	},
	[1100122] = {
		bhEvent = "skill.1100122",
		atkEvents = {
			[0] = {
				targetArea = 2,
				boxId = 1100129,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						10000063,
						110011003
					}
				}
			},
			{
				targetArea = 3,
				state = {},
				levelAtkEvents = {
					[2] = {
						boxId = 1100130,
						hitCue = {
							cueList = {
								10000008
							}
						}
					},
					[3] = {
						boxId = 1100130,
						hitCue = {
							cueList = {
								10000008
							}
						}
					},
					[4] = {
						boxId = 1100130,
						hitCue = {
							cueList = {
								10000008
							}
						}
					},
					[5] = {},
					[6] = {}
				}
			},
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						110011005
					}
				}
			}
		}
	},
	[1100151] = {
		actTime = 240,
		hideEvent = 1,
		bhEvent = "skill.1100151",
		atkEvents = {
			[100] = {
				targetChoose = 3,
				targetArea = 2,
				hitedAnim = "end",
				state = {}
			},
			[90] = {
				state = {},
				atkCue = {
					cueList = {
						110018003
					}
				}
			},
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						110015002
					}
				}
			},
			[91] = {
				state = {},
				atkCue = {
					cueList = {
						110010004
					}
				}
			}
		}
	},
	[1100152] = {
		actTime = 360,
		hideEvent = 1,
		bhEvent = "skill.1100152",
		atkEvents = {
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						110015002
					}
				}
			},
			[100] = {
				targetChoose = 3,
				targetArea = 2,
				hitedAnim = "end",
				state = {}
			},
			[20] = {
				state = {},
				atkCue = {
					cueList = {
						110018002
					}
				}
			},
			[30] = {
				state = {},
				atkCue = {
					cueList = {
						110015003
					}
				}
			}
		}
	},
	[1100153] = {
		hideTime = 180,
		actTime = 240,
		hideEvent = 100,
		prepareCamera = 1,
		bhEvent = "skill.1100153",
		atkEvents = {
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						110015004,
						110010008
					}
				}
			},
			[20] = {
				state = {},
				atkCue = {
					cueList = {
						110015002
					}
				}
			},
			[100] = {
				targetChoose = 3,
				targetArea = 2,
				hitedAnim = "end",
				state = {}
			},
			[30] = {
				state = {},
				atkCue = {
					cueList = {
						110010004
					}
				}
			},
			[40] = {
				state = {},
				atkCue = {
					cueList = {
						110018003
					}
				}
			},
			[12] = {
				state = {},
				atkCue = {
					cueList = {
						110015003
					}
				}
			},
			[50] = {
				state = {},
				atkCue = {
					cueList = {
						110013001
					}
				}
			}
		}
	},
	[1100161] = {
		actTime = 105,
		prepareCamDruation = 65,
		prepareCamera = 1,
		bhEvent = "skill.1100161",
		atkEvents = {
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						110010006,
						110015005,
						110010008
					}
				}
			},
			{
				targetArea = 2,
				boxId = 1100159,
				targetChoose = 3,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110010007
					}
				}
			},
			[80] = {
				state = {}
			},
			[90] = {
				state = {}
			},
			[13] = {
				state = {}
			}
		}
	},
	[1100154] = {
		hideEffect = 1,
		actTime = 90,
		videoActTime = 54,
		prepareCamDruation = 50,
		prepareCamera = 1,
		bhEvent = "skill.1100154",
		atkEvents = {
			[100] = {
				targetChoose = 3,
				targetArea = 2,
				hitedAnim = "end",
				state = {}
			},
			[20] = {
				state = {},
				atkCue = {
					cueList = {
						110018003
					}
				}
			},
			[90] = {
				hitedAnim = "Hit",
				boxId = 1100159,
				targetArea = 2,
				eventType = 1,
				targetChoose = 3,
				state = {
					duration = 8,
					stateId = 1100102
				},
				atkCue = {
					cueList = {
						110010009,
						110013001
					}
				},
				hitCue = {
					cueList = {
						110010007,
						110011002,
						10006003
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 12,
							stateId = 1100102
						}
					},
					[4] = {
						state = {
							duration = 15,
							stateId = 1100102
						}
					},
					[5] = {
						state = {
							duration = 15,
							stateId = 1100102
						}
					},
					[6] = {
						state = {
							duration = 15,
							stateId = 1100102
						}
					}
				}
			},
			[80] = {
				targetArea = 3,
				state = {
					duration = 8,
					stateId = 1100101
				},
				atkCue = {
					cueList = {
						110015002,
						110010011
					}
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						state = {
							duration = 12,
							stateId = 1100101
						}
					},
					[4] = {
						state = {
							duration = 12,
							stateId = 1100101
						}
					},
					[5] = {
						state = {
							duration = 12,
							stateId = 1100101
						}
					},
					[6] = {
						state = {}
					}
				}
			},
			[13] = {
				targetChoose = 3,
				targetArea = 2,
				hitedAnim = "end",
				state = {}
			},
			[10] = {
				targetChoose = 3,
				targetArea = 2,
				state = {},
				atkCue = {
					cueList = {
						110015002,
						110010011,
						110010006,
						110010012
					}
				}
			},
			[1001] = {
				boxId = 1100161,
				targetArea = 3,
				state = {}
			}
		},
		videoActCue = {
			cueList = {
				110011006,
				110018004
			}
		}
	},
	[1100155] = {
		hideTime = 150,
		actTime = 150,
		hideEvent = 90,
		prepareCamDruation = 60,
		prepareCamera = 1,
		bhEvent = "skill.1100155",
		atkEvents = {
			[100] = {
				targetArea = 3,
				state = {},
				hitCue = {
					cueList = {
						110018004
					}
				}
			},
			[0] = {
				boxId = 1100160,
				targetChoose = 4,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						110010007
					}
				}
			},
			[101] = {
				targetArea = 3,
				state = {},
				atkCue = {
					cueList = {
						110015005
					}
				}
			}
		}
	},
	[1100171] = {
		actTime = 60,
		prepareCamDruation = 30,
		prepareCamera = 1,
		bhEvent = "skill.1100171",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						110018004
					}
				}
			},
			[10] = {
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 1100101
				},
				atkCue = {
					cueList = {
						110015006
					}
				}
			},
			{
				hitedAnim = "Hit",
				boxId = 1100159,
				targetChoose = 3,
				eventType = 1,
				state = {
					duration = 10,
					stateId = 1100102
				},
				atkCue = {
					cueList = {
						110010009
					}
				},
				hitCue = {
					cueList = {
						110010003
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
