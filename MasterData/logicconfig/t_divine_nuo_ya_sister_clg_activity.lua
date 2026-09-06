-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_nuo_ya_sister_clg_activity.lua

module("logicconfig.config.t_divine_nuo_ya_sister_clg_activity", package.seeall)

local title = {
	extremeShowPrize = 6,
	redPointId = 3,
	jumpTo = 5,
	raceId = 4,
	petLimit = 2,
	activityId = 1
}
local dataList = {
	{
		407001,
		10,
		609,
		14026,
		{
			"func#618#14026",
			"func#43#128",
			"mibao#shenyaonuoya2"
		},
		"4:510360:100"
	},
	{
		407002,
		10,
		0,
		14026,
		{
			"func#618#14026",
			"func#43#128",
			"mibao#shenyaonuoya2"
		},
		""
	}
}
local t_divine_nuo_ya_sister_clg_activity = {
	[407001] = dataList[1],
	[407002] = dataList[2]
}

t_divine_nuo_ya_sister_clg_activity.dataList = dataList

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

return t_divine_nuo_ya_sister_clg_activity
