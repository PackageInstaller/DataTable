-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ts_dragon_loard_clg_activity.lua

module("logicconfig.config.t_divine_ts_dragon_loard_clg_activity", package.seeall)

local title = {
	activityId = 1,
	comPlanId = 2
}
local dataList = {
	{
		418001,
		1
	},
	{
		418002,
		1
	}
}
local t_divine_ts_dragon_loard_clg_activity = {
	[418001] = dataList[1],
	[418002] = dataList[2]
}

t_divine_ts_dragon_loard_clg_activity.dataList = dataList

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

return t_divine_ts_dragon_loard_clg_activity
