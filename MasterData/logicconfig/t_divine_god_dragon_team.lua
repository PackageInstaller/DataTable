-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_god_dragon_team.lua

module("logicconfig.config.t_divine_god_dragon_team", package.seeall)

local title = {
	skipTime = 2,
	name = 11,
	WinDesc = 10,
	formCondition = 8,
	retreatMsgType = 7,
	btlMode = 5,
	btlBg = 3,
	selfBuffProviderId = 9,
	winId = 6,
	creepsMasterId = 1,
	heroSkillId = 4
}
local dataList = {
	{
		1001,
		5,
		"",
		"",
		"",
		0,
		0,
		186,
		0,
		"击败敌阵全部精灵即可过关",
		"神曜苍穹·圣光飞龙试炼"
	},
	{
		1002,
		5,
		"",
		"",
		"",
		0,
		0,
		186,
		0,
		"击败敌阵全部精灵即可过关",
		"神曜寰宇·黄金圣龙试炼"
	},
	{
		1003,
		5,
		"",
		"",
		"",
		0,
		0,
		186,
		0,
		"击败敌阵全部精灵即可过关",
		"神曜法则·秩序圣龙试炼"
	},
	{
		1004,
		5,
		"",
		"",
		"",
		0,
		0,
		186,
		0,
		"击败敌阵全部精灵即可过关",
		"神曜万象·次元龙尊试炼"
	},
	{
		1005,
		5,
		"",
		"",
		"",
		0,
		0,
		186,
		0,
		"击败敌阵全部精灵即可过关",
		"神曜赤甲·火次元试炼"
	},
	{
		2001,
		5,
		"",
		"",
		"",
		0,
		0,
		199,
		0,
		"击败敌阵全部精灵即可过关",
		"神曜苍穹·圣光飞龙试炼"
	},
	{
		2002,
		5,
		"",
		"",
		"",
		0,
		0,
		199,
		0,
		"击败敌阵全部精灵即可过关",
		"神曜寰宇·黄金圣龙试炼"
	},
	{
		2003,
		5,
		"",
		"",
		"",
		0,
		0,
		199,
		0,
		"击败敌阵全部精灵即可过关",
		"神曜法则·秩序圣龙试炼"
	},
	{
		2004,
		5,
		"",
		"",
		"",
		0,
		0,
		199,
		0,
		"击败敌阵全部精灵即可过关",
		"神曜万象·次元龙尊试炼"
	},
	{
		2005,
		5,
		"",
		"",
		"",
		0,
		0,
		199,
		0,
		"击败敌阵全部精灵即可过关",
		"神曜赤甲·火次元试炼"
	}
}
local t_divine_god_dragon_team = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[2001] = dataList[6],
	[2002] = dataList[7],
	[2003] = dataList[8],
	[2004] = dataList[9],
	[2005] = dataList[10]
}

t_divine_god_dragon_team.dataList = dataList

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

return t_divine_god_dragon_team
