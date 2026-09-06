-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_job.lua

module("logicconfig.config.t_pet_job", package.seeall)

local title = {
	name = 3,
	attackType = 2,
	id = 1,
	icon = 4,
	desc = 5
}
local dataList = {
	{
		1,
		1,
		"疾速",
		"icon_big_hp",
		"拥有超高的速度，上阵后能大幅增加全员速度，为己阵争取先手攻击。"
	},
	{
		2,
		2,
		"魔法",
		"icon_big_hp",
		"魔法输出，可造成大量伤害。"
	},
	{
		3,
		1,
		"利爪",
		"icon_big_hp",
		"物理输出，可造成大量伤害。"
	},
	{
		4,
		1,
		"肉盾",
		"icon_big_hp",
		"适合前排，拥有极强防御能力，可以抵挡大量伤害。"
	},
	{
		5,
		1,
		"平衡",
		"icon_big_hp",
		"可攻可守，能抵挡一定的伤害，又拥有不错的攻击力。"
	},
	{
		6,
		2,
		"治疗",
		"icon_big_hp",
		"团队辅助，能给己阵精灵进行治疗，恢复血量。"
	},
	{
		21,
		99,
		"英雄",
		"icon_big_hp",
		"拥有英雄技，上阵后可以令己阵精灵获得强大的增益效果，大幅提高战斗力。"
	},
	{
		22,
		99,
		"召唤师",
		"icon_big_hp",
		"拥有召唤技，在战斗中可召唤契约精灵一同作战，上阵第6人，大幅提高战斗力。"
	},
	{
		23,
		99,
		"魔王克星",
		"icon_big_hp",
		"对魔王造成的伤害最大上限比普通精灵更高，控制技能和削弱效果魔王不能免疫。"
	},
	{
		24,
		99,
		"远古宠",
		"icon_big_hp",
		"没有详细资料"
	},
	{
		25,
		99,
		"源兽",
		"icon_big_hp",
		"没有详细资料"
	},
	{
		26,
		99,
		"魔王",
		"icon_big_hp",
		"普通精灵对魔王造成的伤害有最大上\r\n限。魔王免疫普通精灵的控制技能和削弱\r\n效果。"
	},
	{
		27,
		99,
		"神启",
		"icon_big_hp",
		"释放领域技，战斗中可以改变战斗场景，同时大幅提高精灵战斗力。"
	},
	{
		28,
		99,
		"通灵师",
		"icon_big_hp",
		"拥有超强的唤神技能，唤神后可以进行召唤守护神进行战斗，同时也将增加自己的普攻和超杀技能效果，获得超额输出。"
	},
	{
		29,
		99,
		"元素师",
		"icon_big_hp",
		"拥有超强的元素之力，可以将己阵上阵的任意一只精灵通过元素之力转化为特定属性"
	},
	{
		30,
		99,
		"神曜",
		"icon_big_hp",
		"精灵通过神格进化所获得的全新职业，拥有专属神曜技，并且可以通过神格升级逐步解锁神曜技的威力"
	},
	{
		31,
		99,
		"天觉者",
		"icon_big_hp",
		"同时独立拥有英雄技，通灵技，召唤技效果的职业"
	},
	{
		32,
		99,
		"源起",
		"icon_big_hp",
		"精灵通过源起进化所获得的全新职业，拥有专属源起技，提升源核可激活更多的源起技效果"
	},
	{
		33,
		99,
		"唤灵师",
		"icon_big_hp",
		"可召唤出灵体，灵体行动值达到100%后可以出手"
	}
}
local t_pet_job = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	[21] = dataList[7],
	[22] = dataList[8],
	[23] = dataList[9],
	[24] = dataList[10],
	[25] = dataList[11],
	[26] = dataList[12],
	[27] = dataList[13],
	[28] = dataList[14],
	[29] = dataList[15],
	[30] = dataList[16],
	[31] = dataList[17],
	[32] = dataList[18],
	[33] = dataList[19]
}

t_pet_job.dataList = dataList

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

return t_pet_job
