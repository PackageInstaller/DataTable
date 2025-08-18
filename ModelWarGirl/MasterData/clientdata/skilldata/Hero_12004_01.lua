-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/ClientData\\SkillData\\Hero_12004_01.lua

local Data = {
	cueFile = "12004",
	[1200401] = {
		bhEvent = "skill.1200401",
		atkEvents = {
			[0] = {
				unitDelay = 0.12,
				flyCueId = 120040009,
				boxType = 1,
				eventType = 1,
				state = {},
				hitCue = {
					cueList = {
						120040010
					}
				}
			},
			[100] = {
				targetArea = 2,
				state = {}
			}
		}
	},
	[1200402] = {
		bhEvent = "skill.1200402"
	},
	[1200403] = {
		bhEvent = "skill.1200403",
		atkEvents = {
			[100] = {
				state = {}
			},
			[0] = {
				boxId = 1200409,
				state = {}
			}
		}
	},
	[1200404] = {
		bhEvent = "skill.1200404"
	}
}
local skillDefault = {}
local atkEventsDefault = {
	randomTargetNumber = 0,
	boxType = 0,
	flyCueId = 0,
	eventType = 0,
	delay = 0,
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
