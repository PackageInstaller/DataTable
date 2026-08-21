-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_air_studio_win_condition.lua

module("logic.config.t_air_studio_win_condition", package.seeall)

local title = {
	battleDescribe = 5,
	describe = 2,
	type = 3,
	id = 1,
	condition = 4
}
local dataList = {
	{
		1,
		"任意单位抵达指定坐标（x,y）",
		2,
		nil,
		"任意单位抵达撤离点"
	},
	{
		2,
		"击杀[指定角色]",
		1,
		nil,
		"击杀[%s]"
	}
}
local t_air_studio_win_condition = {}

t_air_studio_win_condition.dataList = dataList

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
	t_air_studio_win_condition[v[1]] = v

	setmetatable(v, mt)
end

return t_air_studio_win_condition
