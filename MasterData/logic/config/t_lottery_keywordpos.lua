-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_lottery_keywordpos.lua

module("logic.config.t_lottery_keywordpos", package.seeall)

local title = {
	posInfo = 2,
	code = 1
}
local dataList = {
	{
		1,
		{
			1,
			8,
			3,
			7,
			2,
			9,
			4,
			6,
			5
		}
	}
}
local t_lottery_keywordpos = {}

t_lottery_keywordpos.dataList = dataList

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
	t_lottery_keywordpos[v[1]] = v

	setmetatable(v, mt)
end

return t_lottery_keywordpos
