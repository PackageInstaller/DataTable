-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_honor_tower_clearance_buff.lua

module("logicconfig.config.t_honor_tower_clearance_buff", package.seeall)

local title = {
	iconPath = 3,
	name = 2,
	buffPlanId = 1,
	buffDesc = 4
}
local dataList = {
	{
		1,
		"坚壁盾防",
		"icon_expedition_yadao01",
		"己阵男性精灵造成的伤害-20%"
	},
	{
		2,
		"火焰力量",
		"icon_expedition_xueliang2",
		"己阵火系精灵全属性和生命上限提高20%"
	},
	{
		3,
		"气势如虹",
		"icon_expedition_xueliang2",
		"己阵所有精灵初始气势+30"
	},
	{
		4,
		"冰灵秩序",
		"icon_expedition_xueliang2",
		"己阵水系精灵全属性和生命上限提高20%"
	},
	{
		5,
		"生命祝福",
		"icon_expedition_xueliang2",
		"己阵草系精灵闪避率和生命上限提高20%"
	},
	{
		6,
		"神曜双龙",
		"icon_expedition_xueliang2",
		"己阵龙族精灵全属性和生命上限提高20%"
	},
	{
		7,
		"创系祝福",
		"icon_expedition_xueliang2",
		"己阵创系精灵全属性和生命上限提高20%"
	},
	{
		8,
		"群伤提升",
		"icon_expedition_xueliang2",
		"己阵精灵群攻伤害提高20%"
	},
	{
		9,
		"神格提升",
		"icon_expedition_xieli01",
		"荣耀塔内己阵精灵神曜技均为满级"
	}
}
local t_honor_tower_clearance_buff = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9]
}

t_honor_tower_clearance_buff.dataList = dataList

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

return t_honor_tower_clearance_buff
