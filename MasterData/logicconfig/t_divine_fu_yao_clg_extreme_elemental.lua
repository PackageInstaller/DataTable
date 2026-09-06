-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_fu_yao_clg_extreme_elemental.lua

module("logicconfig.config.t_divine_fu_yao_clg_extreme_elemental", package.seeall)

local title = {
	battleDesc = 5,
	atlas = 3,
	id = 2,
	yinjiDesc = 4,
	activityId = 1
}
local dataList = {
	{
		502001,
		1,
		{
			"水",
			"火"
		},
		"攻击目标后，获得额外出手（每个大回合限1次）",
		"攻击目标后，获得额外出手（每个大回合限1次）"
	},
	{
		502001,
		2,
		{
			"水",
			"空"
		},
		"攻击目标后，获得额外出手（每个大回合限1次）",
		"攻击目标后，获得额外出手（每个大回合限1次）"
	},
	{
		502001,
		3,
		{
			"火",
			"草"
		},
		"攻击目标后，烧伤目标，烧伤：造成自身攻击*50%的伤害",
		"攻击目标后，烧伤目标，烧伤：造成自身攻击*120%的伤害"
	},
	{
		502001,
		4,
		{
			"火",
			"空"
		},
		"攻击目标后，烧伤目标，烧伤：造成自身攻击*50%的伤害",
		"攻击目标后，烧伤目标，烧伤：造成自身攻击*120%的伤害"
	},
	{
		502001,
		5,
		{
			"草",
			"水"
		},
		"攻击目标后，恢复自身最大生命值*8%的血量",
		"攻击目标后，恢复自身最大生命值*10%的血量"
	},
	{
		502001,
		6,
		{
			"草",
			"空"
		},
		"攻击目标后，恢复自身最大生命值*8%的血量",
		"攻击目标后，恢复自身最大生命值*10%的血量"
	},
	{
		502001,
		7,
		{
			"光",
			"暗"
		},
		"攻击目标后，清除目标身上的增益效果",
		"攻击目标后，清除目标身上的增益效果"
	},
	{
		502001,
		8,
		{
			"光",
			"创"
		},
		"攻击目标后，清除目标身上的增益效果",
		"攻击目标后，清除目标身上的增益效果"
	},
	{
		502001,
		9,
		{
			"暗",
			"光"
		},
		"攻击目标后，目标减少20%防御（1回合）",
		"攻击目标后，目标获得20%受伤加深（1回合）"
	},
	{
		502001,
		10,
		{
			"暗",
			"创"
		},
		"攻击目标后，目标减少20%防御（1回合）",
		"攻击目标后，目标获得20%受伤加深（1回合）"
	},
	{
		502001,
		11,
		{
			"空",
			"光"
		},
		"攻击目标后，回复自身20点气势",
		"攻击目标后，获得免疫（持续1次攻击）"
	},
	{
		502001,
		12,
		{
			"空",
			"暗"
		},
		"攻击目标后，回复自身20点气势",
		"攻击目标后，获得免疫（持续1次攻击）"
	},
	{
		502001,
		13,
		{
			"创",
			"水"
		},
		"攻击目标后，自身获得10%的免伤（1回合）",
		"攻击目标后，吸取目标30点气势"
	},
	{
		502001,
		14,
		{
			"创",
			"火"
		},
		"攻击目标后，自身获得10%的免伤（1回合）",
		"攻击目标后，吸取目标30点气势"
	},
	{
		502001,
		15,
		{
			"创",
			"草"
		},
		"攻击目标后，自身获得10%的免伤（1回合）",
		"攻击目标后，吸取目标30点气势"
	}
}
local t_divine_fu_yao_clg_extreme_elemental = {
	[502001] = {
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
		dataList[15]
	}
}

t_divine_fu_yao_clg_extreme_elemental.dataList = dataList

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

return t_divine_fu_yao_clg_extreme_elemental
