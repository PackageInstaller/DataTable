-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_2023_annual_fee_preheat_design.lua

module("logicconfig.config.t_2023_annual_fee_preheat_design", package.seeall)

local title = {
	mapLength = 5,
	mapWidth = 6,
	cluePicture = 7,
	designPlanId = 1,
	id = 2,
	content = 8,
	prize = 4,
	cluePlanId = 3
}
local dataList = {
	{
		1,
		1,
		1,
		"8:1:300000",
		6,
		5,
		"items/icon_nianfei_01",
		"离阳羽伞由龙羽和龙珠制作，而领神与龙族是敌人，难道这是敖九战胜龙族的证明吗？可只有龙族消亡前自愿献出，才会有这种守护的力量。敖九和那名龙族，到底是什么关系？"
	},
	{
		1,
		2,
		2,
		"7:134086:0:1",
		6,
		5,
		"items/icon_nianfei_18",
		"属于敖九护卫的刀。敖九小时候与他一同出走，证明敖九十分信任这名护卫；离阳羽伞的制作参考了这把刀，可想而知敖九一直在怀念对方。这刀的主人力量强大，能保护敖九离开传说中“只进不出”的暗影区域，可为何没有在传说里留下姓名？而刀鞘上刻着的“安”字又代表了什么？"
	},
	{
		1,
		3,
		3,
		"7:133086:0:1",
		6,
		5,
		"items/icon_nianfei_14",
		"神秘的笼组织遍布在离阳国中，该组织的成员似乎是各种族混血，并在暗中推动混血种族保护法则。该组织势力有强大的后盾，可以拉拢神域高等级人物合作，而洛塔也是该组织成员之一。笼组织的笼主，很可能就是洛塔的主人——敖九。"
	},
	{
		1,
		4,
		4,
		"4:31:10",
		6,
		5,
		"items/icon_nianfei_06",
		"敖九对毛毛的偏爱，是出于毛毛在他最痛苦时刻的陪伴。但耀晶石都被龙族收藏，毛毛为何能寻到并送给敖九，难道毛毛与敖九的侍卫、隐藏的父亲——卫久，真的有关系吗？"
	},
	{
		2,
		1,
		5,
		"4:31:10",
		6,
		5,
		"items/icon_yuansu_05",
		"斐希司天性温和，有容乃大，有一颗可以温暖世界的璀璨之心，但这份仁慈并非恒久所有，倘若冒犯到他内心深处所珍惜守护之物，来自源头的神圣力量也会显露出极度危险的一面。常言道“好奇害死猫”，作为见证者，斐希司一直以来旁观了精灵大陆的一生，却只能置身事外，因此对这个世界的一切都倍感好奇，什么都想尝试一番，百无禁忌。"
	},
	{
		2,
		2,
		6,
		"4:31:10",
		6,
		5,
		"items/icon_yuansu_08",
		"斐希司的本体真身是一只色泽缤纷，晶莹剔透的五彩团子，具有拟态能力，可以变成任何想要变成的事物，此即为万物之源的本质——可化万物，遗憾的是，他只对龙情有独钟。斐希司的诞生在精灵大陆创世之初便以火种之源的形态存在，随着年岁积累逐渐萌生神识，神柱封印消失后，得益于火种碎裂，获得了来之不易的自由。斐希司即是元素火种本尊。"
	},
	{
		2,
		3,
		7,
		"4:111:10",
		6,
		5,
		"items/icon_yuansu_06",
		"奥奇击碎了元素火种，斐希司因祸得福，逃离禁锢获得了自由，但所背负的职责也遭到亵渎，即便奥奇为了将功赎过踏上了复原火种的艰难险途，但这份为了守护大陆而击碎火种初衷，斐希司可不会认同。"
	},
	{
		2,
		4,
		8,
		"4:36:10",
		6,
		5,
		"items/icon_yuansu_07",
		"力量孱弱的斐希司借助凡尔维斯视角体验人生，往事记忆历历在目，似乎只有切身经历过才能知悉其中酸楚——世事或许并不是表面看上去那么简单，在这场关乎源火的角逐战中，每个神，每个精灵都无法全身而退……"
	}
}
local t_2023_annual_fee_preheat_design = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_2023_annual_fee_preheat_design.dataList = dataList

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

return t_2023_annual_fee_preheat_design
