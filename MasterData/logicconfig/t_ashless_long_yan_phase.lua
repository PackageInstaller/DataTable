-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ashless_long_yan_phase.lua

module("logicconfig.config.t_ashless_long_yan_phase", package.seeall)

local title = {
	stagePlanId = 4,
	prize = 3,
	phaseId = 2,
	buffPlanId = 6,
	stashCount = 5,
	activityId = 1,
	des = 7
}
local dataList = {
	{
		435001,
		1,
		"4:422:20",
		1,
		2,
		1,
		"1.击败争夺木材的敌阵，根据己阵存活精灵数量，获得<color=#E9B657FF>木材</color>；\r\n2.消耗木材，<color=#E9B657FF>点亮火堆</color>，火堆下方则是点亮需消耗木材数量；\r\n3.同一层面的木堆和火堆操作完后，才可以操作下一层，可以通过火炉暂时存放木堆和火堆<color=#E9B657FF>火炉有容量上限</color>。"
	},
	{
		435001,
		2,
		"4:422:40",
		2,
		1,
		1,
		"1.击败争夺木材的敌阵，根据己阵存活精灵数量，获得<color=#E9B657FF>木材</color>；\r\n2.消耗木材，<color=#E9B657FF>点亮火堆</color>，火堆下方则是点亮需消耗木材数量；\r\n3.同一层面的木堆和火堆操作完后，才可以操作下一层，可以通过火炉暂时存放木堆和火堆<color=#E9B657FF>火炉有容量上限</color>。"
	},
	{
		435001,
		3,
		"4:422:60",
		3,
		0,
		1,
		"1.击败争夺木材的敌阵，根据己阵存活精灵数量，获得<color=#E9B657FF>木材</color>；\r\n2.消耗木材，<color=#E9B657FF>点亮火堆</color>，火堆下方则是点亮需消耗木材数量；\r\n3.同一层面的木堆和火堆操作完后，才可以操作下一层，可以通过火炉暂时存放木堆和火堆<color=#E9B657FF>火炉有容量上限</color>。"
	},
	{
		435002,
		1,
		"4:422:20",
		1,
		2,
		1,
		"1.击败争夺木材的敌阵，根据己阵存活精灵数量，获得<color=#E9B657FF>木材</color>；\r\n2.消耗木材，<color=#E9B657FF>点亮火堆</color>，火堆下方则是点亮需消耗木材数量；\r\n3.同一层面的木堆和火堆操作完后，才可以操作下一层，可以通过火炉暂时存放木堆和火堆<color=#E9B657FF>火炉有容量上限</color>。"
	},
	{
		435002,
		2,
		"4:422:40",
		2,
		1,
		1,
		"1.击败争夺木材的敌阵，根据己阵存活精灵数量，获得<color=#E9B657FF>木材</color>；\r\n2.消耗木材，<color=#E9B657FF>点亮火堆</color>，火堆下方则是点亮需消耗木材数量；\r\n3.同一层面的木堆和火堆操作完后，才可以操作下一层，可以通过火炉暂时存放木堆和火堆<color=#E9B657FF>火炉有容量上限</color>。"
	},
	{
		435002,
		3,
		"4:422:60",
		3,
		0,
		1,
		"1.击败争夺木材的敌阵，根据己阵存活精灵数量，获得<color=#E9B657FF>木材</color>；\r\n2.消耗木材，<color=#E9B657FF>点亮火堆</color>，火堆下方则是点亮需消耗木材数量；\r\n3.同一层面的木堆和火堆操作完后，才可以操作下一层，可以通过火炉暂时存放木堆和火堆<color=#E9B657FF>火炉有容量上限</color>。"
	}
}
local t_ashless_long_yan_phase = {
	[435001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[435002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_ashless_long_yan_phase.dataList = dataList

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

return t_ashless_long_yan_phase
