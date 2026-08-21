-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_sign_in_const.lua

module("logic.config.t_sign_in_const", package.seeall)

local title = {
	floatValue = 3,
	key = 1,
	numValues = 5,
	strValue = 4,
	numValue = 2
}
local dataList = {
	{
		"DailySignInLandladyFormula",
		1,
		0,
		""
	}
}
local t_sign_in_const = {}

t_sign_in_const.dataList = dataList

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
	t_sign_in_const[v[1]] = v

	setmetatable(v, mt)
end

return t_sign_in_const
