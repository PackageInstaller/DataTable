-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_axmm_game_activity.lua

module("logicconfig.config.t_axmm_game_activity", package.seeall)

local title = {
	maxItemPerGain = 6,
	pos = 8,
	gamePlanId = 2,
	skinId = 7,
	dailyTimes = 3,
	gameItemId = 5,
	activityId = 1,
	gamePrizePlanId = 4
}
local dataList = {
	{
		281001,
		1,
		3,
		1,
		"10:281001",
		1000,
		0
	},
	{
		281002,
		1,
		3,
		2,
		"10:281002",
		1000,
		15019,
		{
			0.6,
			-517
		}
	},
	{
		281003,
		1,
		3,
		2,
		"10:281003",
		1000,
		16028,
		{
			0.6,
			-517
		}
	},
	{
		281004,
		1,
		3,
		3,
		"10:281004",
		1000,
		18021,
		{
			0.6,
			-517
		}
	}
}
local t_axmm_game_activity = {
	[281001] = dataList[1],
	[281002] = dataList[2],
	[281003] = dataList[3],
	[281004] = dataList[4]
}

t_axmm_game_activity.dataList = dataList

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

return t_axmm_game_activity
