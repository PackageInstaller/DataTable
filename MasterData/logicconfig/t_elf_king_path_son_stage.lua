-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_elf_king_path_son_stage.lua

module("logicconfig.config.t_elf_king_path_son_stage", package.seeall)

local title = {
	showRule = 6,
	sonStageName = 5,
	stageId = 1,
	supportPetPlan = 4,
	battleGuideId = 9,
	picRuleKey = 7,
	isFmtShowTips = 10,
	guideId = 8,
	isShowOneKey = 11,
	sonStageId = 2,
	creepsMasterId = 3
}
local dataList = {
	{
		1,
		1,
		1001,
		1,
		"出手顺序",
		"1、了解出手与超杀规则，将精灵放在合适的站位\r\n2、通过攻击与受击积攒怒气，释放超杀优先击杀敌阵核心精灵",
		"elf_king_path_rule_1_1",
		124,
		130,
		false,
		false
	},
	{
		1,
		2,
		1002,
		2,
		"属性克制",
		"1、优先上阵克制对方属性的精灵，利用克制加成击败敌阵\r\n2、利用源属性精灵的属性转换，打出克制效果",
		"elf_king_path_rule_1_2",
		125,
		0,
		false,
		false
	},
	{
		2,
		1,
		1003,
		3,
		"契约召唤",
		"召唤师可召唤一只契约精灵一同上阵，契约精灵享有契约加成",
		"elf_king_path_rule_2_1",
		126,
		0,
		false,
		false
	},
	{
		3,
		1,
		1004,
		4,
		"英雄上阵",
		"布阵时可优先上阵满足条件的精灵，激活英雄技，使全阵精灵获得强大的增益效果",
		"elf_king_path_rule_3_1",
		127,
		0,
		false,
		false
	},
	{
		4,
		1,
		1005,
		5,
		"元素变换",
		"上阵元素师可选定己阵一只精灵，将其属性转化为与自身相同的属性，可根据属性克制、英雄技或通灵技需求进行转化",
		"elf_king_path_rule_4_1",
		128,
		0,
		false,
		false
	},
	{
		5,
		1,
		1006,
		6,
		"通灵变身",
		"通灵师是队伍的核心，通灵后精灵将得到强化，优先上阵可提升通灵进度的精灵，加速通灵",
		"elf_king_path_rule_5_1",
		129,
		131,
		false,
		false
	},
	{
		6,
		1,
		1007,
		8,
		"神曜昆仑阵",
		"神曜昆仑阵，使用神曜王者极英雄技，神曜龙主契约神曜双生龙，配合路因加德出手使得神曜昆仑快速通灵",
		"elf_king_path_rule_9_1",
		0,
		0,
		true,
		false
	},
	{
		7,
		1,
		1008,
		9,
		"神曜无敌阵",
		"神曜无敌阵，利用神曜王者诺雅、斐希司和凡尔维斯进行群攻输出，给无敌进行快速通灵收割",
		"elf_king_path_rule_8_1",
		0,
		0,
		true,
		false
	},
	{
		8,
		1,
		1009,
		10,
		"神曜伏妖阵",
		"神曜伏妖阵，利用神曜路西法、神曜余灰和神曜伏妖神曜技快速控制敌方精灵，使得伏妖快速通灵",
		"elf_king_path_rule_7_1",
		0,
		0,
		true,
		false
	},
	{
		9,
		1,
		1010,
		7,
		"神曜圣骑阵",
		"圣骑神曜技均可为敌方添加标记，标记有不同效果，在标记达到对应层数时均可被神曜圣骑队的精灵消除并触发额外效果",
		"elf_king_path_rule_6_1",
		0,
		0,
		true,
		false
	},
	{
		10,
		1,
		1011,
		11,
		"试炼一",
		"使用神曜昆仑阵、神曜无敌阵、神曜伏妖阵、神曜圣骑阵击败对方",
		"",
		0,
		0,
		true,
		false
	},
	{
		10,
		2,
		1012,
		11,
		"试炼二",
		"使用神曜昆仑阵、神曜无敌阵、神曜伏妖阵、神曜圣骑阵击败对方",
		"",
		0,
		0,
		true,
		false
	},
	{
		10,
		3,
		1013,
		11,
		"试炼三",
		"使用神曜昆仑阵、神曜无敌阵、神曜伏妖阵、神曜圣骑阵击败对方",
		"",
		0,
		0,
		true,
		false
	}
}
local t_elf_king_path_son_stage = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3]
	},
	{
		dataList[4]
	},
	{
		dataList[5]
	},
	{
		dataList[6]
	},
	{
		dataList[7]
	},
	{
		dataList[8]
	},
	{
		dataList[9]
	},
	{
		dataList[10]
	},
	{
		dataList[11],
		dataList[12],
		dataList[13]
	}
}

t_elf_king_path_son_stage.dataList = dataList

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

return t_elf_king_path_son_stage
