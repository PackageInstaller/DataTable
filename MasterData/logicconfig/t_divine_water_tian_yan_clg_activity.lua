-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_water_tian_yan_clg_activity.lua

module("logicconfig.config.t_divine_water_tian_yan_clg_activity", package.seeall)

local title = {
	paramStr = 2,
	activityId = 1,
	skinId = 3
}
local dataList = {
	{
		513001,
		"{\"jumpStr1\":\"func#618#11034\",\"jumpStr2\":\"mibao#liudaojijie5\",\"jumpStr3\":\"ui#lottery\",\"jumpStr4\":\"event#gotofirstpassrankview#513001\"}",
		11034
	}
}
local t_divine_water_tian_yan_clg_activity = {
	[513001] = dataList[1]
}

t_divine_water_tian_yan_clg_activity.dataList = dataList

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

return t_divine_water_tian_yan_clg_activity
