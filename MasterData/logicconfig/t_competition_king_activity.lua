-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_competition_king_activity.lua

module("logicconfig.config.t_competition_king_activity", package.seeall)

local title = {
	activityItemId = 2,
	popWinTipsDesc = 8,
	rankPeriodType = 4,
	jumpStrThree = 7,
	ruleKeyTask = 9,
	jumpStrOne = 5,
	jumpStrTwo = 6,
	redPointId = 3,
	activityId = 1
}
local dataList = {
	{
		275001,
		275001,
		486,
		"weekly",
		"",
		"",
		"",
		"",
		""
	},
	{
		275002,
		275002,
		486,
		"weekly",
		"",
		"",
		"",
		"",
		""
	},
	{
		275003,
		275003,
		486,
		"weekly",
		"",
		"",
		"",
		"",
		""
	},
	{
		275004,
		275004,
		486,
		"weekly",
		"",
		"",
		"",
		"",
		""
	},
	{
		275005,
		275005,
		486,
		"weekly",
		"",
		"",
		"",
		"",
		""
	},
	{
		275006,
		275006,
		486,
		"weekly",
		"",
		"",
		"",
		"",
		""
	},
	{
		275007,
		275007,
		486,
		"weekly",
		"",
		"",
		"",
		"",
		""
	},
	{
		275008,
		275008,
		486,
		"weekly",
		"",
		"",
		"",
		"",
		""
	},
	{
		275009,
		275009,
		486,
		"weekly",
		"",
		"",
		"",
		"",
		""
	},
	{
		275011,
		275011,
		486,
		"alltime",
		"event#competitionkingopenpopwintips",
		"ui#competitionkingrankprizepopwinview",
		"ui#competitionkingrankfullscreenview",
		"PVE场景中，上阵神曜圣骑队\r\n享有暴击率+35%、生命+20%的增益效果\r\n限时buff生效时间：5月30日5：00-6月27日5：00",
		""
	},
	{
		275012,
		275012,
		486,
		"alltime",
		"event#competitionkingopenpopwintips",
		"ui#competitionkingrankprizepopwinview",
		"ui#competitionkingrankfullscreenview",
		"PVP、PVE场景中，上阵源起梦之队的精灵\r\n享有暴击率+35%、生命+20%的增益效果\r\n限时buff生效时间：5月29日5：00-6月26日5：00",
		""
	}
}
local t_competition_king_activity = {
	[275001] = dataList[1],
	[275002] = dataList[2],
	[275003] = dataList[3],
	[275004] = dataList[4],
	[275005] = dataList[5],
	[275006] = dataList[6],
	[275007] = dataList[7],
	[275008] = dataList[8],
	[275009] = dataList[9],
	[275011] = dataList[10],
	[275012] = dataList[11]
}

t_competition_king_activity.dataList = dataList

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

return t_competition_king_activity
