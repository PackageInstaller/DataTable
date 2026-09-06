-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_arena_daily_task.lua

module("logicconfig.config.t_arena_daily_task", package.seeall)

local title = {
	collectProgressNeed = 3,
	id = 1,
	title = 4,
	prize = 2,
	desc = 5
}
local dataList = {
	{
		1,
		"8:3:100",
		1,
		"火统治",
		"上阵2只火属性精灵，获得1场胜利"
	},
	{
		2,
		"8:3:100",
		1,
		"牛刀小试",
		"本日获得1次胜利"
	},
	{
		3,
		"8:3:100",
		1,
		"一击即溃",
		"在5回合内战胜对手，获得1场胜利"
	},
	{
		4,
		"8:3:100",
		2,
		"胜利之将",
		"本日获得2场胜利"
	},
	{
		5,
		"8:3:100",
		1,
		"完好无损",
		"己阵所有精灵存活，获得1场胜利"
	},
	{
		6,
		"8:3:100",
		3,
		"常胜将军",
		"本日获得3场胜利"
	},
	{
		7,
		"8:3:100",
		1,
		"速战速决",
		"在5回合内战胜对手，获得1场胜利"
	}
}
local t_arena_daily_task = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_arena_daily_task.dataList = dataList

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

return t_arena_daily_task
