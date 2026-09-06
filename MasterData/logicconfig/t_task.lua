-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_task.lua

module("logicconfig.config.t_task", package.seeall)

local title = {
	grade = 6,
	branch = 4,
	nextTask = 5,
	name = 2,
	commitNpcId = 10,
	trigger = 11,
	target = 8,
	desc = 3,
	receiveNpcId = 9,
	triggerPerformed = 12,
	compeletePerformed = 14,
	acceptPerformed = 13,
	id = 1,
	level = 7
}
local dataList = {
	{
		100,
		"挑战玄武",
		"挑战玄武",
		1,
		101,
		0,
		0,
		{
			"battle_npc",
			"10002"
		},
		10002,
		10002,
		""
	},
	{
		101,
		"挑战玄武",
		"探查",
		1,
		0,
		0,
		0,
		{
			"search",
			"10002",
			"100",
			"13",
			"-2"
		},
		10002,
		10002,
		""
	},
	{
		102,
		"挑战玄武",
		"收集",
		1,
		0,
		0,
		0,
		{
			"collect",
			"10002",
			"100",
			"10002",
			"100",
			"13",
			"-2"
		},
		10002,
		10002,
		""
	}
}
local t_task = {
	[100] = dataList[1],
	[101] = dataList[2],
	[102] = dataList[3]
}

t_task.dataList = dataList

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

return t_task
