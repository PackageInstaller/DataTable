-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_golden_diamond_card_params.lua

module("logicconfig.config.t_golden_diamond_card_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DAILY_PRIZE",
		"4:90062:10#4:10:10#4:105:5"
	},
	{
		"MAX_PRIZE_NUM",
		"8"
	},
	{
		"GOODS_ID",
		"rmb_12"
	},
	{
		"NEW_HAND_GOODS_ID",
		"rmb_6"
	},
	{
		"CHARGE_ADD_DAYS",
		"30"
	},
	{
		"REST_CAN_BUY_DAY",
		"60"
	},
	{
		"RENEW_NOTICE_DAY",
		"3"
	},
	{
		"RENEW_NOTICE_START_TIME",
		"1"
	}
}
local t_golden_diamond_card_params = {
	DAILY_PRIZE = dataList[1],
	MAX_PRIZE_NUM = dataList[2],
	GOODS_ID = dataList[3],
	NEW_HAND_GOODS_ID = dataList[4],
	CHARGE_ADD_DAYS = dataList[5],
	REST_CAN_BUY_DAY = dataList[6],
	RENEW_NOTICE_DAY = dataList[7],
	RENEW_NOTICE_START_TIME = dataList[8]
}

t_golden_diamond_card_params.dataList = dataList

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

return t_golden_diamond_card_params
