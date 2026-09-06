-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_master_form_threshold.lua

module("logicconfig.config.t_master_form_threshold", package.seeall)

local title = {
	strFormat = 3,
	thresholdId = 1,
	thresholdParam = 2
}
local dataList = {
	{
		1,
		"128",
		"s.{areaId}巅峰赛{rank}强"
	},
	{
		2,
		"35:20",
		"s.{areaId}竞技场{rank}名"
	}
}
local t_master_form_threshold = {
	dataList[1],
	dataList[2]
}

t_master_form_threshold.dataList = dataList

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

return t_master_form_threshold
