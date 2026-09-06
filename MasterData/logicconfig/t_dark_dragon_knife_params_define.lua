-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dark_dragon_knife_params_define.lua

module("logicconfig.config.t_dark_dragon_knife_params_define", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"IMPLIED_PROP",
		"1"
	},
	{
		"DAILY_TIMES",
		"3"
	},
	{
		"ULTIMATE_SPEED_SCALE",
		"2"
	},
	{
		"ULTIMATE_ACTIVE_NUM",
		"20"
	},
	{
		"ULTIMATE_TIME",
		"5"
	},
	{
		"MAX_GAME_TIME",
		"400"
	},
	{
		"RESIDENT_ACTIVITY_ID",
		"58003"
	},
	{
		"NOW_ACTIVITY_ID",
		"58005"
	}
}
local t_dark_dragon_knife_params_define = {
	IMPLIED_PROP = dataList[1],
	DAILY_TIMES = dataList[2],
	ULTIMATE_SPEED_SCALE = dataList[3],
	ULTIMATE_ACTIVE_NUM = dataList[4],
	ULTIMATE_TIME = dataList[5],
	MAX_GAME_TIME = dataList[6],
	RESIDENT_ACTIVITY_ID = dataList[7],
	NOW_ACTIVITY_ID = dataList[8]
}

t_dark_dragon_knife_params_define.dataList = dataList

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

return t_dark_dragon_knife_params_define
