-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_nuo_ya_buff.lua

module("logicconfig.config.t_king_nuo_ya_buff", package.seeall)

local title = {
	iconPath = 5,
	name = 4,
	buffPlanId = 2,
	addSec = 6,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		321001,
		1,
		"己阵单体攻击造成的伤害降低10%，选择后剩余时间增加135秒",
		"造成伤害降低Ⅰ",
		"icon_expedition_wufang",
		135
	},
	{
		321001,
		2,
		"己阵单体攻击造成的伤害降低30%，选择后剩余时间增加150秒",
		"造成伤害降低Ⅱ",
		"icon_expedition_chushouqianjianshang",
		150
	},
	{
		321001,
		3,
		"己阵单体攻击造成的伤害降低50%，选择后剩余时间增加165秒",
		"造成伤害降低Ⅲ",
		"icon_expedition_dikang_quan",
		165
	},
	{
		321001,
		4,
		"己阵单体攻击造成的伤害降低10%，选择后剩余时间增加150秒",
		"造成伤害降低Ⅰ",
		"icon_expedition_wufang",
		150
	},
	{
		321001,
		5,
		"己阵单体攻击造成的伤害降低30%，选择后剩余时间增加180秒",
		"造成伤害降低Ⅱ",
		"icon_expedition_chushouqianjianshang",
		180
	},
	{
		321001,
		6,
		"己阵单体攻击造成的伤害降低50%，选择后剩余时间增加210秒",
		"造成伤害降低Ⅲ",
		"icon_expedition_dikang_quan",
		210
	},
	{
		321001,
		7,
		"己阵单体攻击造成的伤害降低10%，选择后剩余时间增加180秒",
		"造成伤害降低Ⅰ",
		"icon_expedition_wufang",
		180
	},
	{
		321001,
		8,
		"己阵单体攻击造成的伤害降低30%，选择后剩余时间增加240秒",
		"造成伤害降低Ⅱ",
		"icon_expedition_chushouqianjianshang",
		240
	},
	{
		321001,
		9,
		"己阵单体攻击造成的伤害降低50%，选择后剩余时间增加300秒",
		"造成伤害降低Ⅲ",
		"icon_expedition_dikang_quan",
		300
	},
	{
		321001,
		10,
		"敌阵群体攻击时伤害增加10%，选择后剩余时间增加135秒",
		"受到伤害降低Ⅰ",
		"icon_expedition_wufang",
		135
	},
	{
		321001,
		11,
		"敌阵群体攻击时伤害增加30%，选择后剩余时间增加150秒",
		"受到伤害降低Ⅱ",
		"icon_expedition_chushouqianjianshang",
		150
	},
	{
		321001,
		12,
		"敌阵群体攻击时伤害增加50%，选择后剩余时间增加165秒",
		"受到伤害降低Ⅲ",
		"icon_expedition_dikang_quan",
		165
	},
	{
		321001,
		13,
		"敌阵群体攻击时伤害增加10%，选择后剩余时间增加150秒",
		"受到伤害降低Ⅰ",
		"icon_expedition_wufang",
		150
	},
	{
		321001,
		14,
		"敌阵群体攻击时伤害增加30%，选择后剩余时间增加180秒",
		"受到伤害降低Ⅱ",
		"icon_expedition_chushouqianjianshang",
		180
	},
	{
		321001,
		15,
		"敌阵群体攻击时伤害增加50%，选择后剩余时间增加210秒",
		"受到伤害降低Ⅲ",
		"icon_expedition_dikang_quan",
		210
	},
	{
		321001,
		16,
		"敌阵群体攻击时伤害增加10%，选择后剩余时间增加180秒",
		"受到伤害降低Ⅰ",
		"icon_expedition_wufang",
		180
	},
	{
		321001,
		17,
		"敌阵群体攻击时伤害增加30%，选择后剩余时间增加240秒",
		"受到伤害降低Ⅱ",
		"icon_expedition_chushouqianjianshang",
		240
	},
	{
		321001,
		18,
		"敌阵群体攻击时伤害增加50%，选择后剩余时间增加300秒",
		"受到伤害降低Ⅲ",
		"icon_expedition_dikang_quan",
		300
	}
}
local t_king_nuo_ya_buff = {
	[321001] = {
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
		dataList[18]
	}
}

t_king_nuo_ya_buff.dataList = dataList

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

return t_king_nuo_ya_buff
