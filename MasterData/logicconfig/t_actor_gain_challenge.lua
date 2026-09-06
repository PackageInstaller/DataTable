-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_actor_gain_challenge.lua

module("logicconfig.config.t_actor_gain_challenge", package.seeall)

local title = {
	plotId = 14,
	mainView = 15,
	actIds = 7,
	challengeView = 16,
	jump_diamond = 6,
	attrDesc = 12,
	aword_preview = 8,
	challengeTime = 10,
	raceId = 2,
	levelsView = 17,
	rankDesc = 11,
	activityId = 1,
	jump_lottery = 4,
	item = 9,
	jump_shop = 3,
	rule = 13,
	jump_rank = 5
}
local dataList = {
	{
		165007,
		17001,
		"",
		"",
		"",
		"",
		{
			165001,
			165002,
			165003,
			165004,
			165005,
			165006
		},
		"得9650 <quad name=10:17012|icon size=40 width=1 offsetY=-10/>5460<quad name=10:17013|icon size=40 width=1 offsetY=-10/>",
		"10:17012#10:17013",
		"活动时间：07.01 5:00 - 07.22 5:00",
		"前100名可上榜，根据单次最高伤害排名",
		"属性：魔法职业最强属性；创属性，克制水火草\n技能：梦境控制，吸收力量",
		"",
		4290007,
		"lailisimainview",
		"lailisichanllengeview",
		"lailisilevelsview"
	},
	{
		165016,
		15007,
		"func#191#165#165016",
		"ui#publicdragontabview#1#1",
		"",
		"",
		{
			165011,
			165012,
			165013,
			165014,
			165015
		},
		"得9650 <quad name=4:156|icon size=40 width=1 offsetY=-10/>5460<quad name=4:156|icon size=40 width=1 offsetY=-10/>",
		"4:156",
		"活动时间：11.11 5:00 - 11.25 5:00",
		"前100名可上榜，根据单次最高伤害排名",
		"属性：魔法职业最强属性；创属性，克制水火草\n技能：梦境控制，吸收力量",
		"xingluoGatherChallenge_rule",
		0,
		"xingluomainview",
		"xingluochanllengeview",
		"xingluolevelsview"
	},
	{
		165022,
		16015,
		"func#191#165#165022",
		"ui#publicdragontabview#1#1",
		"func#618#16015",
		"func#545#3",
		{
			165017,
			165018,
			165019,
			165020,
			165021
		},
		"得9650 <quad name=4:156|icon size=40 width=1 offsetY=-10/>5460<quad name=4:156|icon size=40 width=1 offsetY=-10/>",
		"4:182",
		"活动时间：04.14 5:00 - 04.28 5:00",
		"前100名可上榜，根据单次最高伤害排名",
		"属性：魔法职业最强属性；创属性，克制水火草\n技能：梦境控制，吸收力量",
		"daiannaChallenge_rule",
		0,
		"dianamainview",
		"dianachanllengeview",
		"dianalevelsview"
	},
	{
		165028,
		11013,
		"func#191#165#165028",
		"ui#publicdragontabview#1#1",
		"func#618#11013",
		"func#545#3",
		{
			165023,
			165024,
			165025,
			165026,
			165027
		},
		"得9650 <quad name=4:156|icon size=40 width=1 offsetY=-10/>5460<quad name=4:156|icon size=40 width=1 offsetY=-10/>",
		"4:204",
		"活动时间：08.04 5:00 - 08.18 5:00",
		"前100名可上榜，根据单次最高伤害排名",
		"水系召唤 冻结冻伤",
		"holyIcekingChallenge_rule",
		0,
		"holyicekingview",
		"holyicekingchanllengeview",
		"holyicekinglevelsview"
	},
	{
		165034,
		15017,
		"func#191#165#165034",
		"ui#publicdragontabview#1#1",
		"func#618#15017",
		"func#545#3",
		{
			165029,
			165030,
			165031,
			165032,
			165033
		},
		"得9650 <quad name=4:156|icon size=40 width=1 offsetY=-10/>5460<quad name=4:156|icon size=40 width=1 offsetY=-10/>",
		"4:214",
		"活动时间：12.22 5:00 - 01.19 5:00",
		"前100名可上榜，根据单次最高伤害排名",
		"水系召唤 冻结冻伤",
		"holyMoonkingChallenge_rule",
		0,
		"holymoonkingview",
		"holymoonkingchanllengeview",
		"holymoonkinglevelsview"
	}
}
local t_actor_gain_challenge = {
	[165007] = dataList[1],
	[165016] = dataList[2],
	[165022] = dataList[3],
	[165028] = dataList[4],
	[165034] = dataList[5]
}

t_actor_gain_challenge.dataList = dataList

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

return t_actor_gain_challenge
