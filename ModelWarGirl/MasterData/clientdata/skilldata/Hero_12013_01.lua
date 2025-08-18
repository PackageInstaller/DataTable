-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12013_01.lua

local Data = {
	cueFile = "12013",
	[1620409] = {
		bhEvent = "skill.1620409",
		atkEvents = {
			[100] = {
				state = {},
				atkCue = {
					cueList = {
						120130014,
						120131006
					}
				}
			},
			[0] = {
				flyCueId = 120130014,
				boxId = 1620409,
				unitDelay = 0.12,
				boxType = 1,
				subEventId = 1002,
				eventType = 1,
				subEventSkill = 1620409,
				state = {},
				hitCue = {
					cueList = {
						120130016,
						120131008
					}
				}
			},
			{
				targetArea = 3,
				boxId = 1620412,
				targetChoose = 15,
				state = {},
				hitCue = {
					cueList = {
						10000008
					}
				}
			},
			{
				boxId = 1620411,
				targetArea = 3,
				eventType = 1,
				state = {}
			}
		}
	},
	[1620410] = {
		bhEvent = "skill.1620410",
		atkEvents = {
			[100] = {
				subEventId = 1001,
				subEventSkill = 1620410,
				state = {},
				atkCue = {
					cueList = {
						120130015,
						120131006
					}
				}
			},
			[0] = {
				unitDelay = 0.12,
				boxId = 1620409,
				flyCueId = 120130015,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120130016,
						120131008
					}
				}
			},
			[1001] = {
				subEventId = 1002,
				subEventSkill = 1620410,
				boxId = 1620411,
				targetArea = 3,
				state = {}
			},
			[1002] = {
				boxId = 1620412,
				targetArea = 3,
				targetChoose = 15,
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
