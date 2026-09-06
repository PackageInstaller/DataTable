-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_breach_formation_pet_buff.lua

module("logicconfig.config.t_new_breach_formation_pet_buff", package.seeall)

local title = {
	buffResName = 5,
	name = 3,
	buffPlanId = 1,
	buffDesc = 4,
	raceId = 2
}
local dataList = {
	{
		1,
		12022,
		"附加伤害",
		"攻击时对目标造成攻击*50%的绝对毁灭伤害（无视一切减伤和保命效果）",
		"ui/icon/character/icon_12022_qijilongyan.png"
	},
	{
		1,
		14025,
		"获得气势",
		"攻击后获得40点气势",
		"ui/icon/character/icon_14025_qijinuoya.png"
	},
	{
		1,
		13019,
		"无视攻击",
		"超杀后令敌阵下一次攻击伤害为0",
		"ui/icon/character/icon_13019_qijiaruisi.png"
	},
	{
		1,
		11024,
		"加快通灵",
		"超杀后增加己阵20点通灵进度",
		"ui/icon/character/icon_11024_qijidishitian.png"
	},
	{
		1,
		15025,
		"降低气势",
		"攻击时降低目标50点气势",
		"ui/icon/character/icon_15025_qijixiuer.png"
	},
	{
		2,
		14026,
		"气势增伤",
		"己阵每次攻击时，若自身气势大于等于目标，则本次攻击命中率及伤害提高30%",
		"ui/icon/character/icon_14026_tonglingnuoya.png"
	},
	{
		2,
		14027,
		"暴击爆伤",
		"己阵每次攻击若未击杀敌人，永久增加自身15%暴击率及暴击伤害（最多触发3次）",
		"ui/icon/character/icon_14027_shenyaowangzheciyuanlong.png"
	},
	{
		2,
		14028,
		"反弹伤害",
		"己阵被攻击时，反弹受到的40%伤害给对手",
		"ui/icon/character/icon_14028_wuyuetian.png"
	},
	{
		2,
		18011,
		"受伤减少",
		"己阵受伤减少30%，若受到非属性克制攻击，则提升至受伤减少60%",
		"ui/icon/character/icon_18011_zhaohuanxiwang.png"
	},
	{
		3,
		14029,
		"移除负面",
		"每个大回合结束时，己阵每有一只精灵存活则为己方拥有负面效果最多的一位精灵移除所有负面效果",
		"ui/icon/character/icon_14029_guangandatianshi.png"
	},
	{
		4,
		14030,
		"复活隐身",
		"己阵每只精灵首次死亡时，立即满血复活并进入隐身状态（1回合）",
		"ui/icon/character/icon_14030_longhuangnuoya.png"
	},
	{
		5,
		13021,
		"复活治疗",
		"己阵每只精灵首次死亡时，己阵生命最低的2位精灵恢复40%最大生命值",
		"ui/icon/character/icon_13021_shenyaozhenlong.png"
	},
	{
		5,
		12028,
		"附加伤害",
		"己阵每次攻击时，对目标造成附带攻击力*60%的伤害，目标每受到一次攻击，则该伤害倍率增加40%（最多叠加5次）",
		"ui/icon/character/icon_12028_kunwu.png"
	},
	{
		5,
		12027,
		"受伤反击",
		"己阵精灵受到攻击后，对伤害来源造成自身攻击力*80%的伤害，若触发时自身为满血或满气则伤害改为毁灭伤害",
		"ui/icon/character/icon_12027_wangzhewujin.png"
	},
	{
		6,
		13022,
		"击杀附伤",
		"己阵精灵在攻击时，若击杀其中任意目标，则为另一目标造成自身攻击*120%的伤害",
		"ui/icon/character/icon_13022_shenyaoweida.png"
	},
	{
		6,
		11026,
		"获得气势",
		"己阵精灵在攻击后获得40点气势",
		"ui/icon/character/icon_11026_nianqingzhixu.png"
	},
	{
		6,
		11027,
		"属性削弱",
		"己阵精灵在攻击时，会降低敌方30%伤害和闪避率",
		"ui/icon/character/icon_11027_shenyaomixixi.png"
	}
}
local t_new_breach_formation_pet_buff = {
	{
		[12022] = dataList[1],
		[14025] = dataList[2],
		[13019] = dataList[3],
		[11024] = dataList[4],
		[15025] = dataList[5]
	},
	{
		[14026] = dataList[6],
		[14027] = dataList[7],
		[14028] = dataList[8],
		[18011] = dataList[9]
	},
	{
		[14029] = dataList[10]
	},
	{
		[14030] = dataList[11]
	},
	{
		[13021] = dataList[12],
		[12028] = dataList[13],
		[12027] = dataList[14]
	},
	{
		[13022] = dataList[15],
		[11026] = dataList[16],
		[11027] = dataList[17]
	}
}

t_new_breach_formation_pet_buff.dataList = dataList

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

return t_new_breach_formation_pet_buff
