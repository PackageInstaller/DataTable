-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_zdl_stifle.lua

module("logicconfig.config.t_pet_zdl_stifle", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"EFFECT_RATIO",
		"9999999999"
	},
	{
		"CASTER_STIFLE_RATE_MAX",
		"1.2"
	},
	{
		"CASTER_STIFLE_RATIO",
		"1.5"
	},
	{
		"TARGET_STIFLE_RATE_MAX",
		"0.6"
	},
	{
		"TARGET_STIFLE_RATIO",
		"3"
	}
}
local t_pet_zdl_stifle = {
	EFFECT_RATIO = dataList[1],
	CASTER_STIFLE_RATE_MAX = dataList[2],
	CASTER_STIFLE_RATIO = dataList[3],
	TARGET_STIFLE_RATE_MAX = dataList[4],
	TARGET_STIFLE_RATIO = dataList[5]
}

t_pet_zdl_stifle.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_pet_zdl_stifle
