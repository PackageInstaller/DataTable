-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_trial_daily_task.lua

module("logicconfig.config.t_dragon_trial_daily_task", package.seeall)

local title = {
	maxProgress = 7,
	name = 4,
	desc = 5,
	type = 6,
	jumpTo = 9,
	prize = 8,
	taskId = 2,
	foldId = 3,
	activityId = 1
}
local dataList = {
	{
		108001,
		4,
		2,
		"世界BOSS",
		"挑战1次世界Boss",
		27,
		1,
		"10:108001:50",
		"func#93"
	},
	{
		108001,
		5,
		3,
		"怪物来袭",
		"挑战2次怪物来袭",
		99,
		2,
		"10:108001:50",
		"func#47"
	},
	{
		108001,
		6,
		4,
		"消耗体力",
		"累积消耗200点体力",
		100,
		200,
		"10:108001:40",
		"func#47"
	},
	{
		108001,
		7,
		4,
		"消耗体力",
		"累积消耗400点体力",
		100,
		400,
		"10:108001:50",
		"func#47"
	},
	{
		108001,
		8,
		4,
		"消耗体力",
		"累积消耗600点体力",
		100,
		600,
		"10:108001:70",
		"func#47"
	},
	{
		108001,
		9,
		5,
		"完成梦之队试炼",
		"完成2次梦之队试炼",
		101,
		2,
		"10:108001:55",
		"func#575"
	},
	{
		108001,
		10,
		5,
		"完成梦之队试炼",
		"完成4次梦之队试炼",
		101,
		4,
		"10:108001:75",
		"func#575"
	},
	{
		108001,
		11,
		6,
		"完成龙神试炼",
		"完成2次龙神试炼",
		101,
		2,
		"10:108001:55",
		"func#575"
	},
	{
		108001,
		12,
		6,
		"完成龙神试炼",
		"完成4次龙神试炼",
		101,
		4,
		"10:108001:75",
		"func#575"
	},
	{
		108002,
		4,
		2,
		"世界BOSS",
		"挑战1次世界Boss",
		27,
		1,
		"10:108002:50",
		"func#93"
	},
	{
		108002,
		5,
		3,
		"怪物来袭",
		"挑战2次怪物来袭",
		99,
		2,
		"10:108002:50",
		"func#47"
	},
	{
		108002,
		6,
		4,
		"消耗体力",
		"累积消耗200点体力",
		100,
		200,
		"10:108002:40",
		"func#47"
	},
	{
		108002,
		7,
		4,
		"消耗体力",
		"累积消耗400点体力",
		100,
		400,
		"10:108002:50",
		"func#47"
	},
	{
		108002,
		8,
		4,
		"消耗体力",
		"累积消耗600点体力",
		100,
		600,
		"10:108002:70",
		"func#47"
	},
	{
		108002,
		9,
		5,
		"完成梦之队试炼",
		"完成2次梦之队试炼",
		101,
		2,
		"10:108002:55",
		"func#575"
	},
	{
		108002,
		10,
		5,
		"完成梦之队试炼",
		"完成4次梦之队试炼",
		101,
		4,
		"10:108002:75",
		"func#575"
	},
	{
		108002,
		11,
		6,
		"完成龙神试炼",
		"完成2次龙神试炼",
		101,
		2,
		"10:108002:55",
		"func#575"
	},
	{
		108002,
		12,
		6,
		"完成龙神试炼",
		"完成4次龙神试炼",
		101,
		4,
		"10:108002:75",
		"func#575"
	}
}
local t_dragon_trial_daily_task = {
	[108001] = {
		[4] = dataList[1],
		[5] = dataList[2],
		[6] = dataList[3],
		[7] = dataList[4],
		[8] = dataList[5],
		[9] = dataList[6],
		[10] = dataList[7],
		[11] = dataList[8],
		[12] = dataList[9]
	},
	[108002] = {
		[4] = dataList[10],
		[5] = dataList[11],
		[6] = dataList[12],
		[7] = dataList[13],
		[8] = dataList[14],
		[9] = dataList[15],
		[10] = dataList[16],
		[11] = dataList[17],
		[12] = dataList[18]
	}
}

t_dragon_trial_daily_task.dataList = dataList

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

return t_dragon_trial_daily_task
