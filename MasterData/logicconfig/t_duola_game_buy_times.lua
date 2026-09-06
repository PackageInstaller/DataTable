-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_duola_game_buy_times.lua

module("logicconfig.config.t_duola_game_buy_times", package.seeall)

local title = {
	cost = 3,
	addStep = 4,
	activityId = 1,
	times = 2
}
local dataList = {
	{
		279001,
		1,
		"105:6061:50",
		10
	},
	{
		279001,
		2,
		"105:6061:50",
		10
	},
	{
		279001,
		3,
		"105:6061:50",
		10
	},
	{
		279001,
		4,
		"105:6061:50",
		10
	},
	{
		279001,
		5,
		"105:6061:50",
		10
	},
	{
		279002,
		1,
		"105:6061:50",
		10
	},
	{
		279002,
		2,
		"105:6061:50",
		10
	},
	{
		279002,
		3,
		"105:6061:50",
		10
	},
	{
		279002,
		4,
		"105:6061:50",
		10
	},
	{
		279002,
		5,
		"105:6061:50",
		10
	},
	{
		279003,
		1,
		"105:6061:50",
		10
	},
	{
		279003,
		2,
		"105:6061:50",
		10
	},
	{
		279003,
		3,
		"105:6061:50",
		10
	},
	{
		279003,
		4,
		"105:6061:50",
		10
	},
	{
		279003,
		5,
		"105:6061:50",
		10
	}
}
local t_duola_game_buy_times = {
	[279001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[279002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	[279003] = {
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_duola_game_buy_times.dataList = dataList

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

return t_duola_game_buy_times
