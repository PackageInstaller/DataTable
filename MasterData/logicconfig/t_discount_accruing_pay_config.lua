-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_discount_accruing_pay_config.lua

module("logicconfig.config.t_discount_accruing_pay_config", package.seeall)

local title = {
	exgift = 4,
	modelConfig = 6,
	payPlanId = 3,
	raceId = 5,
	activityId = 1,
	giftPlanId = 2
}
local dataList = {
	{
		38001,
		1,
		1,
		"4:41004:1#4:503:10",
		10324,
		{
			0,
			-340,
			1
		}
	}
}
local t_discount_accruing_pay_config = {
	[38001] = dataList[1]
}

t_discount_accruing_pay_config.dataList = dataList

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

return t_discount_accruing_pay_config
