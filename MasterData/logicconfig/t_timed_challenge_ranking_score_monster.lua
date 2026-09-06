-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_ranking_score_monster.lua

module("logicconfig.config.t_timed_challenge_ranking_score_monster", package.seeall)

local title = {
	challengeId = 1,
	name = 3,
	creepMasterHeadIcon = 4,
	skipTime = 5,
	btlMode = 9,
	btlBg = 6,
	enableGainExp = 8,
	creepsMasterId = 2,
	heroSkillId = 7
}
local dataList = {
	{
		27,
		1,
		"神罚•秩序圣龙",
		11002,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		101,
		"万象·次元圣龙",
		10313,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		201,
		"绝绝",
		10033,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		202,
		"寒战·空无流",
		10084,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		203,
		"隐刺·维多利亚",
		10308,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		301,
		"当当",
		10032,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		302,
		"撒古特",
		10016,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		303,
		"千钧万盾·尤烈",
		10333,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		401,
		"闪闪",
		10035,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		402,
		"寒冰骑士",
		10017,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		403,
		"天冰神虎",
		10203,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		501,
		"怒火蜘蛛",
		10049,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		502,
		"黯墨·夜无忧",
		10086,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		503,
		"沙之王者·洛萨",
		10131,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		601,
		"极耀·时空圣龙",
		10309,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		701,
		"爆爆龙",
		10004,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		702,
		"烈阳·龙君焰",
		10084,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		703,
		"暴力少女·茜茜",
		10127,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		801,
		"蓝蓝露",
		10004,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		802,
		"食神·米淇淋",
		10335,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		803,
		"不败传说·星蓝龙",
		10127,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		901,
		"咕噜牦牛",
		10048,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		902,
		"魄月·炽辰光",
		10085,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		903,
		"天威雷神·星格",
		10130,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		1001,
		"刺锥蝎",
		10050,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		1002,
		"千鸟丸",
		10155,
		15,
		"",
		"",
		false,
		""
	},
	{
		27,
		1003,
		"创界灵尊·芒",
		10165,
		15,
		"",
		"",
		false,
		""
	}
}
local t_timed_challenge_ranking_score_monster = {
	[27] = {
		dataList[1],
		[101] = dataList[2],
		[201] = dataList[3],
		[202] = dataList[4],
		[203] = dataList[5],
		[301] = dataList[6],
		[302] = dataList[7],
		[303] = dataList[8],
		[401] = dataList[9],
		[402] = dataList[10],
		[403] = dataList[11],
		[501] = dataList[12],
		[502] = dataList[13],
		[503] = dataList[14],
		[601] = dataList[15],
		[701] = dataList[16],
		[702] = dataList[17],
		[703] = dataList[18],
		[801] = dataList[19],
		[802] = dataList[20],
		[803] = dataList[21],
		[901] = dataList[22],
		[902] = dataList[23],
		[903] = dataList[24],
		[1001] = dataList[25],
		[1002] = dataList[26],
		[1003] = dataList[27]
	}
}

t_timed_challenge_ranking_score_monster.dataList = dataList

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

return t_timed_challenge_ranking_score_monster
