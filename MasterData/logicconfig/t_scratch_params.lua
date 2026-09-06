-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scratch_params.lua

module("logicconfig.config.t_scratch_params", package.seeall)

local title = {
	value = 2,
	key = 1,
	desc = 3
}
local dataList = {
	{
		"TASK_DAILY_RAND",
		"5",
		"每日随机抽取任务数量"
	},
	{
		"BOMB_NEED_APPEAR",
		"5",
		"炸弹必须出现的次数"
	},
	{
		"CROSS_BOMB_NUM",
		"1",
		"十字炸弹数量"
	},
	{
		"NINE_BOMB_NUM",
		"2",
		"九宫炸弹数量"
	},
	{
		"PRIZE_SELECT_1_NUM",
		"1",
		"一等奖选择数量"
	},
	{
		"PRIZE_SELECT_2_NUM",
		"2",
		"二等奖选择数量"
	},
	{
		"PRIZE_SELECT_3_NUM",
		"3",
		"三等奖选择数量"
	},
	{
		"PRIZE_SELECT_4_NUM",
		"4",
		"四等奖选择数量"
	},
	{
		"PRIZE_SELECT_1_FACTOR",
		"1",
		"一等奖生成数量系数"
	},
	{
		"PRIZE_SELECT_2_FACTOR",
		"2",
		"二等奖生成数量系数"
	},
	{
		"PRIZE_SELECT_3_FACTOR",
		"3",
		"三等奖生成数量系数"
	},
	{
		"PRIZE_SELECT_4_FACTOR",
		"8",
		"四等奖生成数量系数"
	},
	{
		"SCORE_EXCHANGE_ITEM",
		"5",
		"多少积分换1个道具"
	},
	{
		"PAY_PRIZE_SCORE",
		"1",
		"充值多少钱奖励1积分"
	}
}
local t_scratch_params = {
	TASK_DAILY_RAND = dataList[1],
	BOMB_NEED_APPEAR = dataList[2],
	CROSS_BOMB_NUM = dataList[3],
	NINE_BOMB_NUM = dataList[4],
	PRIZE_SELECT_1_NUM = dataList[5],
	PRIZE_SELECT_2_NUM = dataList[6],
	PRIZE_SELECT_3_NUM = dataList[7],
	PRIZE_SELECT_4_NUM = dataList[8],
	PRIZE_SELECT_1_FACTOR = dataList[9],
	PRIZE_SELECT_2_FACTOR = dataList[10],
	PRIZE_SELECT_3_FACTOR = dataList[11],
	PRIZE_SELECT_4_FACTOR = dataList[12],
	SCORE_EXCHANGE_ITEM = dataList[13],
	PAY_PRIZE_SCORE = dataList[14]
}

t_scratch_params.dataList = dataList

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

return t_scratch_params
