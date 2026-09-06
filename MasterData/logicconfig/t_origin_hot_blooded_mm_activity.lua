-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_hot_blooded_mm_activity.lua

module("logicconfig.config.t_origin_hot_blooded_mm_activity", package.seeall)

local title = {
	jumpToPrize = 5,
	jumpToRank = 4,
	jumpToPack = 7,
	jumpToShop = 6,
	raceId = 3,
	ruleKeyMain = 8,
	activityId = 1,
	passPrize = 2
}
local dataList = {
	{
		599001,
		"4:510799:100",
		12046,
		"func#618#12046",
		"mibao#mengduiyangcheng",
		"ui#lottery",
		"func#95#mengduiyangcheng#all#251301",
		"originhotbloodmmclg_rule"
	}
}
local t_origin_hot_blooded_mm_activity = {
	[599001] = dataList[1]
}

t_origin_hot_blooded_mm_activity.dataList = dataList

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

return t_origin_hot_blooded_mm_activity
