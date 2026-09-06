-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_material_game_weapon.lua

module("logicconfig.config.t_origin_material_game_weapon", package.seeall)

local title = {
	weaponDes = 4,
	weaponPic = 3,
	skillPicture = 6,
	weaponId = 1,
	weaponName = 2,
	skillName = 5
}
local dataList = {
	{
		1,
		"时轮",
		"board_wuqi_shilun",
		"范围伤害，以武器中心为圆点，对半径X的一圈障碍/敌人造成伤害，每X秒一次",
		"时轮",
		"expevents/icon_expedition_xueliang"
	},
	{
		2,
		"火焰",
		"board_wuqi_huoqiu",
		"子弹伤害+灼烧，对进入半径X射程内的障碍/敌人造成伤害，每X秒一次，附带持续X秒的灼烧效果-障碍/敌人每X秒掉X血量（同一时间只能触发1个灼烧效果）",
		"火焰",
		"expevents/icon_expedition_wugong"
	},
	{
		3,
		"恶魔镰刀",
		"board_wuqi_liandao",
		"子弹伤害-分裂，对进入半径X射程内的障碍/敌人造成伤害，每X秒一次，击中障碍/敌人后分裂出X个小镰刀，飞向距离最近的障碍/敌人（优先敌人）",
		"恶魔镰刀",
		"expevents/icon_expedition_wushang"
	},
	{
		4,
		"冰箭",
		"board_wuqi_binggong",
		"扇形子弹伤害-减速，同时发出多枚子弹，对进入半径X射程内的障碍/敌人造成伤害，每X秒一次，附带持续X秒的减速X%效果（同一时间只能触发1个减速效果）",
		"冰箭",
		"expevents/icon_expedition_shoujibingdong"
	},
	{
		5,
		"枪",
		"board_wuqi_qiang",
		"子弹伤害-冻结，对进入半径X射程内的障碍/敌人造成伤害，每X秒一次，暂停敌人行动X秒（同一时间只能触发1个暂停效果）",
		"枪",
		"expevents/icon_expedition_shenqi_huo"
	},
	{
		6,
		"猫头",
		"board_wuqi_maotou",
		"穿透伤害，对进入半径X射程内的障碍/敌人造成伤害，每X秒一次，对飞行路径上的障碍/敌人均造成同等伤害",
		"猫头",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		7,
		"蝴蝶",
		"board_wuqi_hudie",
		"子弹伤害，对进入半径X射程内的障碍/敌人造成伤害，每X秒一次",
		"蝴蝶",
		"expevents/icon_expedition_wufangqishi"
	},
	{
		8,
		"双刀",
		"board_wuqi_shuangdao",
		"前后方向子弹，对双刀前后进入半径X射程内的障碍/敌人造成伤害，每X秒一次",
		"双刀",
		"expevents/icon_expedition_shoujibingdong"
	},
	{
		9,
		"剑",
		"board_wuqi_jian",
		"穿透伤害-翻倍，对进入半径X射程内的障碍/敌人造成伤害，每X秒一次，对飞行路径上的障碍/敌人均造成同等伤害，攻击次数为X的倍数时放大招伤害翻倍",
		"剑",
		"expevents/icon_expedition_shenqi_huo"
	},
	{
		10,
		"源石",
		"board_wuqi_yuanshi",
		"子弹伤害-爆炸，以武器中心为圆点，对半径X的一圈障碍/敌人造成伤害，每X秒一次，击中敌人时，会在被击中的敌人处造成半径为X的爆炸伤害",
		"源石",
		"expevents/icon_expedition_wushifangyu"
	},
	{
		11,
		"时间之轮",
		"board_wuqi_shixunuoya",
		"扇形子弹伤害-减速，同时发出多枚子弹，对进入半径X射程内的障碍/敌人造成伤害，每X秒一次，附带持续X秒的减速X%效果（同一时间只能触发1个减速效果）",
		"时间之轮",
		"expevents/icon_expedition_zhenying_03"
	},
	{
		12,
		"天外神石",
		"board_wuqi_wangzheciyuan",
		"子弹伤害，快速对进入半径X射程内的障碍/敌人造成伤害，每X秒一次",
		"天外神石",
		"expevents/icon_expedition_numu"
	},
	{
		13,
		"星神之力",
		"board_wuqi_yuehuanuoya",
		"前后方向子弹，对双刀前后进入半径X射程内的障碍/敌人造成伤害，每X秒一次",
		"星神之力",
		"expevents/icon_expedition_shayi"
	},
	{
		14,
		"光之宝剑",
		"board_wuqi_qi",
		"子弹伤害-冻结，对进入半径X射程内的障碍/敌人造成伤害，每X秒一次，暂停敌人行动X秒（同一时间只能触发1个暂停效果）",
		"光之宝剑",
		"expevents/icon_expedition_xieli01"
	},
	{
		15,
		"浴血魔瓶",
		"board_wuqi_aixi",
		"穿透伤害，对进入半径X射程内的障碍/敌人造成伤害，每X秒一次，对飞行路径上的障碍/敌人均造成同等伤害",
		"浴血魔瓶",
		"expevents/icon_xingyu_02"
	},
	{
		16,
		"极之圣剑",
		"board_wuqi_yuanqiji",
		"扇形子弹伤害-冰冻，同时发出多枚子弹，对进入半径X射程内的障碍/敌人造成伤害，每X秒一次，暂停敌人行动X秒（同一时间只能触发1个暂停效果）",
		"极之圣剑",
		"expevents/icon_expedition_zhenying_03"
	},
	{
		17,
		"创世圣龙",
		"board_wuqi_chuangshilong",
		"子弹伤害+灼烧，对进入半径X射程内的障碍/敌人造成伤害，每X秒一次，附带持续X秒的灼烧效果-障碍/敌人每X秒掉X血量（同一时间只能触发1个灼烧效果）",
		"创世圣龙",
		"expevents/icon_expedition_numu"
	},
	{
		18,
		"学神魔方",
		"board_wuqi_diyiming",
		"子弹伤害-减速，对进入半径X射程内的障碍/敌人造成伤害，每X秒一次，附带持续X秒的减速X%效果（同一时间只能触发1个减速效果）",
		"学神魔方",
		"expevents/icon_expedition_shayi"
	},
	{
		19,
		"龙脉神剑",
		"board_wuqi_longmainuoya",
		"穿透伤害，对进入半径X射程内的障碍/敌人造成伤害，每X秒一次，对飞行路径上的障碍/敌人均造成同等伤害",
		"龙脉神剑",
		"expevents/icon_expedition_xieli01"
	},
	{
		20,
		"星宇守望",
		"board_wuqi_chaoshenlong",
		"子弹伤害-爆炸，以武器中心为圆点，对半径X的一圈障碍/敌人造成伤害，每X秒一次，击中敌人时，会在被击中的敌人处造成半径为X的爆炸伤害",
		"星宇守望",
		"expevents/icon_xingyu_02"
	},
	{
		21,
		"悟命天星",
		"board_wuqi_fantian",
		"子弹伤害，对进入半径X射程内的障碍/敌人造成高额伤害，每X秒一次",
		"悟命天星",
		"expevents/icon_xingyu_02"
	}
}
local t_origin_material_game_weapon = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20],
	dataList[21]
}

t_origin_material_game_weapon.dataList = dataList

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

return t_origin_material_game_weapon
