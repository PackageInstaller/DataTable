-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_hand_welfare_period.lua

module("logicconfig.config.t_new_hand_welfare_period", package.seeall)

local title = {
	periodId = 1,
	newHandPrivilegeDays = 5,
	newHandOnlinePrizeDays = 7,
	buyZdlSuperPrizePayPrize = 6,
	newHandDays = 3,
	newHandGoldenDiamond = 4,
	newHandGoodsId = 8,
	startTime = 2
}
local dataList = {
	{
		1,
		"2021-12-31",
		28,
		3,
		0,
		"8:1:1",
		7,
		"50022"
	},
	{
		2,
		"2023-12-22",
		28,
		0,
		0,
		"8:1:1",
		14,
		"50036"
	},
	{
		3,
		"2025-04-03",
		28,
		14,
		14,
		"8:1:1",
		7,
		"50036"
	},
	{
		4,
		"2025-11-21",
		28,
		14,
		14,
		"8:1:1",
		7,
		"50036"
	},
	{
		5,
		"2026-04-03",
		28,
		28,
		21,
		"8:1:1",
		7,
		"50036"
	},
	{
		6,
		"2026-06-26",
		28,
		28,
		21,
		"8:1:1",
		7,
		"50036"
	}
}
local t_new_hand_welfare_period = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_new_hand_welfare_period.dataList = dataList

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

return t_new_hand_welfare_period
