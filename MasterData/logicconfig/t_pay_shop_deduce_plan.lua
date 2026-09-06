-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_shop_deduce_plan.lua

module("logicconfig.config.t_pay_shop_deduce_plan", package.seeall)

local title = {
	deduction = 2,
	deduceFactor = 3,
	deducePlanId = 1
}
local dataList = {
	{
		1,
		"204:990001",
		1
	},
	{
		2,
		"204:990002",
		1
	}
}
local t_pay_shop_deduce_plan = {
	dataList[1],
	dataList[2]
}

t_pay_shop_deduce_plan.dataList = dataList

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

return t_pay_shop_deduce_plan
