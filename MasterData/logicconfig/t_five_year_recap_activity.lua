-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_five_year_recap_activity.lua

module("logicconfig.config.t_five_year_recap_activity", package.seeall)

local title = {
	sharePrize = 5,
	activityId = 1,
	posterPrize = 3,
	posterPieceCount = 2,
	shareId = 4,
	ruleKey = 6
}
local dataList = {
	{
		586001,
		15,
		"1:12022:-1:1#2:296:1",
		21,
		"104:2:500#60:1:5000#4:36:10",
		"5zhounianreview_rule_01"
	}
}
local t_five_year_recap_activity = {
	[586001] = dataList[1]
}

t_five_year_recap_activity.dataList = dataList

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

return t_five_year_recap_activity
