-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_team.lua

module("logic.config.t_team", package.seeall)

local title = {
	cost = 3,
	code = 1,
	name = 2,
	level = 4
}
local dataList = {
	{
		1,
		"队伍1",
		nil,
		0
	},
	{
		2,
		"队伍2",
		nil,
		0
	},
	{
		3,
		"队伍3",
		nil,
		0
	},
	{
		4,
		"队伍4",
		nil,
		0
	},
	{
		5,
		"队伍5",
		nil,
		0
	}
}
local t_team = {}

t_team.dataList = dataList

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
	t_team[v[1]] = v

	setmetatable(v, mt)
end

return t_team
