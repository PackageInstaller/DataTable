-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_shop_turn_table_base.lua

module("logicconfig.config.t_pay_shop_turn_table_base", package.seeall)

local title = {
	dailyTimes = 2,
	planId = 3,
	vipLevel = 1
}
local dataList = {
	{
		0,
		1,
		1
	},
	{
		1,
		2,
		2
	},
	{
		2,
		2,
		3
	},
	{
		3,
		3,
		4
	},
	{
		4,
		3,
		5
	},
	{
		5,
		4,
		6
	},
	{
		6,
		4,
		7
	},
	{
		7,
		4,
		8
	}
}
local t_pay_shop_turn_table_base = {
	[0] = dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_pay_shop_turn_table_base.dataList = dataList

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

return t_pay_shop_turn_table_base
