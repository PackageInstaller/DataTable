-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_shop_charge.lua

module("logicconfig.config.t_shop_charge", package.seeall)

local title = {
	id = 1,
	moneyType = 3,
	price = 2,
	count = 4
}
local dataList = {
	{
		1,
		6,
		"¥",
		60
	},
	{
		2,
		60,
		"¥",
		600
	},
	{
		3,
		98,
		"¥",
		980
	},
	{
		4,
		198,
		"¥",
		1980
	},
	{
		5,
		328,
		"¥",
		3280
	},
	{
		6,
		648,
		"¥",
		6480
	}
}
local t_shop_charge = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_shop_charge.dataList = dataList

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

return t_shop_charge
