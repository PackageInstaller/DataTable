-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_trial_rank.lua

module("logicconfig.config.t_dragon_trial_rank", package.seeall)

local title = {
	leaf = 2,
	name = 3,
	isDragonTrial = 4,
	idx = 1,
	desc = 5
}
local dataList = {
	{
		1,
		0,
		"龙神试炼",
		true,
		""
	},
	{
		1,
		1,
		"赤焰龙皇试炼",
		true,
		"1，根据<color=#ebad32>单次</color>战斗中对赤焰龙皇造成的伤害进行排行！\n2，排行榜只会展示前100名的奥奇。"
	},
	{
		1,
		2,
		"真龙试炼",
		true,
		"1，根据<color=#ebad32>单次</color>战斗中对真龙造成的伤害进行排行！\n2，排行榜只会展示前100名的奥奇。"
	},
	{
		1,
		3,
		"青龙试炼",
		true,
		"1，根据<color=#ebad32>单次</color>战斗中对青龙造成的伤害进行排行！\n2，排行榜只会展示前100名的奥奇。"
	},
	{
		1,
		4,
		"圣光飞龙试炼",
		true,
		"1，根据<color=#ebad32>单次</color>战斗中对圣光飞龙造成的伤害进行排行！\n2，排行榜只会展示前100名的奥奇。"
	},
	{
		1,
		5,
		"星蓝龙试炼",
		true,
		"1，根据<color=#ebad32>单次</color>战斗中对星蓝龙造成的伤害进行排行！\n2，排行榜只会展示前100名的奥奇。"
	},
	{
		2,
		0,
		"梦之队试炼",
		false,
		""
	},
	{
		2,
		1,
		"赤焰龙皇试炼",
		false,
		"1，根据<color=#ebad32>单次</color>战斗中对赤焰龙皇造成的伤害进行排行！\n2，排行榜只会展示前100名的奥奇。"
	},
	{
		2,
		2,
		"真龙试炼",
		false,
		"1，根据<color=#ebad32>单次</color>战斗中对真龙造成的伤害进行排行！\n2，排行榜只会展示前100名的奥奇。"
	},
	{
		2,
		3,
		"青龙试炼",
		false,
		"1，根据<color=#ebad32>单次</color>战斗中对青龙造成的伤害进行排行！\n2，排行榜只会展示前100名的奥奇。"
	},
	{
		2,
		4,
		"圣光飞龙试炼",
		false,
		"1，根据<color=#ebad32>单次</color>战斗中对圣光飞龙造成的伤害进行排行！\n2，排行榜只会展示前100名的奥奇。"
	},
	{
		2,
		5,
		"星蓝龙试炼",
		false,
		"1，根据<color=#ebad32>单次</color>战斗中对星蓝龙造成的伤害进行排行！\n2，排行榜只会展示前100名的奥奇。"
	}
}
local t_dragon_trial_rank = {
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
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_dragon_trial_rank.dataList = dataList

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

return t_dragon_trial_rank
