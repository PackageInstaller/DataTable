-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_moon_shadow_king_challenge_plan.lua

module("logicconfig.config.t_moon_shadow_king_challenge_plan", package.seeall)

local title = {
	stagePlanId = 6,
	groupName = 3,
	buffDesc = 5,
	buff = 4,
	groupId = 2,
	challengePlanId = 1
}
local dataList = {
	{
		1,
		1,
		"洛萨试炼",
		"20001051:99",
		"敌阵精灵闪避率+20%",
		1
	},
	{
		1,
		2,
		"伊丽莎白试炼",
		"20001020:99",
		"敌阵精灵属性克制时伤害+15%",
		2
	},
	{
		1,
		3,
		"暗天使试炼",
		"20001037:99",
		"敌阵精灵释放超杀后回血20%",
		3
	},
	{
		1,
		4,
		"湮灭·时空圣龙试炼",
		"20001014:99",
		"敌阵精灵阵亡时给其他精灵增加8%攻击",
		4
	},
	{
		2,
		1,
		"炎天疾速",
		"20034217:99",
		"敌阵每次攻击前随机给目标施加一个负面效果",
		5
	},
	{
		2,
		2,
		"炎轮金石",
		"20034218:99",
		"敌阵精灵受到攻击时，全阵减伤2%（2回合），最多叠加10层",
		6
	},
	{
		2,
		3,
		"赤火威鸣",
		"20034220:99",
		"敌阵精灵首次受到致命伤害时，复活并回复20%血量，全阵最多触发2次",
		7
	},
	{
		2,
		4,
		"炎罗怒击",
		"20034222:99",
		"敌阵攻击若击杀目标，复活己阵随机1只阵亡精灵并回复50%生命，全阵最多触发1次",
		8
	},
	{
		2,
		5,
		"炎踪之歌",
		"20034223:99",
		"每回合结束时，敌阵存活精灵回复10%最大生命值",
		9
	},
	{
		3,
		1,
		"磐石试炼",
		"20048901:99",
		"敌阵每次攻击后获得20%最大生命值的护盾",
		10
	},
	{
		3,
		2,
		"铁幕试炼",
		"20048903:99",
		"敌阵每次攻击后20%几率免疫下一次受到的攻击伤害",
		11
	},
	{
		3,
		3,
		"威慑试炼",
		"20048925:99",
		"己阵精灵无法获得增益效果且防御降低20%",
		12
	},
	{
		3,
		4,
		"怒火试炼",
		"20048907:99",
		"敌阵受击时额外获得20点气势",
		13
	},
	{
		3,
		5,
		"命运试炼",
		"20048908:99",
		"敌阵攻击有20%几率为目标施加命运之锁（1回合）（无法行动，无法被选为目标）",
		14
	},
	{
		4,
		1,
		"蝴蝶试炼Ⅰ",
		"20001051:99",
		"敌阵精灵闪避率+20%",
		15
	},
	{
		4,
		2,
		"蝴蝶试炼Ⅱ",
		"20001020:99",
		"敌阵精灵属性克制时伤害+15%",
		16
	},
	{
		4,
		3,
		"蝴蝶试炼Ⅲ",
		"20001037:99",
		"敌阵精灵释放超杀后回血20%",
		17
	},
	{
		4,
		4,
		"蝴蝶试炼Ⅳ",
		"20001014:99",
		"敌阵精灵阵亡时给其他精灵增加8%攻击",
		18
	}
}
local t_moon_shadow_king_challenge_plan = {
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
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	},
	{
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_moon_shadow_king_challenge_plan.dataList = dataList

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

return t_moon_shadow_king_challenge_plan
