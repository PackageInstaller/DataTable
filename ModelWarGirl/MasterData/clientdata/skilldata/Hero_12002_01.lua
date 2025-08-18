-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12002_01.lua

local Data = {
	cueFile = "12002",
	[1610109] = {
		bhEvent = "skill.1610109",
		atkEvents = {
			[0] = {
				unitDelay = 0.22,
				boxId = 1610109,
				flyCueId = 120020002,
				boxType = 1,
				eventType = 1,
				state = {
					duration = 2,
					stateId = 1200202
				},
				hitCue = {
					cueList = {
						120020003
					}
				}
			}
		}
	},
	[1610110] = {
		bhEvent = "skill.1610110",
		atkEvents = {
			[0] = {
				unitDelay = 0.22,
				boxId = 1610110,
				flyCueId = 120020002,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120020003
					}
				}
			},
			[10] = {
				boxId = 1610111,
				targetArea = 3,
				eventType = 1,
				state = {}
			},
			[11] = {
				targetArea = 3,
				boxId = 1610112,
				targetChoose = 15,
				state = {},
				hitCue = {
					cueList = {
						10000008
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
