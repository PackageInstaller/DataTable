-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pin_dao_dao_activity.lua

module("logicconfig.config.t_pin_dao_dao_activity", package.seeall)

local title = {
	helpReduceLimit = 2,
	buyGoodsLimit = 3,
	maxReduceCount = 4,
	chatCd = 6,
	activityId = 1,
	ruleKey = 5
}
local dataList = {
	{
		565001,
		10,
		1,
		680,
		"pin_dao_dao_rule",
		10
	}
}
local t_pin_dao_dao_activity = {
	[565001] = dataList[1]
}

t_pin_dao_dao_activity.dataList = dataList

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

return t_pin_dao_dao_activity
