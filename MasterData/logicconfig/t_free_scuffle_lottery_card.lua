-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_free_scuffle_lottery_card.lua

module("logicconfig.config.t_free_scuffle_lottery_card", package.seeall)

local title = {
	noMaxLvFloor = 4,
	noExistFloor = 3,
	type = 2,
	extraLotteryPlanId = 5,
	activityId = 1
}
local dataList = {
	{
		489001,
		1,
		30,
		10,
		1
	},
	{
		489001,
		2,
		30,
		10,
		1
	},
	{
		489001,
		3,
		30,
		10,
		1
	},
	{
		489002,
		1,
		30,
		10,
		2
	},
	{
		489002,
		2,
		30,
		10,
		2
	},
	{
		489002,
		3,
		30,
		10,
		2
	},
	{
		489003,
		1,
		30,
		10,
		3
	},
	{
		489003,
		2,
		30,
		10,
		3
	},
	{
		489003,
		3,
		30,
		10,
		3
	}
}
local t_free_scuffle_lottery_card = {
	[489001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[489002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[489003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_free_scuffle_lottery_card.dataList = dataList

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

return t_free_scuffle_lottery_card
