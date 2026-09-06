-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_share_task_common.lua

module("logicconfig.config.t_share_task_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"FUNCTION_OPEN_ID",
		"178"
	},
	{
		"TRIGGER_LIMIT",
		"10"
	},
	{
		"CHALLENGE_LIMIT",
		"3"
	},
	{
		"HELP_LIMIT",
		"2"
	},
	{
		"FREE_HELP_LIMIT",
		"30"
	},
	{
		"TRIGGER_RATE",
		"500"
	},
	{
		"TRIGGER_RARE_SP",
		"1600"
	},
	{
		"SPECIAL_PERIOD",
		"12:00:00-14:00:00#18:00:00-20:00:00"
	},
	{
		"SPECIAL_BOSS_BUFF",
		"4578:99"
	},
	{
		"BOSS_EXIST_TIME",
		"3600"
	},
	{
		"BOSS_TRIGGER_SECURITY",
		"30"
	},
	{
		"MY_BOSS_CHALLENGE_LIMIT",
		"1"
	}
}
local t_share_task_common = {
	FUNCTION_OPEN_ID = dataList[1],
	TRIGGER_LIMIT = dataList[2],
	CHALLENGE_LIMIT = dataList[3],
	HELP_LIMIT = dataList[4],
	FREE_HELP_LIMIT = dataList[5],
	TRIGGER_RATE = dataList[6],
	TRIGGER_RARE_SP = dataList[7],
	SPECIAL_PERIOD = dataList[8],
	SPECIAL_BOSS_BUFF = dataList[9],
	BOSS_EXIST_TIME = dataList[10],
	BOSS_TRIGGER_SECURITY = dataList[11],
	MY_BOSS_CHALLENGE_LIMIT = dataList[12]
}

t_share_task_common.dataList = dataList

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

return t_share_task_common
