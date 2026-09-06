-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xiao_nuo_birthday_crazy_game.lua

module("logicconfig.config.t_xiao_nuo_birthday_crazy_game", package.seeall)

local title = {
	crazyScorePlan = 3,
	stageGroupId = 4,
	countdown = 5,
	activityId = 1,
	startTime = 2
}
local dataList = {
	{
		220001,
		"2022-12-09T05:00:00",
		1,
		4,
		90
	},
	{
		220002,
		"2022-12-09T05:00:00",
		1,
		4,
		90
	},
	{
		220003,
		"2023-12-01T05:00:00",
		1,
		4,
		90
	},
	{
		220004,
		"2024-08-16T05:00:00",
		1,
		4,
		90
	},
	{
		220005,
		"2026-03-21T05:00:00",
		1,
		4,
		90
	}
}
local t_xiao_nuo_birthday_crazy_game = {
	[220001] = dataList[1],
	[220002] = dataList[2],
	[220003] = dataList[3],
	[220004] = dataList[4],
	[220005] = dataList[5]
}

t_xiao_nuo_birthday_crazy_game.dataList = dataList

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

return t_xiao_nuo_birthday_crazy_game
