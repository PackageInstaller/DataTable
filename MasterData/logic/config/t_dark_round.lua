-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_dark_round.lua

module("logic.config.t_dark_round", package.seeall)

local title = {
	endTime = 3,
	ids = 4,
	round = 1,
	startTime = 2
}
local dataList = {
	{
		1,
		"2023-05-19T05:00:00",
		"2023-05-26T05:00:00",
		{
			10101,
			10102,
			10103,
			10104,
			10105,
			10106,
			10107
		}
	},
	{
		2,
		"2023-05-26T05:00:00",
		"2023-06-09T18:00:00",
		{
			10201,
			10202,
			10203,
			10204,
			10205,
			10206,
			10207
		}
	}
}
local t_dark_round = {}

t_dark_round.dataList = dataList

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
	t_dark_round[v[1]] = v

	setmetatable(v, mt)
end

return t_dark_round
