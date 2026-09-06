-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_strengthen_price_plan.lua

module("logicconfig.config.t_pay_strengthen_price_plan", package.seeall)

local title = {
	pricePlanId = 1,
	cost = 2
}
local dataList = {
	{
		1,
		"204:110006:476"
	},
	{
		2,
		"204:110006:396"
	},
	{
		3,
		"204:110006:316"
	},
	{
		4,
		"204:110006:236"
	}
}
local t_pay_strengthen_price_plan = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_pay_strengthen_price_plan.dataList = dataList

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

return t_pay_strengthen_price_plan
