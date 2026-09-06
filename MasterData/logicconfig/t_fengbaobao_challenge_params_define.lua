-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fengbaobao_challenge_params_define.lua

module("logicconfig.config.t_fengbaobao_challenge_params_define", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CHALLENGE_ID",
		"11"
	},
	{
		"KILL_RANK_PRIZE",
		"13:28:1"
	},
	{
		"DAILY_TIMES",
		"3"
	},
	{
		"BUY_TIMES_PLAN_ID",
		"1"
	},
	{
		"BUFF_PLAN_ID",
		"1"
	},
	{
		"ACC_HARM_PRIZE_PLAN_ID",
		"1"
	},
	{
		"RACE_ID",
		"10380"
	},
	{
		"SCENE_MOVE_SPEED",
		"350"
	},
	{
		"SCENE_MOVE_SPEED_MAX",
		"600"
	},
	{
		"INTO_MAX_SPEED_TIME",
		"50"
	},
	{
		"WY_INIT_POWER",
		"64"
	},
	{
		"FBB_INIT_POWER",
		"18"
	},
	{
		"WY_INIT_RATIO",
		"20"
	},
	{
		"WY_MOVE_SPEED",
		"450"
	},
	{
		"WARINING_TIP_SLOT",
		"261"
	},
	{
		"BATTLE_SLOT",
		"272"
	},
	{
		"WARNING_TIME",
		"1.8"
	},
	{
		"GAME_PLAN_ID",
		"1"
	},
	{
		"MAX_PROGRESS",
		"7500"
	},
	{
		"PROGRESS_FLOOR_UNIT",
		"1000000"
	},
	{
		"EVERY_HIT_TIME",
		"1"
	},
	{
		"RANK_TIP",
		"最先击败王也的前5999名玩家的排行榜，按照击败时间先后排序。"
	},
	{
		"EVERY_HIT_REDUCE_HP_RATIO",
		"10"
	}
}
local t_fengbaobao_challenge_params_define = {
	CHALLENGE_ID = dataList[1],
	KILL_RANK_PRIZE = dataList[2],
	DAILY_TIMES = dataList[3],
	BUY_TIMES_PLAN_ID = dataList[4],
	BUFF_PLAN_ID = dataList[5],
	ACC_HARM_PRIZE_PLAN_ID = dataList[6],
	RACE_ID = dataList[7],
	SCENE_MOVE_SPEED = dataList[8],
	SCENE_MOVE_SPEED_MAX = dataList[9],
	INTO_MAX_SPEED_TIME = dataList[10],
	WY_INIT_POWER = dataList[11],
	FBB_INIT_POWER = dataList[12],
	WY_INIT_RATIO = dataList[13],
	WY_MOVE_SPEED = dataList[14],
	WARINING_TIP_SLOT = dataList[15],
	BATTLE_SLOT = dataList[16],
	WARNING_TIME = dataList[17],
	GAME_PLAN_ID = dataList[18],
	MAX_PROGRESS = dataList[19],
	PROGRESS_FLOOR_UNIT = dataList[20],
	EVERY_HIT_TIME = dataList[21],
	RANK_TIP = dataList[22],
	EVERY_HIT_REDUCE_HP_RATIO = dataList[23]
}

t_fengbaobao_challenge_params_define.dataList = dataList

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

return t_fengbaobao_challenge_params_define
