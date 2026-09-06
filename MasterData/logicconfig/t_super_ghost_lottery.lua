-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_super_ghost_lottery.lua

module("logicconfig.config.t_super_ghost_lottery", package.seeall)

local title = {
	drawCost = 4,
	titleName = 5,
	isShow = 9,
	prizePlanId = 2,
	bgRes = 6,
	introduceKey = 8,
	bigPrizeNum = 3,
	activityId = 1,
	ruleKey = 7
}
local dataList = {
	{
		260001,
		1,
		3,
		"10:250003:1",
		"第一弹",
		"",
		"zhounianreward_rule",
		"zhounianreward_rule",
		true
	}
}
local t_super_ghost_lottery = {
	[260001] = dataList[1]
}

t_super_ghost_lottery.dataList = dataList

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

return t_super_ghost_lottery
