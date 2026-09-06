-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_empress_clg_activity.lua

module("logicconfig.config.t_empress_clg_activity", package.seeall)

local title = {
	extremeClgPrize = 2,
	skinId = 6,
	normalClgWinBaseScore = 3,
	jumpStrOne = 7,
	mainRuleKey = 10,
	jumpStrThree = 9,
	jumpStrTwo = 8,
	normalClgBuffCounterScoreUnit = 4,
	redPointId = 5,
	activityId = 1
}
local dataList = {
	{
		342001,
		"100:16019:1:1",
		10,
		2,
		555,
		16019,
		"func#618#16019",
		"mibao#liudaojijie1",
		"func#43#123",
		"nvdimainview_rule"
	},
	{
		342002,
		"8:1:1000",
		10,
		2,
		645,
		16019,
		"func#618#16019",
		"mibao#liudaojijie1",
		"func#43#123",
		"nvdimainview_rule01"
	}
}
local t_empress_clg_activity = {
	[342001] = dataList[1],
	[342002] = dataList[2]
}

t_empress_clg_activity.dataList = dataList

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

return t_empress_clg_activity
