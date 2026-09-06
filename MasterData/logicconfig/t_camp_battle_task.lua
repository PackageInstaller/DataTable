-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_camp_battle_task.lua

module("logicconfig.config.t_camp_battle_task", package.seeall)

local title = {
	score = 10,
	viewId = 7,
	prize = 9,
	jumpTo = 6,
	taskType = 3,
	taskTitle = 4,
	taskId = 2,
	taskDesc = 5,
	maxProgress = 8,
	activityId = 1
}
local dataList = {
	{
		187001,
		1,
		147,
		"精灵升级",
		"精灵升级1次",
		"func#9",
		0,
		1,
		"10:187002:100",
		100
	},
	{
		187001,
		2,
		39,
		"装备强化",
		"装备强化1次",
		"func#50",
		0,
		1,
		"10:187002:100",
		100
	},
	{
		187001,
		3,
		129,
		"灵纹升级",
		"灵纹强化1次",
		"func#9#5",
		0,
		1,
		"10:187002:100",
		100
	},
	{
		187001,
		4,
		18,
		"冒险幻境",
		"冒险幻境通关20次",
		"ui#rescopyview",
		0,
		20,
		"10:187002:100",
		100
	},
	{
		187001,
		5,
		133,
		"查看【活动剧情】",
		"查看【活动剧情】1次",
		"func#570#3",
		1,
		1,
		"10:187002:100",
		100
	},
	{
		187001,
		6,
		133,
		"查看【排行榜】",
		"查看【排行榜】1次",
		"ui#funcamprankview",
		2,
		1,
		"10:187002:100",
		100
	},
	{
		187001,
		7,
		16,
		"普通卡池",
		"普通卡池抽奖1次",
		"func#273",
		0,
		1,
		"10:187002:200",
		200
	},
	{
		187001,
		8,
		16,
		"高级卡池",
		"高级卡池抽奖1次（消耗神唤券）",
		"func#43",
		0,
		1,
		"10:187002:200",
		200
	},
	{
		187002,
		1,
		147,
		"精灵升级",
		"精灵升级1次",
		"func#9",
		0,
		1,
		"10:187002:100",
		100
	},
	{
		187002,
		2,
		39,
		"装备强化",
		"装备强化1次",
		"func#50",
		0,
		1,
		"10:187002:100",
		100
	},
	{
		187002,
		3,
		129,
		"灵纹升级",
		"灵纹强化1次",
		"func#9#5",
		0,
		1,
		"10:187002:100",
		100
	},
	{
		187002,
		4,
		18,
		"冒险幻境",
		"冒险幻境通关20次",
		"ui#rescopyview",
		0,
		20,
		"10:187002:100",
		100
	},
	{
		187002,
		5,
		133,
		"查看【活动剧情】",
		"查看【活动剧情】1次",
		"func#570#3",
		1,
		1,
		"10:187002:100",
		100
	},
	{
		187002,
		6,
		133,
		"查看【排行榜】",
		"查看【排行榜】1次",
		"ui#funcamprankview",
		2,
		1,
		"10:187002:100",
		100
	},
	{
		187002,
		7,
		16,
		"普通卡池",
		"普通卡池抽奖1次",
		"func#273",
		0,
		1,
		"10:187002:200",
		200
	},
	{
		187002,
		8,
		16,
		"高级卡池",
		"高级卡池抽奖1次（消耗神唤券）",
		"func#43",
		0,
		1,
		"10:187002:200",
		200
	}
}
local t_camp_battle_task = {
	[187001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[187002] = {
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_camp_battle_task.dataList = dataList

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

return t_camp_battle_task
