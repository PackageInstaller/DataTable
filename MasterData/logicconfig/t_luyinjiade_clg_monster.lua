-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luyinjiade_clg_monster.lua

module("logicconfig.config.t_luyinjiade_clg_monster", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	heavenAwakenSummonPetId = 13,
	skipTime = 3,
	retreatMsgType = 7,
	heavenAwakenMasterId = 12,
	ruleDesc = 11,
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
		"时之领域",
		5,
		"",
		"",
		117,
		0,
		424,
		0,
		"",
		"己阵所有精灵行动后附加1层“时之痕\"，上阵英雄职业的精灵附加两层“时之痕”，时之痕每达到5层会对敌方全体造成伤害",
		"2",
		"7"
	},
	{
		1002,
		"魂之领域",
		5,
		"",
		"",
		117,
		0,
		425,
		0,
		"",
		"己阵每次达到50点通灵进度时，将释放一次灭魂：清空己阵通灵进度，并对敌阵全体造成伤害",
		"2",
		"7"
	},
	{
		1003,
		"契之领域",
		5,
		"",
		"",
		117,
		0,
		411,
		0,
		"",
		"敌阵小路因加德死亡时，会对敌阵全体造成伤害",
		"2",
		"7"
	}
}
local t_luyinjiade_clg_monster = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3]
}

t_luyinjiade_clg_monster.dataList = dataList

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

return t_luyinjiade_clg_monster
