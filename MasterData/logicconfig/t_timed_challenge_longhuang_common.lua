-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_longhuang_common.lua

module("logicconfig.config.t_timed_challenge_longhuang_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"FIRE_BALL_BASE_VELOCITY",
		"100"
	},
	{
		"MAIN_BALL_BASE_VELOCITY",
		"170"
	},
	{
		"FIXED_POINTS_POSITION",
		"0.25,0.25#0.25,0.75#0.75,0.25#0.75,0.75"
	},
	{
		"FIRE_BALL_BIRTH_POINTS_NUMBER",
		"50"
	},
	{
		"GAME_COST",
		"105:155:50"
	},
	{
		"MAIN_BALL_SIZE",
		"92"
	},
	{
		"MAIN_BALL_SCALE",
		"0.55"
	}
}
local t_timed_challenge_longhuang_common = {
	FIRE_BALL_BASE_VELOCITY = dataList[1],
	MAIN_BALL_BASE_VELOCITY = dataList[2],
	FIXED_POINTS_POSITION = dataList[3],
	FIRE_BALL_BIRTH_POINTS_NUMBER = dataList[4],
	GAME_COST = dataList[5],
	MAIN_BALL_SIZE = dataList[6],
	MAIN_BALL_SCALE = dataList[7]
}

t_timed_challenge_longhuang_common.dataList = dataList

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

return t_timed_challenge_longhuang_common
