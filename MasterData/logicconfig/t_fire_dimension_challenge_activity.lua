-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fire_dimension_challenge_activity.lua

module("logicconfig.config.t_fire_dimension_challenge_activity", package.seeall)

local title = {
	ruleLevelTip = 5,
	jumpTo2 = 7,
	activityId = 1,
	jumpTo3 = 8,
	jumpTo1 = 6,
	raceId = 3,
	jumpTo4 = 9,
	functionOpenId = 2,
	ruleTip = 4
}
local dataList = {
	{
		274001,
		0,
		12016,
		"firedimension_rule",
		"firedimensionlevel_rule",
		"mibao#shenyaolibao",
		"func#191#165#165016",
		"func#618#12016",
		"func#375"
	},
	{
		274002,
		0,
		11027,
		"divinemixixi_rule",
		"divinemixixilevel_rule",
		"func#1181",
		"ui#lottery",
		"func#618#11027",
		"func#1181"
	},
	{
		274003,
		0,
		12016,
		"firedimension_rule",
		"firedimensionlevel_rule",
		"mibao#shenyaolibao",
		"func#191#165#165016",
		"func#618#12016",
		"func#375"
	}
}
local t_fire_dimension_challenge_activity = {
	[274001] = dataList[1],
	[274002] = dataList[2],
	[274003] = dataList[3]
}

t_fire_dimension_challenge_activity.dataList = dataList

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

return t_fire_dimension_challenge_activity
