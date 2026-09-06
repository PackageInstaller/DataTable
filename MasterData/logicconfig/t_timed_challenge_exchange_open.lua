-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_exchange_open.lua

module("logicconfig.config.t_timed_challenge_exchange_open", package.seeall)

local title = {
	challengeId = 1,
	name = 7,
	absoluteEndDay = 6,
	relativeEndDay = 4,
	accounts = 9,
	desc = 8,
	absoluteOpenDay = 5,
	openTimeType = 2,
	relativeOpenDay = 3
}
local dataList = {
	{
		1,
		1,
		1,
		14,
		nil,
		nil,
		"阿瑞斯挑战",
		"1，兑换生命王者·阿瑞斯最快的<color=#C54949>1000名玩家</color>，可获得<color=#C54949>“阿瑞牌鸡腿”</color>称号。\n2，兑换生命王者·阿瑞斯之后，每次在精灵背包中<color=#C54949>展示</color>阿瑞斯，会显示兑换阿瑞斯的<color=#C54949>名次</color>。",
		"4:81#4:82"
	},
	{
		3,
		2,
		0,
		0,
		"2023-05-12T05:00:00",
		"2023-05-26T05:00:00",
		"赤焰龙皇挑战",
		"消耗<color=#C54949>龙皇核心</color>可以兑换奖励",
		"4:84#4:85"
	},
	{
		4,
		2,
		0,
		0,
		"2023-12-01T05:00:00",
		"2029-12-30T05:00:00",
		"弥娅挑战",
		"1，兑换造化之神·弥娅最快的<color=#C54949>9999名玩家</color>，可获得<color=#C54949>造化之眷</color>头像框。\n2，兑换造化之神·弥娅之后，每次在精灵背包中<color=#C54949>展示</color>弥娅，会显示兑换弥娅的<color=#C54949>名次</color>。",
		"4:86"
	},
	{
		5,
		2,
		0,
		0,
		"2022-09-09T05:00:00",
		"2022-09-23T05:00:00",
		"阿米尔挑战",
		"1，兑换砂隐尊主·阿米尔最快的<color=#C54949>9999名玩家</color>，可获得<color=#C54949>阿米尔</color>头像框。\n2，兑换砂隐尊主·阿米尔之后，每次在精灵背包中<color=#C54949>展示</color>阿米尔，会显示兑换阿米尔的<color=#C54949>名次</color>。",
		"4:87#4:88"
	},
	{
		8,
		2,
		0,
		0,
		"2021-11-26T05:00:00",
		"2038-12-31T05:00:00",
		"暗黑梦梦挑战",
		"1，获得暗黑梦梦(以进化时间为准）最快的<color=#C54949>9999名玩家</color>，可获得<color=#C54949>暗夜传说</color>头像框。\n2，获得暗黑梦梦之后，每次在精灵背包中<color=#C54949>展示</color>暗黑梦梦，会显示获得暗黑梦梦的<color=#C54949>名次</color>。",
		"4:94#4:95"
	},
	{
		9,
		2,
		0,
		0,
		"2021-10-17T05:00:00",
		"2021-10-31T05:00:00",
		"芒创界挑战",
		"1，获得创界灵尊·芒最快的<color=#C54949>9999名玩家</color>，可获得<color=#C54949>创界神尊</color>头像框。\n2，获得创界灵尊·芒之后，每次在精灵背包中<color=#C54949>展示</color>创界灵尊·芒，会显示获得创界灵尊·芒的<color=#C54949>名次</color>。",
		"10:39012"
	},
	{
		12,
		2,
		0,
		0,
		"2021-10-24T05:00:00",
		"2021-10-31T05:00:00",
		"明镜挑战",
		"1，兑换明镜最快的<color=#C54949>9999名玩家</color>，可获得<color=#C54949>万千镜像</color>头像框。\n2，兑换明镜之后，每次在精灵背包中<color=#C54949>展示</color>明镜，会显示兑换明镜的<color=#C54949>名次</color>。",
		"4:97#4:98"
	},
	{
		14,
		2,
		0,
		0,
		"2023-09-08T05:00:00",
		"2023-09-22T05:00:00",
		"尤烈挑战",
		"1，兑换尤烈最快的<color=#C54949>9999名玩家</color>，可获得<color=#C54949>尤烈</color>头像框。\n2，兑换尤烈之后，每次在精灵背包中<color=#C54949>展示</color>尤烈，会显示兑换尤烈的<color=#C54949>名次</color>。",
		"4:103#4:104"
	},
	{
		19,
		2,
		0,
		0,
		"2021-11-26T05:00:00",
		"2021-12-03T05:00:00",
		"镭拉挑战",
		"1，兑换镭拉最快的<color=#C54949>9999名玩家</color>，可获得<color=#C54949>镭拉</color>头像框。\n2，获得镭拉之后，每次在精灵背包中<color=#C54949>展示</color>镭拉，会显示获得镭拉的<color=#C54949>名次</color>。",
		"4:113#4:114"
	},
	{
		22,
		2,
		0,
		0,
		"2023-12-08T05:00:00",
		"2029-12-30T05:00:00",
		"诺雅挑战",
		"1，兑换诺雅最快的<color=#C54949>9999名玩家</color>，可获得<color=#C54949>诺雅</color>头像框。\n2，兑换诺雅之后，每次在精灵背包中<color=#C54949>展示</color>诺雅，会显示兑换诺雅的<color=#C54949>名次</color>。",
		"4:121#4:122"
	},
	{
		24,
		2,
		0,
		0,
		"2023-09-01T05:00:00",
		"2023-09-15T05:00:00",
		"千璃挑战",
		"1，兑换千璃最快的<color=#C54949>9999名玩家</color>，可获得<color=#C54949>千璃</color>头像框。\n2，兑换千璃之后，每次在精灵背包中<color=#C54949>展示</color>千璃，会显示兑换千璃的<color=#C54949>名次</color>。",
		"4:124#4:125"
	},
	{
		59,
		2,
		0,
		0,
		"2025-04-03T05:00:00",
		"2038-12-31T05:00:00",
		"洛塔兑换",
		"消耗<color=#C54949>笼之徽</color>可以兑换任意奖励",
		"4:160#204:2"
	},
	{
		115,
		2,
		0,
		0,
		"2023-09-28T05:00:00",
		"2029-12-30T05:00:00",
		"炼金兑换",
		"消耗<color=#C54949>炼金试剂</color>可以兑换任意奖励",
		"4:196#204:2"
	},
	{
		138,
		2,
		0,
		0,
		"2023-12-01T05:00:00",
		"2029-12-22T05:00:00",
		"神曜光明王兑换",
		"消耗<color=#C54949>光明王道具</color>可以兑换任意奖励",
		"4:209#204:2"
	}
}
local t_timed_challenge_exchange_open = {
	dataList[1],
	[3] = dataList[2],
	[4] = dataList[3],
	[5] = dataList[4],
	[8] = dataList[5],
	[9] = dataList[6],
	[12] = dataList[7],
	[14] = dataList[8],
	[19] = dataList[9],
	[22] = dataList[10],
	[24] = dataList[11],
	[59] = dataList[12],
	[115] = dataList[13],
	[138] = dataList[14]
}

t_timed_challenge_exchange_open.dataList = dataList

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

return t_timed_challenge_exchange_open
