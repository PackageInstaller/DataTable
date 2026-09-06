-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_dragon_monster.lua

module("logicconfig.config.t_divine_king_dragon_monster", package.seeall)

local title = {
	description = 8,
	name = 2,
	WinDesc = 15,
	skipTime = 3,
	perfectWinId = 12,
	formCondition = 13,
	video = 9,
	btlMode = 7,
	btlBg = 4,
	selfBuffProviderId = 14,
	enableGainExp = 16,
	winId = 11,
	creepsMasterId = 1,
	heroSkillId = 5,
	recommendZdl = 6,
	introdRaceId = 10
}
local dataList = {
	{
		101,
		"1-1",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		"击败敌阵",
		false
	},
	{
		102,
		"1-2",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		"击败敌阵",
		false
	},
	{
		103,
		"1-3",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		0,
		0,
		0,
		0,
		"击败敌阵",
		false
	},
	{
		201,
		"2-1",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		58,
		0,
		0,
		0,
		"击败敌阵时己阵存活2只及以上精灵",
		false
	},
	{
		202,
		"2-2",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		58,
		0,
		0,
		0,
		"击败敌阵时己阵存活2只及以上精灵",
		false
	},
	{
		203,
		"2-3",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		58,
		0,
		0,
		0,
		"击败敌阵时己阵存活2只及以上精灵",
		false
	},
	{
		301,
		"3-1",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		57,
		0,
		0,
		0,
		"击败敌阵时己阵存活3只及以上精灵",
		false
	},
	{
		302,
		"3-2",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		57,
		0,
		0,
		0,
		"击败敌阵时己阵存活3只及以上精灵",
		false
	},
	{
		303,
		"3-3",
		5,
		"",
		"",
		0,
		"",
		"",
		false,
		0,
		57,
		0,
		0,
		0,
		"击败敌阵时己阵存活3只及以上精灵",
		false
	}
}
local t_divine_king_dragon_monster = {
	[101] = dataList[1],
	[102] = dataList[2],
	[103] = dataList[3],
	[201] = dataList[4],
	[202] = dataList[5],
	[203] = dataList[6],
	[301] = dataList[7],
	[302] = dataList[8],
	[303] = dataList[9]
}

t_divine_king_dragon_monster.dataList = dataList

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

return t_divine_king_dragon_monster
