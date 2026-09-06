-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xingjiang_future_challenge_monster.lua

module("logicconfig.config.t_xingjiang_future_challenge_monster", package.seeall)

local title = {
	perfectWinId = 3,
	name = 2,
	WinDesc = 5,
	skipTime = 7,
	retreatMsgType = 11,
	formCondition = 12,
	heroSkillId = 13,
	btlMode = 9,
	btlBg = 8,
	winId = 10,
	creepsMasterId = 1,
	showFaceId = 6,
	isHideOp = 4
}
local dataList = {
	{
		100001,
		"第1关",
		0,
		1,
		"击败敌阵全部精灵",
		10322,
		15,
		"",
		"",
		0,
		0,
		81,
		"410144"
	},
	{
		100002,
		"第2关",
		0,
		1,
		"1.敌阵全体精灵免疫群体打击的伤害\r\n2.击败敌阵全部精灵",
		10332,
		15,
		"",
		"",
		0,
		0,
		79,
		"410334"
	},
	{
		100003,
		"第3关",
		0,
		1,
		"1.敌阵全体精灵初始气势+50\r\n2.击败敌阵全部精灵",
		10099,
		15,
		"",
		"",
		0,
		0,
		82,
		"410328"
	},
	{
		100004,
		"第4关",
		0,
		1,
		"1.敌阵全体精灵的攻击吸收目标15气势\r\n2.击败敌阵全部精灵",
		11002,
		15,
		"",
		"",
		0,
		0,
		80,
		"414004"
	},
	{
		100005,
		"第5关",
		0,
		1,
		"1.敌阵全体精灵首次出手将额外出手一次\r\n2.击败敌阵全部精灵",
		10333,
		15,
		"",
		"",
		0,
		0,
		84,
		"416000"
	},
	{
		100006,
		"第6关",
		0,
		1,
		"1.敌阵精灵每次出手时，相邻精灵气势+15\r\n2.击败敌阵全部精灵",
		10142,
		15,
		"",
		"",
		0,
		0,
		85,
		"410142"
	},
	{
		200001,
		"第1关",
		0,
		1,
		"击败敌阵全部精灵",
		0,
		15,
		"",
		"",
		0,
		0,
		203,
		""
	},
	{
		200002,
		"第2关",
		0,
		1,
		"击败敌阵全部精灵",
		0,
		15,
		"",
		"",
		0,
		0,
		81,
		""
	},
	{
		200003,
		"第3关",
		0,
		1,
		"击败敌阵全部精灵",
		0,
		15,
		"",
		"",
		0,
		0,
		79,
		""
	},
	{
		200004,
		"第4关",
		0,
		1,
		"击败敌阵全部精灵",
		0,
		15,
		"",
		"",
		0,
		0,
		80,
		""
	},
	{
		200005,
		"第5关",
		0,
		1,
		"击败敌阵全部精灵",
		0,
		15,
		"",
		"",
		0,
		0,
		82,
		""
	}
}
local t_xingjiang_future_challenge_monster = {
	[100001] = dataList[1],
	[100002] = dataList[2],
	[100003] = dataList[3],
	[100004] = dataList[4],
	[100005] = dataList[5],
	[100006] = dataList[6],
	[200001] = dataList[7],
	[200002] = dataList[8],
	[200003] = dataList[9],
	[200004] = dataList[10],
	[200005] = dataList[11]
}

t_xingjiang_future_challenge_monster.dataList = dataList

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

return t_xingjiang_future_challenge_monster
