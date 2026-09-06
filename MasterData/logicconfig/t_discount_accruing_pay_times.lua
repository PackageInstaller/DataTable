-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_discount_accruing_pay_times.lua

module("logicconfig.config.t_discount_accruing_pay_times", package.seeall)

local title = {
	buyTimes = 2,
	payGoodsId = 3,
	payPlanId = 1
}
local dataList = {
	{
		1,
		1,
		"rmb_45"
	},
	{
		1,
		2,
		"rmb_28"
	},
	{
		1,
		3,
		"rmb_12"
	}
}
local t_discount_accruing_pay_times = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_discount_accruing_pay_times.dataList = dataList

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

return t_discount_accruing_pay_times
