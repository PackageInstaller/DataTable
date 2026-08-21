-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_football.lua

module("logic.config.t_football", package.seeall)

local title = {
	scoreRule = 2,
	code = 1
}
local dataList = {
	{
		1,
		{
			3,
			1,
			0
		}
	}
}
local t_football = {}

t_football.dataList = dataList

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
	t_football[v[1]] = v

	setmetatable(v, mt)
end

return t_football
