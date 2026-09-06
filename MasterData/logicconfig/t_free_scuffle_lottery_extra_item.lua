-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_free_scuffle_lottery_extra_item.lua

module("logicconfig.config.t_free_scuffle_lottery_extra_item", package.seeall)

local title = {
	itemId = 2,
	extraLotteryPlanId = 1,
	prize = 3,
	coin = 4
}
local dataList = {
	{
		1,
		1,
		"",
		"10000"
	},
	{
		1,
		2,
		"10:489001:5",
		"0"
	},
	{
		1,
		3,
		"10:489001:10",
		"0"
	},
	{
		1,
		4,
		"",
		"100000"
	},
	{
		2,
		1,
		"",
		"10000"
	},
	{
		2,
		2,
		"10:489003:5",
		"0"
	},
	{
		2,
		3,
		"10:489003:10",
		"0"
	},
	{
		2,
		4,
		"",
		"100000"
	},
	{
		3,
		1,
		"",
		"10000"
	},
	{
		3,
		2,
		"10:489005:5",
		"0"
	},
	{
		3,
		3,
		"10:489005:10",
		"0"
	},
	{
		3,
		4,
		"",
		"100000"
	}
}
local t_free_scuffle_lottery_extra_item = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_free_scuffle_lottery_extra_item.dataList = dataList

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

return t_free_scuffle_lottery_extra_item
