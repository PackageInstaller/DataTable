-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wheel_lottery_pool_common.lua

module("logicconfig.config.t_wheel_lottery_pool_common", package.seeall)

local title = {
	ruleKeyMain = 3,
	comPlanId = 1,
	skinId = 2
}
local dataList = {
	{
		1,
		14026,
		"wheellotterypool_rule"
	}
}
local t_wheel_lottery_pool_common = {
	dataList[1]
}

t_wheel_lottery_pool_common.dataList = dataList

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

return t_wheel_lottery_pool_common
