-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_kun_lun_clg_monster.lua

module("logicconfig.config.t_divine_kun_lun_clg_monster", package.seeall)

local title = {
	formCondition = 9,
	name = 2,
	ruleDesc = 11,
	skipTime = 3,
	retreatMsgType = 7,
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
		"全民试炼-1",
		3,
		"",
		"",
		0,
		0,
		193,
		0,
		"",
		"尽可能使用更多的连击击败敌阵"
	},
	{
		1002,
		"全民试炼-2",
		3,
		"",
		"",
		0,
		0,
		193,
		0,
		"",
		"尽可能使用更多的连击击败敌阵"
	},
	{
		1003,
		"全民试炼-3",
		3,
		"",
		"",
		0,
		0,
		193,
		0,
		"",
		"尽可能使用更多的连击击败敌阵"
	},
	{
		1004,
		"全民试炼-4",
		3,
		"",
		"",
		0,
		0,
		193,
		0,
		"",
		"尽可能使用更多的连击击败敌阵"
	},
	{
		1005,
		"全民试炼-5",
		3,
		"",
		"",
		0,
		0,
		193,
		0,
		"",
		"尽可能使用更多的连击击败敌阵"
	},
	{
		1006,
		"全民试炼-6",
		3,
		"",
		"",
		0,
		0,
		193,
		0,
		"",
		"尽可能使用更多的连击击败敌阵"
	},
	{
		1007,
		"全民试炼-7",
		3,
		"",
		"",
		0,
		0,
		193,
		0,
		"",
		"尽可能使用更多的连击击败敌阵"
	},
	{
		1008,
		"全民试炼-8",
		3,
		"",
		"",
		0,
		0,
		193,
		0,
		"",
		"尽可能使用更多的连击击败敌阵"
	},
	{
		1009,
		"全民试炼-9",
		3,
		"",
		"",
		0,
		0,
		193,
		0,
		"",
		"尽可能使用更多的连击击败敌阵"
	},
	{
		2001,
		"极限试炼-1",
		3,
		"",
		"",
		0,
		0,
		193,
		209,
		"415027",
		"击败敌阵全部精灵即可过关"
	},
	{
		2002,
		"极限试炼-2",
		3,
		"",
		"",
		0,
		0,
		193,
		209,
		"417016",
		"击败敌阵全部精灵即可过关"
	},
	{
		2003,
		"极限试炼-3",
		3,
		"",
		"",
		0,
		0,
		193,
		209,
		"412027",
		"击败敌阵全部精灵即可过关"
	},
	{
		2004,
		"极限试炼-4",
		3,
		"",
		"",
		0,
		0,
		193,
		209,
		"412029",
		"击败敌阵全部精灵即可过关"
	},
	{
		2005,
		"极限试炼-5",
		3,
		"",
		"",
		0,
		0,
		193,
		209,
		"414029",
		"击败敌阵全部精灵即可过关"
	},
	{
		2006,
		"极限试炼-6",
		3,
		"",
		"",
		0,
		0,
		193,
		209,
		"416028",
		"击败敌阵全部精灵即可过关"
	}
}
local t_divine_kun_lun_clg_monster = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[1009] = dataList[9],
	[2001] = dataList[10],
	[2002] = dataList[11],
	[2003] = dataList[12],
	[2004] = dataList[13],
	[2005] = dataList[14],
	[2006] = dataList[15]
}

t_divine_kun_lun_clg_monster.dataList = dataList

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

return t_divine_kun_lun_clg_monster
