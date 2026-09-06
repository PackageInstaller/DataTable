-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dark_mo_yan_clg_activity.lua

module("logicconfig.config.t_origin_dark_mo_yan_clg_activity", package.seeall)

local title = {
	raceId = 3,
	jumpList = 2,
	activityId = 1
}
local dataList = {
	{
		625001,
		{
			"func#618#15051",
			"mibao#jinglingyangcheng",
			"ui#lottery",
			"func#545#88",
			"func#545#88"
		},
		15051
	}
}
local t_origin_dark_mo_yan_clg_activity = {
	[625001] = dataList[1]
}

t_origin_dark_mo_yan_clg_activity.dataList = dataList

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

return t_origin_dark_mo_yan_clg_activity
