-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_nuo_ya_clg_activity.lua

module("logicconfig.config.t_divine_nuo_ya_clg_activity", package.seeall)

local title = {
	challengeId = 6,
	jumpTo2 = 8,
	normalClgDailyCount = 2,
	jumpTo5 = 11,
	extremeClgPrize = 4,
	jumpTo3 = 9,
	normalClgPrize = 3,
	redPointId = 5,
	jumpTo1 = 7,
	jumpTo4 = 10,
	activityId = 1
}
local dataList = {
	{
		316001,
		3,
		"4:211:100",
		"4:211:100",
		527,
		137,
		"func#375",
		"func#618#14018",
		"func#545#22",
		"mibao#shengrihui2",
		"mibao#shenyaolibao"
	}
}
local t_divine_nuo_ya_clg_activity = {
	[316001] = dataList[1]
}

t_divine_nuo_ya_clg_activity.dataList = dataList

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

return t_divine_nuo_ya_clg_activity
