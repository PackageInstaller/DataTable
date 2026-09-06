-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_dishitian_clg_activity.lua

module("logicconfig.config.t_origin_dishitian_clg_activity", package.seeall)

local title = {
	jumpToPrize = 5,
	jumpToRank = 4,
	jumpToFirstRank = 3,
	jumpToShop = 6,
	raceId = 2,
	activityId = 1
}
local dataList = {
	{
		575001,
		11039,
		"event#gotofirstpassrankview#575001",
		"func#618#11039",
		"mibao#jinglingyangcheng",
		"ui#lottery"
	},
	{
		575002,
		14047,
		"mibao#jinglingyangcheng",
		"func#618#14047",
		"mibao#jinglingyangcheng",
		"ui#lottery"
	}
}
local t_origin_dishitian_clg_activity = {
	[575001] = dataList[1],
	[575002] = dataList[2]
}

t_origin_dishitian_clg_activity.dataList = dataList

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

return t_origin_dishitian_clg_activity
