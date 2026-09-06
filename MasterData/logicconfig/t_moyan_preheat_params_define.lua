-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_moyan_preheat_params_define.lua

module("logicconfig.config.t_moyan_preheat_params_define", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"参数名",
		"值"
	},
	{
		"FREE_GAME_TIMES",
		"10"
	},
	{
		"GAME_PLAY_TIME",
		"30"
	},
	{
		"SPECIAL_PROPS_MAX_NUM",
		"5"
	},
	{
		"SPECIAL_PROPS_ADD_TIME",
		"5"
	},
	{
		"PROP_SCORE_UNIT",
		"1"
	},
	{
		"PROP_FALL_SPEED",
		"[10,50]"
	},
	{
		"PROP_APPEAR_SPEED",
		"[2,5]"
	},
	{
		"CRAZY_PROP_APPEAR_SPEED",
		"[30,50]"
	},
	{
		"PROP_SPACE",
		"[-400,400]"
	},
	{
		"BUY_TIMES_COST",
		"105:182:10"
	},
	{
		"MAX_SCORE",
		"300"
	},
	{
		"DAILY_BUY_TIMES",
		"0"
	},
	{
		"SPECIAL_PROPS_RATE",
		"0"
	},
	{
		"CRAZY_MODEL",
		"3"
	},
	{
		"CRAZY_TIME",
		"10"
	},
	{
		"CRAZY_TIP_TIME",
		"3"
	},
	{
		"PET_ICON_RACEID",
		"[18021,18001,12027,13022,13021,11026]"
	},
	{
		"PROP_SPECIAL_SCORE",
		"5"
	}
}
local t_moyan_preheat_params_define = {
	参数名 = dataList[1],
	FREE_GAME_TIMES = dataList[2],
	GAME_PLAY_TIME = dataList[3],
	SPECIAL_PROPS_MAX_NUM = dataList[4],
	SPECIAL_PROPS_ADD_TIME = dataList[5],
	PROP_SCORE_UNIT = dataList[6],
	PROP_FALL_SPEED = dataList[7],
	PROP_APPEAR_SPEED = dataList[8],
	CRAZY_PROP_APPEAR_SPEED = dataList[9],
	PROP_SPACE = dataList[10],
	BUY_TIMES_COST = dataList[11],
	MAX_SCORE = dataList[12],
	DAILY_BUY_TIMES = dataList[13],
	SPECIAL_PROPS_RATE = dataList[14],
	CRAZY_MODEL = dataList[15],
	CRAZY_TIME = dataList[16],
	CRAZY_TIP_TIME = dataList[17],
	PET_ICON_RACEID = dataList[18],
	PROP_SPECIAL_SCORE = dataList[19]
}

t_moyan_preheat_params_define.dataList = dataList

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

return t_moyan_preheat_params_define
