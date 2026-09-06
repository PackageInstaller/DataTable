-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_golden_tower_lottery_common.lua

module("logicconfig.config.t_golden_tower_lottery_common", package.seeall)

local title = {
	activityId = 1,
	ruleKey = 2
}
local dataList = {
	{
		606001,
		"golden_tower_lottery_rule"
	}
}
local t_golden_tower_lottery_common = {
	[606001] = dataList[1]
}

t_golden_tower_lottery_common.dataList = dataList

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

return t_golden_tower_lottery_common
