-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_endless_dark_clg_buff.lua

module("logicconfig.config.t_endless_dark_clg_buff", package.seeall)

local title = {
	name = 5,
	costItem = 4,
	buffLv = 3,
	type = 2,
	iconPath = 7,
	activityId = 1,
	desc = 6
}
local dataList = {
	{
		555001,
		1,
		0,
		"",
		"属性加成",
		"未解锁",
		"icon_expedition_debuffzengshang"
	},
	{
		555001,
		1,
		1,
		"10:555001:10",
		"属性加成",
		"最大生命&全属性+10%",
		"icon_expedition_debuffzengshang"
	},
	{
		555001,
		1,
		2,
		"10:555001:15",
		"属性加成",
		"最大生命&全属性+50%",
		"icon_expedition_debuffzengshang"
	},
	{
		555001,
		1,
		3,
		"10:555001:25",
		"属性加成",
		"最大生命&全属性+300%",
		"icon_expedition_debuffzengshang"
	},
	{
		555001,
		1,
		4,
		"10:555001:75",
		"属性加成",
		"最大生命&全属性+500%",
		"icon_expedition_debuffzengshang"
	},
	{
		555001,
		1,
		5,
		"10:555001:150",
		"属性加成",
		"最大生命&全属性+800%",
		"icon_expedition_debuffzengshang"
	},
	{
		555001,
		2,
		0,
		"",
		"阵亡复活",
		"未解锁",
		"icon_expedition_chushouqianjianshang"
	},
	{
		555001,
		2,
		1,
		"10:555001:10",
		"阵亡复活",
		"己阵战力最高的精灵阵亡时复活并恢复30%生命值",
		"icon_expedition_chushouqianjianshang"
	},
	{
		555001,
		2,
		2,
		"10:555001:15",
		"阵亡复活",
		"己阵战力最高的精灵阵亡时复活并恢复50%生命值",
		"icon_expedition_chushouqianjianshang"
	},
	{
		555001,
		2,
		3,
		"10:555001:25",
		"阵亡复活",
		"己阵战力最高的精灵阵亡时复活并恢复100%生命值",
		"icon_expedition_chushouqianjianshang"
	},
	{
		555001,
		3,
		0,
		"",
		"无视防御",
		"未解锁",
		"icon_expedition_baojilv1"
	},
	{
		555001,
		3,
		1,
		"10:555001:10",
		"无视防御",
		"己阵攻击力最高的精灵攻击时无视对手10%防御",
		"icon_expedition_baojilv1"
	},
	{
		555001,
		3,
		2,
		"10:555001:15",
		"无视防御",
		"己阵攻击力最高的精灵攻击时无视对手20%防御",
		"icon_expedition_baojilv1"
	},
	{
		555001,
		3,
		3,
		"10:555001:25",
		"无视防御",
		"己阵攻击力最高的精灵攻击时无视对手30%防御",
		"icon_expedition_baojilv1"
	},
	{
		555001,
		4,
		0,
		"",
		"坚毅护盾",
		"未解锁",
		"icon_expedition_chushouqianjianshang"
	},
	{
		555001,
		4,
		1,
		"10:555001:10",
		"坚毅护盾",
		"己阵攻击力最高的精灵出手后给自己加最大生命值30%的护盾（1回合）",
		"icon_expedition_chushouqianjianshang"
	},
	{
		555001,
		4,
		2,
		"10:555001:15",
		"坚毅护盾",
		"己阵攻击力最高的精灵出手后给自己加最大生命值40%的护盾（1回合）",
		"icon_expedition_chushouqianjianshang"
	},
	{
		555001,
		4,
		3,
		"10:555001:25",
		"坚毅护盾",
		"己阵攻击力最高的精灵出手后给自己加最大生命值50%的护盾（1回合）",
		"icon_expedition_chushouqianjianshang"
	}
}
local t_endless_dark_clg_buff = {
	[555001] = {
		{
			[0] = dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			[0] = dataList[7],
			dataList[8],
			dataList[9],
			dataList[10]
		},
		{
			[0] = dataList[11],
			dataList[12],
			dataList[13],
			dataList[14]
		},
		{
			[0] = dataList[15],
			dataList[16],
			dataList[17],
			dataList[18]
		}
	}
}

t_endless_dark_clg_buff.dataList = dataList

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

return t_endless_dark_clg_buff
