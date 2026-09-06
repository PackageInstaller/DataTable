-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lottery_god_shop.lua

module("logicconfig.config.t_lottery_god_shop", package.seeall)

local title = {
	shopId = 1,
	endDateTime = 3,
	openDateTime = 2
}
local dataList = {
	{
		1,
		"2020-03-11T05:00:00",
		"2021-04-29T04:59:59"
	},
	{
		2,
		"2021-04-29T05:00:00",
		"2021-05-13T04:59:59"
	},
	{
		3,
		"2021-05-27T05:00:00",
		"2021-06-24T04:59:59"
	}
}
local t_lottery_god_shop = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_lottery_god_shop.dataList = dataList

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

return t_lottery_god_shop
