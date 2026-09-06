-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scene_answer_common.lua

module("logicconfig.config.t_scene_answer_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"START_TIME",
		"05:00:00"
	},
	{
		"END_TIME",
		"23:59:59"
	},
	{
		"QUESTION_INTERVAL",
		"35"
	},
	{
		"PLAYER_QUESTION_TIME",
		"15"
	},
	{
		"ANSWER_TIMES_LIMIT",
		"999"
	},
	{
		"QUESTION_PRIZE",
		"8:1:10"
	},
	{
		"OUT_DATE_SEND_MAIL",
		"FALSE"
	}
}
local t_scene_answer_common = {
	START_TIME = dataList[1],
	END_TIME = dataList[2],
	QUESTION_INTERVAL = dataList[3],
	PLAYER_QUESTION_TIME = dataList[4],
	ANSWER_TIMES_LIMIT = dataList[5],
	QUESTION_PRIZE = dataList[6],
	OUT_DATE_SEND_MAIL = dataList[7]
}

t_scene_answer_common.dataList = dataList

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

return t_scene_answer_common
