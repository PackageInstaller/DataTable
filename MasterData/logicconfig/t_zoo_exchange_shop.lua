-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zoo_exchange_shop.lua

module("logicconfig.config.t_zoo_exchange_shop", package.seeall)

local title = {
	upgradeCost = 2,
	level = 1
}
local dataList = {
	{
		1,
		""
	},
	{
		2,
		"8:1:1"
	},
	{
		3,
		"8:1:1"
	}
}
local t_zoo_exchange_shop = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_zoo_exchange_shop.dataList = dataList

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

return t_zoo_exchange_shop
