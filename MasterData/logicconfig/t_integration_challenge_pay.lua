-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_integration_challenge_pay.lua

module("logicconfig.config.t_integration_challenge_pay", package.seeall)

local title = {
	payGoodsId = 2,
	payPlanId = 1
}
local dataList = {
	{
		1,
		"rmb_18"
	}
}
local t_integration_challenge_pay = {
	dataList[1]
}

t_integration_challenge_pay.dataList = dataList

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

return t_integration_challenge_pay
