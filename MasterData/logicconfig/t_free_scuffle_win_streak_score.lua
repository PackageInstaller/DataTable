-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_free_scuffle_win_streak_score.lua

module("logicconfig.config.t_free_scuffle_win_streak_score", package.seeall)

local title = {
	winStreakCount = 3,
	activityId = 1,
	winStreakId = 2,
	score = 4
}
local dataList = {
	{
		489001,
		1,
		1,
		0
	},
	{
		489001,
		2,
		2,
		0
	},
	{
		489001,
		3,
		3,
		20
	},
	{
		489001,
		4,
		4,
		20
	},
	{
		489001,
		5,
		5,
		30
	},
	{
		489002,
		1,
		1,
		0
	},
	{
		489002,
		2,
		2,
		0
	},
	{
		489002,
		3,
		3,
		20
	},
	{
		489002,
		4,
		4,
		20
	},
	{
		489002,
		5,
		5,
		30
	},
	{
		489003,
		1,
		1,
		0
	},
	{
		489003,
		2,
		2,
		0
	},
	{
		489003,
		3,
		3,
		20
	},
	{
		489003,
		4,
		4,
		20
	},
	{
		489003,
		5,
		5,
		30
	}
}
local t_free_scuffle_win_streak_score = {
	[489001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[489002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	[489003] = {
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_free_scuffle_win_streak_score.dataList = dataList

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

return t_free_scuffle_win_streak_score
