-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_survival_king_sign_in_activity.lua

module("logicconfig.config.t_survival_king_sign_in_activity", package.seeall)

local title = {
	finishPrize = 2,
	activityId = 1,
	ruleKey = 3
}
local dataList = {
	{
		530001,
		"13:479:1#104:2:388#4:510243:5",
		"rule_survival_king_sign_in"
	}
}
local t_survival_king_sign_in_activity = {
	[530001] = dataList[1]
}

t_survival_king_sign_in_activity.dataList = dataList

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

return t_survival_king_sign_in_activity
