-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sword_storm_phase.lua

module("logicconfig.config.t_sword_storm_phase", package.seeall)

local title = {
	supportPetPlanId = 4,
	openTime = 3,
	phaseId = 2,
	redPoint = 5,
	activityId = 1
}
local dataList = {
	{
		579001,
		1,
		"2026-04-03T05:00:00",
		1,
		"o84"
	},
	{
		579001,
		2,
		"2026-04-10T05:00:00",
		1,
		"o85"
	}
}
local t_sword_storm_phase = {
	[579001] = {
		dataList[1],
		dataList[2]
	}
}

t_sword_storm_phase.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_sword_storm_phase
