-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lottery_consume_discount.lua

module("logicconfig.config.t_lottery_consume_discount", package.seeall)

local title = {
	discountTime = 4,
	discountPlanId = 1,
	discountTag = 5,
	discountPrice = 3,
	subId = 2
}
local dataList = {
	{
		1,
		1,
		"204:110:6",
		"时段|2022-09-30 05:00:00,2022-10-07 05:00:00",
		"首周"
	}
}
local t_lottery_consume_discount = {
	{
		dataList[1]
	}
}

t_lottery_consume_discount.dataList = dataList

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

return t_lottery_consume_discount
