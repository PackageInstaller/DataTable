-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_milk_dragon_clg_pos_buff.lua

module("logicconfig.config.t_milk_dragon_clg_pos_buff", package.seeall)

local title = {
	posLvl = 3,
	posType = 2,
	name = 5,
	desc = 6,
	activityId = 1,
	lvlUpCostScore = 4
}
local dataList = {
	{
		451001,
		1,
		0,
		0,
		"翅膀",
		"无"
	},
	{
		451001,
		1,
		1,
		1,
		"翅膀",
		"其他精灵攻击后，光耀圣龙有20%几率立即出手一次（每个大回合限1次）"
	},
	{
		451001,
		1,
		2,
		2,
		"翅膀",
		"其他精灵攻击后，光耀圣龙有40%几率立即出手一次（每个大回合限1次）"
	},
	{
		451001,
		1,
		3,
		2,
		"翅膀",
		"其他精灵攻击后，光耀圣龙有60%几率立即出手一次（每个大回合限2次）"
	},
	{
		451001,
		1,
		4,
		3,
		"翅膀",
		"其他精灵攻击后，光耀圣龙有100%几率立即出手一次（每个大回合限3次）"
	},
	{
		451001,
		2,
		0,
		0,
		"头盔",
		"无"
	},
	{
		451001,
		2,
		1,
		1,
		"头盔",
		"光耀圣龙每次受击时，自身获得最大生命值*10%的护盾"
	},
	{
		451001,
		2,
		2,
		2,
		"头盔",
		"光耀圣龙每次受击时，自身获得最大生命值*20%的护盾"
	},
	{
		451001,
		2,
		3,
		2,
		"头盔",
		"光耀圣龙每次受击时，自身获得最大生命值*30%的护盾"
	},
	{
		451001,
		2,
		4,
		3,
		"头盔",
		"光耀圣龙每次受击时，自身获得最大生命值*50%的护盾"
	},
	{
		451001,
		3,
		0,
		0,
		"战甲",
		"无"
	},
	{
		451001,
		3,
		1,
		1,
		"战甲",
		"光耀圣龙受到的一切伤害降低10%"
	},
	{
		451001,
		3,
		2,
		2,
		"战甲",
		"光耀圣龙受到的一切伤害降低20%"
	},
	{
		451001,
		3,
		3,
		2,
		"战甲",
		"光耀圣龙受到的一切伤害降低30%"
	},
	{
		451001,
		3,
		4,
		3,
		"战甲",
		"光耀圣龙受到的一切伤害降低50%"
	},
	{
		451001,
		4,
		0,
		0,
		"利爪",
		"无"
	},
	{
		451001,
		4,
		1,
		1,
		"利爪",
		"光耀圣龙攻击后，获得20点气势"
	},
	{
		451001,
		4,
		2,
		2,
		"利爪",
		"光耀圣龙攻击后，获得40点气势"
	},
	{
		451001,
		4,
		3,
		2,
		"利爪",
		"光耀圣龙攻击后，获得60点气势"
	},
	{
		451001,
		4,
		4,
		3,
		"利爪",
		"光耀圣龙攻击后，获得100点气势"
	}
}
local t_milk_dragon_clg_pos_buff = {
	[451001] = {
		{
			[0] = dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5]
		},
		{
			[0] = dataList[6],
			dataList[7],
			dataList[8],
			dataList[9],
			dataList[10]
		},
		{
			[0] = dataList[11],
			dataList[12],
			dataList[13],
			dataList[14],
			dataList[15]
		},
		{
			[0] = dataList[16],
			dataList[17],
			dataList[18],
			dataList[19],
			dataList[20]
		}
	}
}

t_milk_dragon_clg_pos_buff.dataList = dataList

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

return t_milk_dragon_clg_pos_buff
