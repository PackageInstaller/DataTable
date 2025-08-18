-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_15007.lua

local Data = {
	cueFile = "15007",
	[1500709] = {
		bhEvent = "skill.1500709",
		atkEvents = {
			{
				unitDelay = 0.15,
				boxId = 1500709,
				flyCueId = 150070001,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						150070002,
						150071002
					}
				}
			}
		}
	},
	[1500729] = {
		actTime = 15,
		skillTarget = 1,
		bhEvent = "skill.1500729",
		atkEvents = {
			{
				targetChoose = 12,
				targetArea = 3,
				state = {
					duration = -999,
					stateId = 1500702
				}
			},
			[100] = {
				targetChoose = 4,
				recordSkillTargets = 1,
				targetArea = 3,
				excludeTarget = 1,
				state = {},
				atkCue = {
					cueList = {
						150071003
					}
				},
				levelAtkEvents = {
					[2] = {
						targetChoose = 3
					},
					[3] = {
						targetChoose = 7
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		}
	},
	[1500759] = {
		actTime = 40,
		skillTarget = 1,
		bhEvent = "skill.1500759",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						150070001,
						150070001
					}
				}
			},
			[0] = {
				randomTargetNumber = 1,
				targetChoose = 4,
				randomRule = 1,
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 1500701
				},
				hitCue = {
					cueList = {
						10000001
					}
				}
			},
			[10] = {
				state = {},
				atkCue = {
					cueList = {
						150070003,
						150071004
					}
				}
			},
			{
				randomTargetNumber = 1,
				targetChoose = 4,
				randomRule = 1,
				targetArea = 3,
				state = {
					duration = 10,
					stateId = 1500701
				},
				hitCue = {
					cueList = {
						150070004
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
