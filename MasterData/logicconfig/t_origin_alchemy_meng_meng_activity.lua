-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_alchemy_meng_meng_activity.lua

module("logicconfig.config.t_origin_alchemy_meng_meng_activity", package.seeall)

local title = {
	activityId = 1,
	jumpTo = 5,
	skinId = 4,
	prize = 2,
	ruleKey = 3
}
local dataList = {
	{
		601001,
		"4:510801:100",
		"yqljmm_rule",
		13031,
		{
			"func#618#13031",
			"ui#lottery",
			"mibao#mengduiyangcheng",
			"mibao#mengduiyangcheng"
		}
	}
}
local t_origin_alchemy_meng_meng_activity = {
	[601001] = dataList[1]
}

t_origin_alchemy_meng_meng_activity.dataList = dataList

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

return t_origin_alchemy_meng_meng_activity
