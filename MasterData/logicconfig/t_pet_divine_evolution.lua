-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_divine_evolution.lua

module("logicconfig.config.t_pet_divine_evolution", package.seeall)

local title = {
	challengeId = 6,
	petCost = 5,
	challengeAfaterId = 9,
	challengeView = 7,
	raceId = 1,
	txt = 11,
	newRaceId = 2,
	res = 10,
	goodsCost = 3,
	payJump = 8,
	des = 4
}
local dataList = {
	{
		14000,
		14001,
		"4:64001:100",
		{
			"选择等级<color=#C54949>100级</color>并且<color=#0083e7>最大觉醒等级</color>的诺雅精灵",
			"选择等级<color=#C54949>100级</color>初始品质为<color=#cd7800>传说</color>的光属性精灵",
			"选择等级<color=#C54949>100级</color>的小诺雅精灵"
		},
		{
			"Race$14000&Level$大于等于,100&InitRare$大于等于,4&AwakenLevel$大于等于,6",
			"!Race$14000&!Race$14002&!Race$14006&Level$大于等于,100&RaceType$光&InitRare$大于等于,4&!Job$源起",
			"Race$14002&Level$大于等于,100&RaceType$光&InitRare$大于等于,3"
		},
		1,
		"NoahChallengeView",
		"",
		0,
		"",
		""
	},
	{
		10145,
		14006,
		"4:64006:100",
		{
			"选择等级<color=#C54949>100级</color>并且<color=#0083e7>最大觉醒等级</color>的诺亚精灵",
			"选择等级<color=#C54949>100级</color>初始品质为<color=#cd7800>传说</color>的光属性精灵",
			"选择等级<color=#C54949>100级</color>的小诺亚精灵"
		},
		{
			"Race$10145&Level$大于等于,100&InitRare$大于等于,4&AwakenLevel$大于等于,6",
			"!Race$10145&!Race$10140&!Race$14001&Level$大于等于,100&RaceType$光&InitRare$大于等于,4&!Job$源起",
			"Race$10140&Level$大于等于,100&RaceType$光&InitRare$大于等于,3"
		},
		2,
		"nuoyashenqichallengeview",
		"",
		0,
		"",
		""
	},
	{
		10143,
		12002,
		"4:64007:100",
		{
			"选择等级<color=#C54949>100级</color>并且<color=#0083e7>最大觉醒等级</color>的龙炎精灵",
			"选择等级<color=#C54949>100级</color>初始品质为<color=#cd7800>传说</color>的火属性精灵",
			"选择等级<color=#C54949>100级</color>的小诺亚精灵"
		},
		{
			"Race$10143&Level$大于等于,100&InitRare$大于等于,4&AwakenLevel$大于等于,6",
			"!Race$10143&!Race$10138&!Race$12002&Level$大于等于,100&RaceType$火&InitRare$大于等于,4&!Job$源起",
			"Race$10138&Level$大于等于,100&RaceType$火&InitRare$大于等于,3"
		},
		38,
		"longyansqmainview",
		"mibao#LongYanShop1",
		0,
		"",
		""
	},
	{
		10142,
		11006,
		"4:64008:100",
		{
			"选择等级<color=#C54949>100级</color>并且<color=#0083e7>最大觉醒等级</color>的帝释天精灵",
			"选择等级<color=#C54949>100级</color>初始品质为<color=#cd7800>传说</color>的水属性精灵",
			"选择等级<color=#C54949>100级</color>的小天精灵"
		},
		{
			"Race$10142&Level$大于等于,100&InitRare$大于等于,4&AwakenLevel$大于等于,6",
			"!Race$10142&!Race$10137&!Race$11006&Level$大于等于,100&RaceType$水&InitRare$大于等于,4&!Job$源起",
			"Race$10137&Level$大于等于,100&RaceType$水&InitRare$大于等于,3"
		},
		41,
		"goddishitianmainview",
		"mibao#DiShiTianShop1",
		0,
		"",
		""
	},
	{
		10144,
		13003,
		"4:64009:100",
		{
			"选择等级<color=#C54949>100级</color>并且<color=#0083e7>最大觉醒等级</color>的阿瑞斯精灵",
			"选择等级<color=#C54949>100级</color>初始品质为<color=#cd7800>传说</color>的草属性精灵",
			"选择等级<color=#C54949>100级</color>的阿瑞精灵"
		},
		{
			"Race$10144&Level$大于等于,100&InitRare$大于等于,4&AwakenLevel$大于等于,6",
			"!Race$10144&!Race$10139&!Race$13003&Level$大于等于,100&RaceType$草&InitRare$大于等于,4&!Job$源起",
			"Race$10139&Level$大于等于,100&RaceType$草&InitRare$大于等于,3"
		},
		47,
		"godaruishichallengemainview",
		"mibao#AruisiShop1",
		50,
		"ui/bigbg/divineevolve/btn_shenqiaruisi_01.png",
		"生命主宰"
	},
	{
		10146,
		15015,
		"4:64010:100",
		{
			"选择等级<color=#C54949>100级</color>并且<color=#0083e7>最大觉醒等级</color>的修尔精灵",
			"选择等级<color=#C54949>100级</color>初始品质为<color=#cd7800>传说</color>的暗属性精灵",
			"选择等级<color=#C54949>100级</color>的阿修精灵"
		},
		{
			"Race$10146&Level$大于等于,100&InitRare$大于等于,4&AwakenLevel$大于等于,6",
			"!Race$10146&!Race$10141&!Race$15015&Level$大于等于,100&RaceType$暗&InitRare$大于等于,4&!Job$源起&!Job$神曜",
			"Race$10141&Level$大于等于,100&RaceType$暗&InitRare$大于等于,3"
		},
		60,
		"godxiuermainview",
		"mibao#ShenQixe",
		61,
		"ui/bigbg/divineevolve/btn_shenqixiuer_03.png",
		"是非之战"
	}
}
local t_pet_divine_evolution = {
	[14000] = dataList[1],
	[10145] = dataList[2],
	[10143] = dataList[3],
	[10142] = dataList[4],
	[10144] = dataList[5],
	[10146] = dataList[6]
}

t_pet_divine_evolution.dataList = dataList

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

return t_pet_divine_evolution
