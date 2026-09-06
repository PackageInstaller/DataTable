-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_element_spark_camp.lua

module("logicconfig.config.t_element_spark_camp", package.seeall)

local title = {
	desc = 7,
	name = 3,
	supportName = 5,
	shopRaceId = 6,
	campId = 2,
	headIcon = 8,
	path = 4,
	campDesc = 9,
	activityId = 1
}
local dataList = {
	{
		311001,
		1,
		"神域",
		"pet/img_16010_aojiu",
		"离阳龙脉·敖九",
		16010,
		"这个地方一点雨都不下，想回离阳国啊……快多招揽一些同伴尽快结束这场战斗吧。",
		"headicon/com_player_c",
		"神域推崇无上自由意志，以最初的元素火种为引信，点燃生命与无尽力量的秘辛。\r\n\r\n本阵营中的酒馆，将有下列精灵可招募协助战斗：赫魔莉·青骨、暗祭·达克诺斯、提琴魔偶·贝朵、离阳龙脉·敖九、大执政官·洛塔、神执统帅·特莎姆、无名之雾·撒达、神祭·萨拉诺斯"
	},
	{
		311001,
		2,
		"协盟",
		"pet/img_11011_shenyaoshuizhixu",
		"神曜法则·秩序圣龙",
		11011,
		"让混乱之地步入正轨，是吾分内之事，速速组建你的队伍，这战斗实在让人不堪入目。",
		"headicon/com_player_sada01",
		"协盟延续创世圣龙意志，维系天理与世宇法则，我们坚信混沌终散，唯有秩序永恒。\r\n\r\n\r\n本阵营中的酒馆，将有下列精灵可招募协助战斗：本至太一·原初圣龙、神曜万象·次元龙尊、神曜天元·王者圣龙、神崇王者·次元、轮回之神·正理 、不朽枯木·永恒圣龙、无序之神·昧、神判·双生圣龙、神曜法则·秩序圣龙"
	},
	{
		311001,
		3,
		"大陆",
		"pet/img_14018_shenyaowangzhenuoya",
		"神曜时隙·诺亚",
		14018,
		"无论多少次尝试，我都不会错过拯救大陆的每一种可能……我们还需要更多伙伴一同战斗！",
		"headicon/com_player_sywangzhelong01",
		"精灵们赖以为生的温馨家园，在五王与神柱的庇护下，没有任何精灵会受到伤害。\r\n\r\n\r\n本阵营中的酒馆，将有下列精灵可招募协助战斗：神曜时隙·诺亚、神曜魅冥·修尔、昼夜王者·诺雅、神曜永恒·阿瑞斯、命运终章·梵瑞、智慧神祇·帝释天、伙伴意志·极、龙魂王者·极、业火若水·天炎"
	},
	{
		311001,
		4,
		"灵界",
		"pet/img_14017_wudi",
		"无上战主·无敌",
		14017,
		"孽障累累苦痛无间，羁灵束恶报偿罪业。要不要人帮忙？那当然是却之不恭了~",
		"headicon/com_player_xiaorui",
		"自古以来，灵界以摆渡、收治灵魂为己任，任何灵魂都休想逃出灵界六道的手中。\r\n\r\n\r\n本阵营中的酒馆，将有下列精灵可招募协助战斗：无上战主·无敌、神堕虚无·伏妖、逆海吞天·兰德斯、灵界枷锁·费因、命定之恶·尘、水中幽冥·赛芙、封魔之主·黛安娜、缘来如此·司缘"
	},
	{
		311002,
		1,
		"神域",
		"pet/img_16010_aojiu",
		"离阳龙脉·敖九",
		16010,
		"这个地方一点雨都不下，想回离阳国啊……快多招揽一些同伴尽快结束这场战斗吧。",
		"headicon/com_player_c",
		"神域推崇无上自由意志，以最初的元素火种为引信，点燃生命与无尽力量的秘辛。\r\n\r\n本阵营中的酒馆，将有下列精灵可招募协助战斗：赫魔莉·青骨、暗祭·达克诺斯、提琴魔偶·贝朵、离阳龙脉·敖九、大执政官·洛塔、神执统帅·特莎姆、无名之雾·撒达、神祭·萨拉诺斯"
	},
	{
		311002,
		2,
		"协盟",
		"pet/img_11011_shenyaoshuizhixu",
		"神曜法则·秩序圣龙",
		11011,
		"让混乱之地步入正轨，是吾分内之事，速速组建你的队伍，这战斗实在让人不堪入目。",
		"headicon/com_player_sada01",
		"协盟延续创世圣龙意志，维系天理与世宇法则，我们坚信混沌终散，唯有秩序永恒。\r\n\r\n\r\n本阵营中的酒馆，将有下列精灵可招募协助战斗：本至太一·原初圣龙、神曜万象·次元龙尊、神曜天元·王者圣龙、神崇王者·次元、轮回之神·正理 、不朽枯木·永恒圣龙、无序之神·昧、神判·双生圣龙、神曜法则·秩序圣龙"
	},
	{
		311002,
		3,
		"大陆",
		"pet/img_14018_shenyaowangzhenuoya",
		"神曜时隙·诺亚",
		14018,
		"无论多少次尝试，我都不会错过拯救大陆的每一种可能……我们还需要更多伙伴一同战斗！",
		"headicon/com_player_sywangzhelong01",
		"精灵们赖以为生的温馨家园，在五王与神柱的庇护下，没有任何精灵会受到伤害。\r\n\r\n\r\n本阵营中的酒馆，将有下列精灵可招募协助战斗：神曜时隙·诺亚、神曜魅冥·修尔、昼夜王者·诺雅、神曜永恒·阿瑞斯、命运终章·梵瑞、智慧神祇·帝释天、伙伴意志·极、龙魂王者·极、业火若水·天炎"
	},
	{
		311002,
		4,
		"灵界",
		"pet/img_14017_wudi",
		"无上战主·无敌",
		14017,
		"孽障累累苦痛无间，羁灵束恶报偿罪业。要不要人帮忙？那当然是却之不恭了~",
		"headicon/com_player_xiaorui",
		"自古以来，灵界以摆渡、收治灵魂为己任，任何灵魂都休想逃出灵界六道的手中。\r\n\r\n\r\n本阵营中的酒馆，将有下列精灵可招募协助战斗：无上战主·无敌、神堕虚无·伏妖、逆海吞天·兰德斯、灵界枷锁·费因、命定之恶·尘、水中幽冥·赛芙、封魔之主·黛安娜、缘来如此·司缘"
	}
}
local t_element_spark_camp = {
	[311001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[311002] = {
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_element_spark_camp.dataList = dataList

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

return t_element_spark_camp
