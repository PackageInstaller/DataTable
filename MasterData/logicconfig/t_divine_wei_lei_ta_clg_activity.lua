-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_wei_lei_ta_clg_activity.lua

module("logicconfig.config.t_divine_wei_lei_ta_clg_activity", package.seeall)

local title = {
	normalCreepsMasterIds = 2,
	bubbleItem = 5,
	jumpTo = 4,
	raceId = 3,
	activityId = 1
}
local dataList = {
	{
		433001,
		{
			101,
			102,
			103
		},
		12024,
		{
			"ui#lottery",
			"func#618#12024",
			"func#43#130"
		},
		"4:510392:100"
	},
	{
		433002,
		{
			101,
			102,
			103
		},
		12024,
		{
			"ui#lottery",
			"func#618#12024",
			"func#43#130"
		},
		"8:1:1"
	}
}
local t_divine_wei_lei_ta_clg_activity = {
	[433001] = dataList[1],
	[433002] = dataList[2]
}

t_divine_wei_lei_ta_clg_activity.dataList = dataList

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

return t_divine_wei_lei_ta_clg_activity
