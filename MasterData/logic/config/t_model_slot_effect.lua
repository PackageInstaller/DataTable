-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/config/t_model_slot_effect.lua

module("logic.config.t_model_slot_effect", package.seeall)

local title = {
	highModelBornEffects = 3,
	code = 1,
	bornEffects = 2
}
local dataList = {
	{
		120026,
		{
			10042
		},
		{
			10062
		}
	}
}
local t_model_slot_effect = {}

t_model_slot_effect.dataList = dataList

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
	t_model_slot_effect[v[1]] = v

	setmetatable(v, mt)
end

return t_model_slot_effect
