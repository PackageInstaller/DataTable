-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_peak_tower_verify_race_week.lua

module("logicconfig.config.t_peak_tower_verify_race_week", package.seeall)

local title = {
	verifyRacePlanId = 3,
	weekId = 2,
	activityId = 1
}
local dataList = {
	{
		567001,
		1,
		1
	},
	{
		567001,
		2,
		2
	},
	{
		567001,
		3,
		3
	},
	{
		567001,
		4,
		4
	}
}
local t_peak_tower_verify_race_week = {
	[567001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_peak_tower_verify_race_week.dataList = dataList

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

return t_peak_tower_verify_race_week
