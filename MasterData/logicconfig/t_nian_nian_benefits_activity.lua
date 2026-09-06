-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_nian_nian_benefits_activity.lua

module("logicconfig.config.t_nian_nian_benefits_activity", package.seeall)

local title = {
	itemId = 6,
	achievementPlan = 4,
	partsPlan = 5,
	dialogueId = 8,
	maxItemNum = 7,
	refinePrize = 3,
	actId = 1,
	dailyPrize = 2
}
local dataList = {
	{
		77001,
		"10:77001:5",
		"4:90091:1",
		1,
		1,
		"10:77001",
		50,
		5
	}
}
local t_nian_nian_benefits_activity = {
	[77001] = dataList[1]
}

t_nian_nian_benefits_activity.dataList = dataList

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

return t_nian_nian_benefits_activity
