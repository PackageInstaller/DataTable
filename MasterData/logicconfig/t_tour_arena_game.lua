-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tour_arena_game.lua

module("logicconfig.config.t_tour_arena_game", package.seeall)

local title = {
	picturePath = 5,
	name = 3,
	dailyTimes = 4,
	collectItemId = 6,
	activityId = 1,
	gameId = 2
}
local dataList = {
	{
		309001,
		1,
		"连连看",
		3,
		"tourarena/board_youyuanleitaisai_11",
		0
	},
	{
		309001,
		2,
		"找真身",
		2,
		"tourarena/board_youyuanleitaisai_06",
		0
	},
	{
		309001,
		3,
		"开桩起舞",
		2,
		"tourarena/board_youyuanleitaisai_07",
		0
	},
	{
		309001,
		4,
		"叠叠乐",
		0,
		"tourarena/board_youyuanleitaisai_05",
		0
	},
	{
		309002,
		1,
		"翻牌子",
		2,
		"tourarena/board_youyuanleitaisai_08",
		0
	},
	{
		309002,
		2,
		"打地鼠",
		2,
		"tourarena/board_youyuanleitaisai_04",
		0
	},
	{
		309002,
		3,
		"消消乐",
		3,
		"tourarena/board_youyuanleitaisai_10",
		0
	},
	{
		309002,
		4,
		"华容道",
		0,
		"tourarena/board_youyuanleitaisai_09",
		0
	},
	{
		309003,
		1,
		"2048",
		0,
		"tourarena/board_youyuanleitaisai_12",
		0
	},
	{
		309003,
		2,
		"击鼓奏乐",
		3,
		"tourarena/board_youyuanleitaisai_14",
		0
	},
	{
		309003,
		3,
		"连连看",
		3,
		"tourarena/board_youyuanleitaisai_11",
		0
	},
	{
		309003,
		4,
		"找真身",
		2,
		"tourarena/board_youyuanleitaisai_06",
		0
	},
	{
		309004,
		1,
		"猜炸弹",
		5,
		"tourarena/board_youyuanleitaisai_13",
		309004
	},
	{
		309004,
		2,
		"见缝插针",
		0,
		"tourarena/board_youyuanleitaisai_15",
		309004
	},
	{
		309004,
		3,
		"打地鼠",
		2,
		"tourarena/board_youyuanleitaisai_04",
		309004
	},
	{
		309004,
		4,
		"消消乐",
		3,
		"tourarena/board_youyuanleitaisai_10",
		309004
	},
	{
		309005,
		1,
		"猜炸弹",
		5,
		"tourarena/board_youyuanleitaisai_13",
		0
	},
	{
		309005,
		2,
		"塔罗预知",
		0,
		"tourarena/board_youyuanleitaisai_16",
		0
	},
	{
		309005,
		3,
		"守卫龙宝",
		3,
		"tourarena/board_youyuanleitaisai_19",
		0
	},
	{
		309005,
		4,
		"奇门八阵",
		0,
		"tourarena/board_youyuanleitaisai_17",
		0
	},
	{
		309006,
		1,
		"力量比拼",
		3,
		"tourarena/board_youyuanleitaisai_18",
		0
	},
	{
		309006,
		2,
		"叠叠乐",
		0,
		"tourarena/board_youyuanleitaisai_05",
		0
	},
	{
		309006,
		3,
		"三消",
		3,
		"tourarena/board_youyuanleitaisai_10",
		0
	},
	{
		309006,
		4,
		"2048",
		0,
		"tourarena/board_youyuanleitaisai_12",
		0
	}
}
local t_tour_arena_game = {
	[309001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[309002] = {
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[309003] = {
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[309004] = {
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	},
	[309005] = {
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	},
	[309006] = {
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24]
	}
}

t_tour_arena_game.dataList = dataList

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

return t_tour_arena_game
