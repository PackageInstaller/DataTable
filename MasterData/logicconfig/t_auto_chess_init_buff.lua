-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_auto_chess_init_buff.lua

module("logicconfig.config.t_auto_chess_init_buff", package.seeall)

local title = {
	param = 3,
	name = 4,
	buffId = 1,
	type = 2,
	buffDesc = 5,
	iconPath = 6
}
local dataList = {
	{
		1,
		"FirstSelectBuff",
		"",
		"装备选择",
		"选装备可以优先选取",
		"expevents/icon_expedition_zhenying_02"
	},
	{
		2,
		"Resurrection",
		"",
		"重生",
		"血量首次降到0，可以回一血",
		"expevents/icon_expedition_zhenying_05"
	},
	{
		3,
		"ExtraWinIncome",
		"2",
		"获胜金币",
		"战斗胜利后，可以获取2金币",
		"expevents/icon_expedition_zhenying_06"
	},
	{
		4,
		"ExtraEquipBuff",
		"",
		"随机装备",
		"血量低于一半时，随机获取一件神装",
		"expevents/icon_expedition_zhenying_03"
	},
	{
		5,
		"Buff",
		"{\"buffs\":\"20050571:1\"}",
		"男性精灵",
		"己阵上阵男性精灵越多，全体男性精灵全属性越高（最多提高20%)",
		"expevents/icon_expedition_wushang"
	},
	{
		6,
		"RefreshDiscounts",
		"",
		"刷新消耗",
		"每个回合第一次刷新不消耗金币",
		"expevents/icon_expedition_zhenying_01"
	},
	{
		7,
		"Buff",
		"{\"buffs\":\"20050501:1\"}",
		"属性精灵",
		"己阵上阵同属性精灵越多，该属性全体精灵全属性越高（最多提高20%)",
		"expevents/icon_expedition_yadao01"
	},
	{
		8,
		"Buff",
		"{\"buffs\":\"20050521:1\"}",
		"女性精灵",
		"己阵上阵女性精灵越多，全体女性精灵全属性越高（最多提高20%)",
		"expevents/icon_expedition_yuzhanyuyong"
	},
	{
		9,
		"Buff",
		"{\"buffs\":\"20050531:1\"}",
		"龙族精灵",
		"己阵上阵龙族精灵越多，全体龙族精灵全属性越高（最多提高20%)",
		"expevents/icon_expedition_chaoshahuixue"
	},
	{
		10,
		"Buff",
		"{\"buffs\":\"20050541:1\"}",
		"梦队精灵",
		"己阵上阵梦之队精灵越多，全体梦之队精灵全属性越高（最多提高20%)",
		"expevents/icon_expedition_mogongtisheng"
	},
	{
		11,
		"Buff",
		"{\"buffs\":\"20050561:1#20050562:1#20050563:1#20050564:1#20050565:1#20050566:1#20050567:1#20050568:1#20050569:1#20050570:99#20050572:99#20050573:99#20050574:99\"}",
		"神曜精灵",
		"己阵神曜精灵神曜技获得满级效果",
		"expevents/icon_expedition_xieli01"
	},
	{
		12,
		"Buff",
		"{\"buffs\":\"20050551:1\"}",
		"全体精灵",
		"己阵全体精灵将全属性提升10%",
		"expevents/icon_expedition_ydnzhufu"
	}
}
local t_auto_chess_init_buff = {
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
	dataList[12]
}

t_auto_chess_init_buff.dataList = dataList

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

return t_auto_chess_init_buff
