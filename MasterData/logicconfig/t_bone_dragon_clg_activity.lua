-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bone_dragon_clg_activity.lua

module("logicconfig.config.t_bone_dragon_clg_activity", package.seeall)

local title = {
	ruleKeyMain = 7,
	formationNum = 4,
	skinId = 6,
	ruleKeyChallenge = 8,
	jumpTo = 5,
	refreshTimes = 3,
	recommendJob = 9,
	petLimit = 2,
	activityId = 1
}
local dataList = {
	{
		488001,
		20,
		1,
		3,
		{
			"func#618#16039",
			"mibao#MibaoShop",
			"func#998"
		},
		16039,
		"konglinglong_rule",
		"konglinglong_rule",
		{
			"2#疾速",
			"4#利爪",
			"3#魔法",
			"6#平衡",
			"4#肉盾",
			"1#治疗"
		}
	}
}
local t_bone_dragon_clg_activity = {
	[488001] = dataList[1]
}

t_bone_dragon_clg_activity.dataList = dataList

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

return t_bone_dragon_clg_activity
