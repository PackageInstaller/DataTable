-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_holy_stripes.lua

module("logicconfig.config.t_season_mode_pve_holy_stripes", package.seeall)

local title = {
	suitDesc = 7,
	buffs = 4,
	suitName = 6,
	propertyApp = 3,
	camplv = 2,
	holyStripesType = 1,
	suitIcon = 8,
	provideZdlWanPercent = 5
}
local dataList = {
	{
		6014,
		1,
		"",
		"20032240:99",
		1000,
		"渴血萃势",
		"攻击时每对目标造成2%最大生命值的伤害则自身获得1点气势（单次普攻最多30点，单次超杀最多60点）",
		"icon_xitong_lingwen_14"
	},
	{
		6015,
		1,
		"",
		"20032241:99",
		1000,
		"坚如磐石",
		"单次受到攻击伤害超过自身最大生命值*30%时，此次伤害减少30%",
		"icon_xitong_lingwen_16"
	},
	{
		6016,
		1,
		"",
		"20032242:99#20032243:99",
		1000,
		"攻守并蓄",
		"攻击时若自身拥有护盾，则伤害提高20%，受击时若自身拥有护盾，则伤害减少20%",
		"icon_xitong_lingwen_15"
	},
	{
		6001,
		5,
		"",
		"20032211:99",
		1000,
		"噬电之纹",
		"对手剩余生命百分比越高，伤害加深越多，最高25%",
		"icon_xitong_lingwen_01"
	},
	{
		6004,
		5,
		"",
		"20032215:99",
		1000,
		"御尘之纹",
		"进入战斗时，获得攻击160%的护盾值",
		"icon_xitong_lingwen_04"
	},
	{
		6007,
		5,
		"",
		"20032219:99",
		1000,
		"沉石之纹",
		"己阵存活精灵越多，提升减伤越高，最高24%",
		"icon_xitong_lingwen_07"
	},
	{
		6010,
		5,
		"",
		"20032229:99",
		1000,
		"落影之纹",
		"出手前，50%概率清除所有减益效果",
		"icon_xitong_lingwen_10"
	},
	{
		6002,
		9,
		"",
		"20032212:99",
		1000,
		"破刃刻印",
		"无视目标25%防御",
		"icon_xitong_lingwen_02"
	},
	{
		6005,
		9,
		"",
		"20032217:99",
		1000,
		"血誓刻印",
		"攻击附带吸血20%，每次吸血不超自身生命值的20%",
		"icon_xitong_lingwen_05"
	},
	{
		6008,
		9,
		"",
		"20032226:99",
		1000,
		"固结刻印",
		"反弹20%攻击伤害，不超过自身生命值的40%",
		"icon_xitong_lingwen_08"
	},
	{
		6011,
		9,
		"",
		"20032231:99",
		1000,
		"复引刻印",
		"击杀目标时，恢复自身40点气势（每个大回合限1次）",
		"icon_xitong_lingwen_11"
	},
	{
		6003,
		13,
		"",
		"20032213:99",
		1000,
		"亘古鸣雷",
		"每次出手后，永久提升伤害5%，最高可叠加6次",
		"icon_xitong_lingwen_03"
	},
	{
		6006,
		13,
		"",
		"20032218:99",
		1000,
		"圣痕裂风",
		"生命百分比越低，伤害越高，最高30%",
		"icon_xitong_lingwen_06"
	},
	{
		6009,
		13,
		"",
		"20032227:99",
		1000,
		"千载岩磐",
		"每次受到攻击后，提升免伤4%，最高可叠加6次",
		"icon_xitong_lingwen_09"
	},
	{
		6012,
		13,
		"",
		"20032233:99",
		1000,
		"冥刻暗咒",
		"首次死亡时，降低击杀者全属性30%(2回合)，并有20%概率眩晕击杀者",
		"icon_xitong_lingwen_12"
	},
	{
		6013,
		13,
		"",
		"20032237:99#20032238:99",
		1000,
		"折戟御势",
		"单次受击至多受到自身35%最大生命的伤害，自身造成伤害降低20%，减伤效果最多触发1次",
		"icon_xitong_lingwen_13"
	}
}
local t_season_mode_pve_holy_stripes = {
	[6014] = dataList[1],
	[6015] = dataList[2],
	[6016] = dataList[3],
	[6001] = dataList[4],
	[6004] = dataList[5],
	[6007] = dataList[6],
	[6010] = dataList[7],
	[6002] = dataList[8],
	[6005] = dataList[9],
	[6008] = dataList[10],
	[6011] = dataList[11],
	[6003] = dataList[12],
	[6006] = dataList[13],
	[6009] = dataList[14],
	[6012] = dataList[15],
	[6013] = dataList[16]
}

t_season_mode_pve_holy_stripes.dataList = dataList

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

return t_season_mode_pve_holy_stripes
