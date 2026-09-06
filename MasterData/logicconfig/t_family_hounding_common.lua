-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_hounding_common.lua

module("logicconfig.config.t_family_hounding_common", package.seeall)

local title = {
	ruleKeyMain = 2,
	comPlanId = 1
}
local dataList = {
	{
		1,
		"familyhoudingclgmainview_rule"
	}
}
local t_family_hounding_common = {
	dataList[1]
}

t_family_hounding_common.dataList = dataList

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

return t_family_hounding_common
