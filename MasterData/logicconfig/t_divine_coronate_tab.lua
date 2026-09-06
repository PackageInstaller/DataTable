-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_coronate_tab.lua

module("logicconfig.config.t_divine_coronate_tab", package.seeall)

local title = {
	text = 5,
	prize = 3,
	tabId = 2,
	title = 4,
	activityId = 1
}
local dataList = {
	{
		410001,
		1,
		"60:1:1000",
		"神曜通灵特点",
		"光暗空三色通灵\r\n\r\n并可以根据场上三色及女性精灵的存活数量恢复气势"
	},
	{
		410001,
		2,
		"60:1:1000",
		"技能特点",
		"首尾打击，释放超杀时可以恢复自身气势"
	},
	{
		410001,
		3,
		"60:1:1000",
		"被动特点",
		"受击或攻击时根据自身所拥有的气势获得额外增益"
	},
	{
		410001,
		4,
		"4:31:5",
		"学术交流",
		"元素秘辛一役后，奥奇学院同神裁协盟展开了热烈的学术交流活动，精灵大陆无数新秀对龙族所掌握的古老知识趋之若鹜，而恰好这也是协盟新鲜血液的主要来源之一。"
	},
	{
		410001,
		5,
		"4:36:5",
		"优质生源",
		"诺雅求学期间深得圣龙们的青睐，小妮子相比起哥哥那一辈愣头青，古灵精怪、悟性十足，一时成为除生命神殿之外、各大神殿候选神使的抢手货色。"
	},
	{
		410001,
		6,
		"4:31:5",
		"竞业战争",
		"时空圣龙与次元圣龙向来不太对付，在争夺候选神使时，往往会格外用力，导致其他圣龙苦不堪言，好在秩序大人明察秋毫，颁布了双向选择就业法，只不过这次轮到了诺雅头痛……"
	},
	{
		410001,
		7,
		"4:36:5",
		"职场生存手册",
		"神裁协盟各大神殿的明争暗斗由来已久，好在诺雅深得老哥真传——不要轻易掺和圣龙大人们之间的爱恨情仇，神龙斗法，凡者遭殃，早日学成归去才是上策。"
	}
}
local t_divine_coronate_tab = {
	[410001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_divine_coronate_tab.dataList = dataList

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

return t_divine_coronate_tab
