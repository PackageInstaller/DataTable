-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_aruishi_clg_activity.lua

module("logicconfig.config.t_origin_aruishi_clg_activity", package.seeall)

local title = {
	paramStr = 2,
	raceId = 3,
	activityId = 1
}
local dataList = {
	{
		550001,
		"{\"jumpStr1\":\"func#618#13026\",\"jumpStr2\":\"ui#lottery\",\"jumpStr3\":\"mibao#jinglingyangcheng\",\"jumpStr4\":\"func#545#52\"}",
		13026
	}
}
local t_origin_aruishi_clg_activity = {
	[550001] = dataList[1]
}

t_origin_aruishi_clg_activity.dataList = dataList

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

return t_origin_aruishi_clg_activity
