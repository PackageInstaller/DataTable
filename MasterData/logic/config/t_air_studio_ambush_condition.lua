-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_air_studio_ambush_condition.lua

module("logic.config.t_air_studio_ambush_condition", package.seeall)

local title = {
	id = 1,
	descStr = 4,
	limit = 3,
	type = 2
}
local dataList = {
	{
		1001,
		1,
		{
			1,
			2,
			3,
			4,
			5,
			6,
			7,
			8
		},
		"第%s回合开始时"
	},
	{
		1002,
		2,
		nil,
		"%s死亡时"
	},
	{
		1003,
		3,
		{
			1,
			2,
			3,
			4,
			5
		},
		"攻方单位移动到本格%s格范围内"
	}
}
local t_air_studio_ambush_condition = {}

t_air_studio_ambush_condition.dataList = dataList

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
	t_air_studio_ambush_condition[v[1]] = v

	setmetatable(v, mt)
end

return t_air_studio_ambush_condition
