-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camp_battle_path_finding.lua

module("logicconfig.config.t_camp_battle_path_finding", package.seeall)

local title = {
	buyPlanId = 6,
	copyId = 5,
	prizePlanId = 4,
	dailyTimes = 3,
	scenePlanId = 2,
	activityId = 1
}
local dataList = {
	{
		187001,
		1,
		3,
		1,
		4230002,
		1
	},
	{
		187002,
		2,
		3,
		1,
		4230002,
		2
	}
}
local t_camp_battle_path_finding = {
	[187001] = dataList[1],
	[187002] = dataList[2]
}

t_camp_battle_path_finding.dataList = dataList

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

return t_camp_battle_path_finding
