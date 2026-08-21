-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_home_repeat_task.lua

module("logic.config.t_home_repeat_task", package.seeall)

local title = {
	param = 4,
	isOnline = 5,
	text = 2,
	jump = 6,
	id = 1,
	content = 3
}
local dataList = {
	{
		140090001,
		"调查一次【红雾地区】",
		104,
		"1#7",
		1,
		12000001
	},
	{
		140090002,
		"探索一次【梦境档案】",
		305,
		"100#1",
		1,
		30001003
	},
	{
		140090003,
		"调查一次【管制行动】",
		107,
		"1#[13,14,15]",
		1,
		10700004
	},
	{
		140090004,
		"调查一次【安定区域】",
		107,
		"1#[4,8,9]",
		1,
		10400001
	}
}
local t_home_repeat_task = {}

t_home_repeat_task.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		else
			error(string.format("the field name [%s] is nonexist!", key))
		end
	end
}

for i, v in ipairs(dataList) do
	t_home_repeat_task[v[1]] = v

	setmetatable(v, mt)
end

return t_home_repeat_task
