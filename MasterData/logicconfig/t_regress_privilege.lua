-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_regress_privilege.lua

module("logicconfig.config.t_regress_privilege", package.seeall)

local title = {
	param = 3,
	jumpTo = 4,
	itemName = 5,
	type = 2,
	itemDesc = 7,
	icon = 6,
	planId = 1,
	countDesc = 8
}
local dataList = {
	{
		1,
		1,
		10,
		"func#43#3",
		"十连召唤",
		"icon_quan",
		"今日可免费\r\n十连召唤1次",
		"<color=#95ff8a>+1</color>"
	},
	{
		1,
		2,
		1,
		"func#47",
		"掉落翻倍",
		"icon_jingyanguoshi_da",
		"冒险剧情副本战斗胜利掉落材料＋100%",
		"<color=#95ff8a>+100%</color>"
	},
	{
		1,
		3,
		99,
		"func#57",
		"体力加倍",
		"icon_tililibao_1yuan",
		"今日购买体力\r\n＋100%",
		"<color=#95ff8a>+100%</color>"
	},
	{
		2,
		1,
		10,
		"func#43#3",
		"十连召唤",
		"icon_quan",
		"今日可免费\r\n十连召唤1次",
		"<color=#95ff8a>+1</color>"
	},
	{
		2,
		2,
		1,
		"func#47",
		"掉落翻倍",
		"icon_jingyanguoshi_da",
		"冒险剧情副本战斗胜利掉落材料＋100%",
		"<color=#95ff8a>+100%</color>"
	},
	{
		2,
		3,
		99,
		"func#57",
		"体力加倍",
		"icon_tililibao_1yuan",
		"今日购买体力\r\n＋100%",
		"<color=#95ff8a>+100%</color>"
	},
	{
		3,
		1,
		10,
		"func#43#3",
		"十连召唤",
		"icon_quan",
		"今日可免费\r\n十连召唤1次",
		"<color=#95ff8a>+1</color>"
	},
	{
		3,
		2,
		1,
		"func#47",
		"掉落翻倍",
		"icon_jingyanguoshi_da",
		"冒险剧情副本战斗胜利掉落材料＋100%",
		"<color=#95ff8a>+100%</color>"
	},
	{
		3,
		3,
		99,
		"func#57",
		"体力加倍",
		"icon_tililibao_1yuan",
		"今日购买体力\r\n＋100%",
		"<color=#95ff8a>+100%</color>"
	},
	{
		4,
		1,
		10,
		"func#43#3",
		"十连召唤",
		"icon_quan",
		"今日可免费\r\n十连召唤1次",
		"<color=#95ff8a>+1</color>"
	},
	{
		4,
		2,
		1,
		"func#47",
		"掉落翻倍",
		"icon_jingyanguoshi_da",
		"冒险剧情副本战斗胜利掉落材料＋100%",
		"<color=#95ff8a>+100%</color>"
	},
	{
		4,
		3,
		99,
		"func#57",
		"体力加倍",
		"icon_tililibao_1yuan",
		"今日购买体力\r\n＋100%",
		"<color=#95ff8a>+100%</color>"
	},
	{
		4,
		4,
		7,
		"mibao#GoldenDiamondCard",
		"金钻卡",
		"icon_jinzuantequan",
		"免费体验7天",
		"<color=#95ff8a>7天</color>"
	},
	{
		4,
		5,
		0,
		"mibao#monthcardback",
		"回归月卡",
		"icon_tqyueka",
		"6折购\r\n超10倍返利",
		"<color=#95ff8a>30天</color>"
	},
	{
		4,
		6,
		0,
		"func#427#15",
		"时间之门",
		"icon_shikongzhilun",
		"时间之门\r\n每周挑战次数+1",
		"<color=#95ff8a>4周</color>"
	},
	{
		4,
		7,
		1,
		"func#1286",
		"泰坦回溯次数",
		"icon_yuanqi_10",
		"泰坦试炼\r\n回溯次数+1",
		"<color=#95ff8a>+1</color>"
	},
	{
		5,
		1,
		10,
		"func#43#3",
		"十连召唤",
		"icon_quan",
		"今日可免费\r\n十连召唤1次",
		"<color=#95ff8a>+1</color>"
	},
	{
		5,
		2,
		1,
		"func#47",
		"掉落翻倍",
		"icon_jingyanguoshi_da",
		"冒险剧情副本战斗胜利掉落材料＋100%",
		"<color=#95ff8a>+100%</color>"
	},
	{
		5,
		3,
		99,
		"func#57",
		"体力加倍",
		"icon_tililibao_1yuan",
		"今日购买体力\r\n＋100%",
		"<color=#95ff8a>+100%</color>"
	},
	{
		5,
		4,
		7,
		"mibao#GoldenDiamondCard",
		"金钻卡",
		"icon_jinzuantequan",
		"免费体验7天",
		"<color=#95ff8a>7天</color>"
	},
	{
		5,
		5,
		0,
		"mibao#monthcardback2024",
		"回归月卡",
		"icon_tqyueka",
		"6折购\r\n超10倍返利",
		"<color=#95ff8a>30天</color>"
	}
}
local t_regress_privilege = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	},
	{
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21]
	}
}

t_regress_privilege.dataList = dataList

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

return t_regress_privilege
