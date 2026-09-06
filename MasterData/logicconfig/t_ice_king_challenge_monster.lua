-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ice_king_challenge_monster.lua

module("logicconfig.config.t_ice_king_challenge_monster", package.seeall)

local title = {
	challengeId = 1,
	name = 5,
	WinDesc = 10,
	skipTime = 12,
	battleDesc = 7,
	showFaceId = 11,
	creepsMasterId = 4,
	day = 2,
	btlBg = 13,
	missionDesc = 6,
	btlMode = 14,
	winId = 15,
	perfectWinId = 8,
	stage = 3,
	retreatMsgType = 16,
	isHideOp = 9
}
local dataList = {
	{
		15,
		1,
		1,
		1001,
		"浮冰之路第1阵",
		"",
		"存活精灵数",
		25,
		1,
		"击败敌阵全部精灵",
		10075,
		15,
		"",
		"",
		0,
		0
	},
	{
		15,
		1,
		2,
		1002,
		"浮冰之路第2阵",
		"冰封之力：敌阵精灵受到攻击20%概率冰冻攻击者",
		"存活精灵数",
		25,
		1,
		"击败敌阵全部精灵",
		10127,
		15,
		"",
		"",
		0,
		0
	},
	{
		15,
		1,
		3,
		1003,
		"浮冰之路第3阵",
		"冰封之力：敌阵精灵受到攻击25%概率冰冻攻击者",
		"存活精灵数",
		25,
		1,
		"击败敌阵全部精灵",
		10338,
		15,
		"",
		"",
		0,
		0
	},
	{
		15,
		1,
		4,
		1004,
		"浮冰之路第4阵",
		"冰封之力：敌阵精灵受到攻击30%概率冰冻攻击者",
		"存活精灵数",
		25,
		1,
		"击败敌阵全部精灵",
		10142,
		15,
		"",
		"",
		0,
		0
	},
	{
		15,
		1,
		5,
		1005,
		"浮冰之路第5阵",
		"冰封之力：敌阵精灵受到攻击35%概率冰冻攻击者",
		"存活精灵数",
		25,
		1,
		"击败敌阵全部精灵",
		10098,
		15,
		"",
		"",
		0,
		0
	}
}
local t_ice_king_challenge_monster = {
	[15] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5]
		}
	}
}

t_ice_king_challenge_monster.dataList = dataList

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

return t_ice_king_challenge_monster
