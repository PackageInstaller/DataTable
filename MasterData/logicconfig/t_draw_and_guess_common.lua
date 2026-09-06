-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_draw_and_guess_common.lua

module("logicconfig.config.t_draw_and_guess_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"OPEN_TIME",
		"08:00:00#23:00:00"
	},
	{
		"MATCHING_WAIT_SEC",
		"30"
	},
	{
		"SELECT_QUESTION_SEC",
		"20"
	},
	{
		"ANSWER_SEC",
		"75"
	},
	{
		"RIGHT_DEC_SEC",
		"5"
	},
	{
		"SELECTABLE_QUESTION_NUMBER",
		"4"
	},
	{
		"DRAW_SYNC_TIME",
		"1"
	},
	{
		"ANSWER_LEN",
		"10"
	}
}
local t_draw_and_guess_common = {
	OPEN_TIME = dataList[1],
	MATCHING_WAIT_SEC = dataList[2],
	SELECT_QUESTION_SEC = dataList[3],
	ANSWER_SEC = dataList[4],
	RIGHT_DEC_SEC = dataList[5],
	SELECTABLE_QUESTION_NUMBER = dataList[6],
	DRAW_SYNC_TIME = dataList[7],
	ANSWER_LEN = dataList[8]
}

t_draw_and_guess_common.dataList = dataList

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

return t_draw_and_guess_common
