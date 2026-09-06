-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_defend_carrot_weapon.lua

module("logicconfig.config.t_defend_carrot_weapon", package.seeall)

local title = {
	weaponId = 2,
	weaponPic = 4,
	weaponName = 3,
	weaponDes = 5,
	unlockStageId = 6,
	activityId = 1
}
local dataList = {
	{
		517001,
		1,
		"时轮",
		"board_wuqi_shilun",
		"范围伤害，以武器中心为圆点，对半径X的一圈障碍/敌人造成伤害，每X秒一次",
		3
	},
	{
		517001,
		2,
		"火焰",
		"board_wuqi_huoqiu",
		"子弹伤害+灼烧，对进入半径X射程内的障碍/敌人造成伤害，每X秒一次，附带持续X秒的灼烧效果-障碍/敌人每X秒掉X血量（同一时间只能触发1个灼烧效果）",
		0
	},
	{
		517001,
		3,
		"镰刀",
		"board_wuqi_liandao",
		"子弹伤害-分裂，对进入半径X射程内的障碍/敌人造成伤害，每X秒一次，击中障碍/敌人后分裂出X个小镰刀，飞向距离最近的障碍/敌人（优先敌人）",
		0
	},
	{
		517001,
		4,
		"冰箭",
		"board_wuqi_binggong",
		"扇形子弹伤害-减速，同时发出多枚子弹，对进入半径X射程内的障碍/敌人造成伤害，每X秒一次，附带持续X秒的减速X%效果（同一时间只能触发1个减速效果）",
		0
	},
	{
		517001,
		5,
		"枪",
		"board_wuqi_qiang",
		"子弹伤害-冻结，对进入半径X射程内的障碍/敌人造成伤害，每X秒一次，暂停敌人行动X秒（同一时间只能触发1个暂停效果）",
		6
	},
	{
		517001,
		6,
		"猫头",
		"board_wuqi_maotou",
		"穿透伤害，对进入半径X射程内的障碍/敌人造成伤害，每X秒一次，对飞行路径上的障碍/敌人均造成同等伤害",
		9
	},
	{
		517001,
		7,
		"蝴蝶",
		"board_wuqi_hudie",
		"子弹伤害，对进入半径X射程内的障碍/敌人造成伤害，每X秒一次",
		0
	},
	{
		517001,
		8,
		"双刀",
		"board_wuqi_shuangdao",
		"前后方向子弹，对双刀前后进入半径X射程内的障碍/敌人造成伤害，每X秒一次",
		3
	},
	{
		517001,
		9,
		"剑",
		"board_wuqi_jian",
		"穿透伤害-翻倍，对进入半径X射程内的障碍/敌人造成伤害，每X秒一次，对飞行路径上的障碍/敌人均造成同等伤害，攻击次数为X的倍数时放大招伤害翻倍",
		9
	},
	{
		517001,
		10,
		"源石",
		"board_wuqi_yuanshi",
		"子弹伤害-爆炸，以武器中心为圆点，对半径X的一圈障碍/敌人造成伤害，每X秒一次，击中敌人时，会在被击中的敌人处造成半径为X的爆炸伤害",
		6
	}
}
local t_defend_carrot_weapon = {
	[517001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_defend_carrot_weapon.dataList = dataList

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

return t_defend_carrot_weapon
