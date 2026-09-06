-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_battle_over_circle.lua

module("logicconfig.config.t_battle_over_circle", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"TRIGGER_CIRCLE",
		"10"
	},
	{
		"ADD_DAMAGE_RATE",
		"0.1"
	},
	{
		"DEC_HEAL_RARE",
		"0.1"
	}
}
local t_battle_over_circle = {
	TRIGGER_CIRCLE = dataList[1],
	ADD_DAMAGE_RATE = dataList[2],
	DEC_HEAL_RARE = dataList[3]
}

t_battle_over_circle.dataList = dataList

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

return t_battle_over_circle
