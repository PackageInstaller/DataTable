-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_rank.lua

module("logicconfig.config.t_timed_challenge_rank", package.seeall)

local title = {
	leaf = 2,
	name = 3,
	idx = 1,
	challengeId = 6,
	classType = 4,
	desc = 5
}
local dataList = {
	{
		10,
		0,
		"阿瑞斯挑战",
		0,
		"",
		1
	},
	{
		10,
		1,
		"暴力输出榜",
		1,
		"1，根据<color=#ebad32>单次</color>战斗中对阿瑞斯造成的伤害进行排行！\n2，造成伤害超过<color=#ebad32>50万</color>才可上榜，只会展示前10名的奥奇。",
		1
	},
	{
		10,
		2,
		"兑换名次榜",
		0,
		"1，兑换生命王者·阿瑞斯最快的<color=#ebad32>1000名玩家</color>，可获得<color=#ebad32>“阿瑞牌鸡腿”</color>称号。\n2，兑换生命王者·阿瑞斯之后，每次在精灵背包中<color=#ebad32>展示</color>阿瑞斯，会显示兑换阿瑞斯的<color=#ebad32>名次</color>。",
		1
	},
	{
		11,
		0,
		"潘多拉挑战",
		0,
		"",
		2
	},
	{
		11,
		1,
		"暴力输出榜",
		1,
		"1，根据<color=#ebad32>单次</color>战斗中对潘多拉造成的伤害进行排行！\n2，造成伤害超过<color=#ebad32>50万</color>才可上榜，只会展示前10名的奥奇。",
		2
	},
	{
		11,
		2,
		"获得名次榜",
		0,
		"1，获得梦蝶·潘多拉最快的<color=#ebad32>1000名玩家</color>，可获得<color=#ebad32>召唤券x5</color>。\n2，获得梦蝶·潘多拉之后，每次在精灵背包中<color=#ebad32>展示</color>潘多拉，会显示获得潘多拉的<color=#ebad32>名次</color>。",
		2
	},
	{
		13,
		0,
		"赤焰龙皇挑战",
		0,
		"",
		3
	},
	{
		13,
		1,
		"暴力输出榜",
		1,
		"1，根据<color=#ebad32>单次</color>战斗中对赤焰龙皇造成的伤害进行排行！\n2，造成伤害超过<color=#ebad32>50万</color>才可上榜，只会展示前10名的奥奇。",
		3
	},
	{
		13,
		2,
		"获得名次榜",
		0,
		"1，获得焚世·赤焰龙皇最快的<color=#ebad32>9999名玩家</color>，可获得<color=#ebad32>赤焰征服者</color>头像框。\n2，兑换焚世·赤焰龙皇之后，每次在精灵背包中<color=#ebad32>展示</color>赤焰龙皇，会显示兑换赤焰龙皇的<color=#ebad32>名次</color>。",
		3
	},
	{
		14,
		0,
		"弥娅挑战",
		0,
		"",
		4
	},
	{
		14,
		1,
		"获得名次榜",
		0,
		"1，获得造化之神·弥娅最快的<color=#ebad32>9999名玩家</color>，可获得<color=#ebad32>造化之眷</color>头像框。\n2，兑换造化之神·弥娅之后，每次在精灵背包中<color=#ebad32>展示</color>弥娅，会显示兑换弥娅的<color=#ebad32>名次</color>。",
		4
	},
	{
		15,
		0,
		"阿米尔挑战",
		0,
		"",
		5
	},
	{
		15,
		1,
		"暴力输出榜",
		1,
		"1，根据<color=#ebad32>单次</color>战斗中对阿米尔造成的伤害进行排行！\n2，造成伤害超过<color=#ebad32>50万</color>才可上榜，只会展示前10名的奥奇。",
		5
	},
	{
		15,
		2,
		"兑换名次榜",
		0,
		"1，兑换砂隐尊主·阿米尔最快的<color=#ebad32>9999名玩家</color>，可获得<color=#ebad32>阿米尔</color>头像框。\n2，兑换砂隐尊主·阿米尔之后，每次在精灵背包中<color=#ebad32>展示</color>阿米尔，会显示兑换阿米尔的<color=#ebad32>名次</color>。",
		5
	},
	{
		16,
		0,
		"暗黑梦梦挑战",
		0,
		"",
		0
	},
	{
		16,
		1,
		"获得名次榜",
		0,
		"1，获得哆啦梦梦之后，每次在精灵背包中<color=#ebad32>展示</color>哆啦梦梦，会显示获得哆啦梦梦的<color=#ebad32>名次</color>。",
		6
	},
	{
		17,
		0,
		"暗黑梦梦挑战",
		0,
		"",
		0
	},
	{
		17,
		1,
		"获得名次榜",
		0,
		"1，获得暗黑梦梦（以进化时间为准）最快的<color=#ebad32>9999名玩家</color>，可获得<color=#ebad32>暗夜传说</color>头像框。\n2，获得暗黑梦梦之后，每次在精灵背包中<color=#ebad32>展示</color>暗黑梦梦，会显示获得暗黑梦梦的<color=#ebad32>名次</color>。",
		8
	},
	{
		18,
		0,
		"芒挑战",
		0,
		"",
		9
	},
	{
		18,
		1,
		"创界征途榜",
		0,
		"1，根据<color=#ebad32>创界之路</color>中对通关层数进行排行！\n2，只会展示前100名的奥奇。",
		9
	},
	{
		18,
		2,
		"兑换名次榜",
		0,
		"1，兑换创界灵尊·芒最快的<color=#ebad32>9999名玩家</color>，可获得<color=#ebad32>创界神尊</color>头像框。\n2，兑换创界灵尊·芒之后，每次在精灵背包中<color=#ebad32>展示</color>创界灵尊·芒，会显示兑换创界灵尊·芒的<color=#ebad32>名次</color>。",
		9
	},
	{
		19,
		0,
		"明镜挑战",
		0,
		"",
		12
	},
	{
		19,
		1,
		"暴力输出榜",
		1,
		"1，根据<color=#ebad32>单次</color>战斗中对幽谭幻君·明镜造成的伤害进行排行！\n2，造成伤害超过<color=#ebad32>10万</color>才可上榜，只会展示前10名的奥奇。",
		12
	},
	{
		19,
		2,
		"兑换名次榜",
		0,
		"1，兑换幽谭幻君·明镜最快的<color=#ebad32>9999名玩家</color>，可获得<color=#ebad32>幽谭幻君·明镜</color>头像框。\n2，兑换幽谭幻君·明镜之后，每次在精灵背包中<color=#ebad32>展示</color>幽谭幻君·明镜，会显示兑换幽谭幻君·明镜的<color=#ebad32>名次</color>。",
		12
	},
	{
		20,
		0,
		"尤烈挑战",
		0,
		"",
		14
	},
	{
		20,
		1,
		"暴力输出榜",
		1,
		"1，根据<color=#ebad32>单次</color>战斗中对千钧万盾·尤烈造成的伤害进行排行！\n2，造成伤害超过<color=#ebad32>10万</color>才可上榜，只会展示前10名的奥奇。",
		14
	},
	{
		20,
		2,
		"兑换名次榜",
		0,
		"1，兑换千钧万盾·尤烈最快的<color=#ebad32>9999名玩家</color>，可获得<color=#ebad32>千钧万盾·尤烈</color>头像框。\n2，兑换千钧万盾·尤烈之后，每次在精灵背包中<color=#ebad32>展示</color>千钧万盾·尤烈，会显示兑换千钧万盾·尤烈的<color=#ebad32>名次</color>。",
		14
	},
	{
		21,
		0,
		"镭拉挑战",
		0,
		"",
		19
	},
	{
		21,
		1,
		"获得名次榜",
		0,
		"1，兑换镭拉最快的<color=#ebad32>9999名玩家</color>，可获得<color=#ebad32>镭拉</color>头像框。\n2，获得镭拉之后，每次在精灵背包中<color=#ebad32>展示</color>镭拉，会显示获得镭拉的<color=#ebad32>名次</color>。",
		19
	},
	{
		22,
		0,
		"末炎挑战",
		0,
		"",
		20
	},
	{
		22,
		1,
		"获得名次榜",
		0,
		"1.通过本挑战获得末炎最快的<color=#ebad32>5999名</color>玩家，可获得<color=#ebad32>专属头像框</color>。\n2.根据通关时间先后进行排名，在精灵背包中<color=#ebad32>展示</color>末炎到<color=#ebad32>聊天频道</color>显示对应<color=#ebad32>名次</color>。",
		20
	},
	{
		23,
		0,
		"诺雅挑战",
		0,
		"",
		22
	},
	{
		23,
		1,
		"获得名次榜",
		0,
		"1.通过本挑战获得诺雅最快的<color=#ebad32>9999名</color>玩家，可获得<color=#ebad32>专属头像框</color>。\n2.根据通关时间先后进行排名，在精灵背包中<color=#ebad32>展示</color>诺雅到<color=#ebad32>聊天频道</color>显示对应<color=#ebad32>名次</color>。",
		22
	},
	{
		24,
		0,
		"念念挑战",
		0,
		"",
		23
	},
	{
		24,
		1,
		"获得名次榜",
		0,
		"1.通过本挑战获得念念最快的<color=#ebad32>9999名</color>玩家，可获得<color=#ebad32>专属头像框</color>。\n2.根据通关时间先后进行排名，在精灵背包中<color=#ebad32>展示</color>念念到<color=#ebad32>聊天频道</color>显示对应<color=#ebad32>名次</color>。",
		23
	},
	{
		25,
		0,
		"千璃",
		0,
		"",
		23
	},
	{
		25,
		1,
		"获得名次榜",
		0,
		"1.通过本挑战获得千璃最快的<color=#ebad32>9999名</color>玩家，可获得<color=#ebad32>专属头像框</color>。\n2.根据通关时间先后进行排名，在精灵背包中<color=#ebad32>展示</color>千璃到<color=#ebad32>聊天频道</color>显示对应<color=#ebad32>名次</color>。",
		23
	},
	{
		26,
		0,
		"秩序龙",
		0,
		"",
		25
	},
	{
		26,
		1,
		"总分榜",
		2,
		"1.根据总分进行排名，总分越高排名越靠前。",
		25
	},
	{
		26,
		2,
		"新晋榜",
		3,
		"1.尚未通过挑战获得秩序龙的玩家，可以进入新晋榜。\n2.新晋榜前500名的玩家次日登录进入挑战可获得精灵秩序龙。",
		26
	},
	{
		27,
		0,
		"雅典娜挑战",
		0,
		"",
		28
	},
	{
		27,
		1,
		"获得名次榜",
		0,
		"1.最快通关雅典娜挑战的<color=#ebad32>9999名</color>玩家，可根据通关时间先后进行排名，在精灵背包中<color=#ebad32>展示</color>雅典娜<color=#ebad32>到聊天\n频道</color>显示对应<color=#ebad32>名次</color>。",
		28
	},
	{
		28,
		0,
		"洛塔",
		0,
		"",
		59
	},
	{
		28,
		1,
		"获得名次榜",
		0,
		"",
		59
	},
	{
		29,
		0,
		"火麒麟",
		0,
		"",
		111
	},
	{
		29,
		1,
		"获得名次榜",
		0,
		"",
		111
	},
	{
		30,
		0,
		"炼金梦梦挑战",
		0,
		"",
		115
	},
	{
		30,
		1,
		"获得名次榜",
		0,
		"1.最快通关炼金梦梦挑战的<color=#ebad32>9999名</color>玩家，可根据通关时间先后进行排名，在精灵背包中<color=#ebad32>展示</color>炼金梦梦<color=#ebad32>到聊天\n频道</color>显示对应<color=#ebad32>名次</color>。",
		115
	},
	{
		31,
		0,
		"冥皇挑战",
		0,
		"",
		147
	},
	{
		31,
		1,
		"获得名次榜",
		0,
		"1.最快通关冥皇挑战的<color=#ebad32>9999名</color>玩家，可根据通关时间先后进行排名，在精灵背包中<color=#ebad32>展示</color>冥皇<color=#ebad32>到聊天\n频道</color>显示对应<color=#ebad32>名次</color>。",
		147
	}
}
local t_timed_challenge_rank = {
	[10] = {
		[0] = dataList[1],
		dataList[2],
		dataList[3]
	},
	[11] = {
		[0] = dataList[4],
		dataList[5],
		dataList[6]
	},
	[13] = {
		[0] = dataList[7],
		dataList[8],
		dataList[9]
	},
	[14] = {
		[0] = dataList[10],
		dataList[11]
	},
	[15] = {
		[0] = dataList[12],
		dataList[13],
		dataList[14]
	},
	[16] = {
		[0] = dataList[15],
		dataList[16]
	},
	[17] = {
		[0] = dataList[17],
		dataList[18]
	},
	[18] = {
		[0] = dataList[19],
		dataList[20],
		dataList[21]
	},
	[19] = {
		[0] = dataList[22],
		dataList[23],
		dataList[24]
	},
	[20] = {
		[0] = dataList[25],
		dataList[26],
		dataList[27]
	},
	[21] = {
		[0] = dataList[28],
		dataList[29]
	},
	[22] = {
		[0] = dataList[30],
		dataList[31]
	},
	[23] = {
		[0] = dataList[32],
		dataList[33]
	},
	[24] = {
		[0] = dataList[34],
		dataList[35]
	},
	[25] = {
		[0] = dataList[36],
		dataList[37]
	},
	[26] = {
		[0] = dataList[38],
		dataList[39],
		dataList[40]
	},
	[27] = {
		[0] = dataList[41],
		dataList[42]
	},
	[28] = {
		[0] = dataList[43],
		dataList[44]
	},
	[29] = {
		[0] = dataList[45],
		dataList[46]
	},
	[30] = {
		[0] = dataList[47],
		dataList[48]
	},
	[31] = {
		[0] = dataList[49],
		dataList[50]
	}
}

t_timed_challenge_rank.dataList = dataList

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

return t_timed_challenge_rank
