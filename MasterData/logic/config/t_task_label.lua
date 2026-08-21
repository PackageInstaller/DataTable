-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_task_label.lua

module("logic.config.t_task_label", package.seeall)

local title = {
	taskLimit = 3,
	id = 1,
	pointIds = 5,
	type = 2,
	pointLimit = 4,
	endTime = 7,
	startTime = 6
}
local dataList = {
	{
		100002,
		2,
		12,
		150,
		{
			10101,
			10102,
			10103,
			10104,
			10105,
			10106
		}
	},
	{
		100003,
		3,
		16,
		200,
		{
			10201,
			10202,
			10203,
			10204,
			10205,
			10206,
			10207,
			10208
		}
	},
	{
		100004,
		4,
		83,
		0
	},
	{
		100005,
		5,
		10,
		0,
		nil,
		"2021-03-24T18:35:00",
		"2021-05-24T19:00:00"
	}
}
local t_task_label = {}

t_task_label.dataList = dataList

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
	t_task_label[v[1]] = v

	setmetatable(v, mt)
end

return t_task_label
