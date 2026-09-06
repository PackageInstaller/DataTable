-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_judgment_dragon_clg_activity.lua

module("logicconfig.config.t_judgment_dragon_clg_activity", package.seeall)

local title = {
	skinId = 2,
	jumpStrOne = 4,
	jumpRedIdThree = 9,
	jumpStrThree = 6,
	jumpStrTwo = 5,
	jumpRedIdTwo = 8,
	jumpRedIdOne = 7,
	ruleKeyMain = 3,
	activityId = 1
}
local dataList = {
	{
		461001,
		11028,
		"judgmentdragonclgmainview_rule",
		"func#618#11028",
		"mibao#ZhounianShop2",
		"func#1215",
		"",
		"",
		""
	}
}
local t_judgment_dragon_clg_activity = {
	[461001] = dataList[1]
}

t_judgment_dragon_clg_activity.dataList = dataList

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

return t_judgment_dragon_clg_activity
