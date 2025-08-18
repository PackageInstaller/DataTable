-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_15901.lua

local Data = {
	cueFile = "15002",
	[1590101] = {
		bhEvent = "skill.1590101",
		atkEvents = {
			[0] = {
				boxId = 1590101,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						150020001
					}
				}
			}
		}
	},
	[1590121] = {
		actTime = 45,
		skillTarget = 1,
		bhEvent = "skill.1590121",
		atkEvents = {
			[100] = {
				state = {}
			},
			{
				targetChoose = 3,
				targetArea = 3,
				excludeTarget = 1,
				state = {
					duration = -999,
					stateId = 1590101
				},
				levelAtkEvents = {
					[2] = {},
					[3] = {
						targetChoose = 10
					},
					[4] = {},
					[5] = {},
					[6] = {}
				}
			}
		}
	},
	[1590151] = {
		actTime = 60,
		videoActTime = 50,
		skillTarget = 1,
		bhEvent = "skill.1590151",
		atkEvents = {
			[100] = {
				state = {}
			},
			{
				targetArea = 3,
				boxId = 1590151,
				targetChoose = 7,
				state = {
					duration = 10,
					stateId = 1590102
				},
				hitCue = {
					cueList = {
						10000008
					}
				}
			}
		},
		videoActCue = {
			cueList = {
				150028002,
				150021005
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
