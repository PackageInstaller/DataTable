-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_era_nuo_ya_activity.lua

module("logicconfig.config.t_new_era_nuo_ya_activity", package.seeall)

local title = {
	paramStr = 3,
	activityId = 1,
	skinId = 2
}
local dataList = {
	{
		535001,
		14039,
		"{\"jumpStr1\":\"func#618#14039\",\"jumpStr2\":\"event#gotofirstpassrankview#535001\",\"jumpStr3\":\"func#43#122\",\"jumpStr4\":\"ui#lottery\",\"jumpStr5\":\"mibao#Yangchenglibao\"}"
	}
}
local t_new_era_nuo_ya_activity = {
	[535001] = dataList[1]
}

t_new_era_nuo_ya_activity.dataList = dataList

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

return t_new_era_nuo_ya_activity
