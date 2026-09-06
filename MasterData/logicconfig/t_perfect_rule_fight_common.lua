-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_perfect_rule_fight_common.lua

module("logicconfig.config.t_perfect_rule_fight_common", package.seeall)

local title = {
	gotoRank = 15,
	name = 2,
	reRandomCost = 5,
	difficultyview = 9,
	ruleKey = 17,
	isShowPet = 16,
	ruleview = 11,
	rankPrize = 6,
	dailyTimes = 3,
	ruleshowview = 10,
	challengeId = 1,
	passruleview = 13,
	gotoShop = 14,
	resultview = 12,
	rankLimit = 7,
	progressPrizePlanId = 8,
	dailyPrize = 4
}
local dataList = {
	{
		19,
		"镭拉挑战",
		5,
		"4:113:50",
		"105:167:50",
		"14:41:1",
		9999,
		0,
		"leiladifficultyview",
		"leilaruleshowview",
		"leilaruleview",
		"leilaresultview",
		"qianlipassruleview",
		"",
		"",
		false,
		""
	},
	{
		24,
		"牛妹挑战",
		5,
		"4:124:50",
		"105:167:50",
		"14:46:1",
		9999,
		0,
		"qianlidifficultyview",
		"leilaruleshowview",
		"qianliruleview",
		"leilaresultview",
		"qianlipassruleview",
		"",
		"",
		false,
		""
	},
	{
		46,
		"圣骑阿修挑战",
		9999,
		"",
		"105:167:50",
		"14:46:1",
		9999,
		1,
		"axiudifficultyview",
		"leilaruleshowview",
		"axiuruleview",
		"axiuresultview",
		"qianlipassruleview",
		"",
		"",
		false,
		""
	},
	{
		59,
		"光元素师挑战",
		5,
		"",
		"105:167:50",
		"14:41:1",
		9999,
		0,
		"guangyuansushidifficultyview",
		"guangyuansushiruleshowview",
		"guangyuansushiruleview",
		"guangyuansushiresultview",
		"guangyuansushipassruleview",
		"mibao#liyangshop4",
		"func#618#14009",
		false,
		""
	},
	{
		111,
		"火麒麟挑战",
		5,
		"",
		"105:167:50",
		"14:41:1",
		9999,
		2,
		"huoqilindifficultyview",
		"huoqilinsperuleview",
		"huoqilinruleview",
		"huoqilinresultview",
		"huoqilinpassruleview",
		"mibao#WeekGift",
		"func#618#12015",
		false,
		""
	},
	{
		151,
		"正义挑战",
		5,
		"",
		"105:167:50",
		"14:41:1",
		9999,
		3,
		"justicedifficultyview",
		"justicesperuleview",
		"justiceruleview",
		"justiceresultview",
		"justicepassruleview",
		"mibao#tanggongyeyan3",
		"func#618#16018",
		true,
		"justicepassruleview_rule"
	}
}
local t_perfect_rule_fight_common = {
	[19] = dataList[1],
	[24] = dataList[2],
	[46] = dataList[3],
	[59] = dataList[4],
	[111] = dataList[5],
	[151] = dataList[6]
}

t_perfect_rule_fight_common.dataList = dataList

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

return t_perfect_rule_fight_common
