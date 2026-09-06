-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_armor_hero_master.lua

module("logicconfig.config.t_armor_hero_master", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	heavenAwakenSummonPetId = 12,
	skipTime = 3,
	retreatMsgType = 7,
	heavenAwakenMasterId = 11,
	ruleDesc = 13,
	btlMode = 5,
	btlBg = 4,
	selfBuffProviderId = 8,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 10
}
local dataList = {
	{
		1001,
		"王者龙敌阵-1",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	},
	{
		1002,
		"无烬敌阵-1",
		5,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"",
		"",
		""
	}
}
local t_armor_hero_master = {
	[1001] = dataList[1],
	[1002] = dataList[2]
}

t_armor_hero_master.dataList = dataList

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

return t_armor_hero_master
