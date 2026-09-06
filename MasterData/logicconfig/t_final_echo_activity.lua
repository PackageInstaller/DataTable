-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_final_echo_activity.lua

module("logicconfig.config.t_final_echo_activity", package.seeall)

local title = {
	ruleKey = 3,
	activityId = 1,
	formula = 2
}
local dataList = {
	{
		495001,
		{
			"大于",
			"大于",
			"大于"
		},
		"final_echo_rulekey"
	}
}
local t_final_echo_activity = {
	[495001] = dataList[1]
}

t_final_echo_activity.dataList = dataList

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

return t_final_echo_activity
