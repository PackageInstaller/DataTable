-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tutor_system_growth_task.lua

module("logicconfig.config.t_tutor_system_growth_task", package.seeall)

local title = {
	score = 6,
	publishPrize = 4,
	desc = 8,
	jumpTo = 10,
	iconPath = 9,
	title = 7,
	prize = 3,
	taskId = 1,
	teacherPrize = 5,
	maxProgress = 2
}
local dataList = {
	{
		1,
		50,
		"",
		"",
		"",
		30,
		"冒险幻境",
		"冒险幻境挑战（扫荡）50次",
		"tutorsystem/board_mb_14",
		"ui#rescopyview"
	},
	{
		2,
		250,
		"",
		"",
		"",
		30,
		"主线副本",
		"主线副本挑战（扫荡）250次",
		"tutorsystem/board_mb_10",
		"ui#plotcopyview#0"
	},
	{
		3,
		12,
		"",
		"",
		"",
		30,
		"世界魔王",
		"攻打世界魔王次数达到12次",
		"tutorsystem/board_mb_08",
		"func#93"
	},
	{
		4,
		40,
		"",
		"",
		"",
		30,
		"普通抽卡",
		"在召唤卡池中消耗40张召唤券",
		"tutorsystem/board_mb_07",
		"func#273"
	},
	{
		5,
		20,
		"",
		"",
		"",
		30,
		"破阵天下",
		"挑战破阵天下累计20次",
		"tutorsystem/board_mb_13",
		"func#18"
	},
	{
		6,
		50,
		"",
		"",
		"",
		30,
		"坐骑培养",
		"坐骑系统培养50次",
		"tutorsystem/board_mb_05",
		"func#101"
	},
	{
		7,
		6,
		"",
		"",
		"",
		30,
		"怪物来袭",
		"完成怪物来袭6次",
		"tutorsystem/board_mb_12",
		"func#178"
	},
	{
		8,
		15,
		"",
		"",
		"",
		30,
		"竞技场",
		"竞技场进行15次",
		"tutorsystem/board_mb_11",
		"func#19"
	},
	{
		9,
		15,
		"",
		"",
		"",
		30,
		"高级竞技场",
		"高级竞技场进行15次",
		"tutorsystem/board_mb_09",
		"func#171"
	}
}
local t_tutor_system_growth_task = {
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

t_tutor_system_growth_task.dataList = dataList

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

return t_tutor_system_growth_task
