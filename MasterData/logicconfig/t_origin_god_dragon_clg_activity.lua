-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_god_dragon_clg_activity.lua

module("logicconfig.config.t_origin_god_dragon_clg_activity", package.seeall)

local title = {
	skinId = 6,
	openTime = 2,
	jumpStrThree = 9,
	jumpStrOne = 7,
	jumpRedIdOne = 11,
	jumpRedIdThree = 13,
	jumpStrTwo = 8,
	jumpRedIdTwo = 12,
	jumpRedIdFour = 14,
	costItem = 4,
	redPointId = 3,
	jumpStrFour = 10,
	ruleKeyMain = 5,
	activityId = 1
}
local dataList = {
	{
		545001,
		"2025-01-09T09:00:00",
		744,
		"4:510646",
		"origingoddragonclgmainview_rule",
		16045,
		"event#gotofirstpassrankview#545001",
		"mibao#jinglingyangcheng",
		"func#618#16045",
		"ui#lottery",
		"",
		"",
		"",
		""
	}
}
local t_origin_god_dragon_clg_activity = {
	[545001] = dataList[1]
}

t_origin_god_dragon_clg_activity.dataList = dataList

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

return t_origin_god_dragon_clg_activity
