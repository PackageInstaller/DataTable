-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lotus_battle_field_match.lua

module("logicconfig.config.t_lotus_battle_field_match", package.seeall)

local title = {
	id = 2,
	matchPlanId = 1,
	startLevel = 3,
	endLevel = 4
}
local dataList = {
	{
		1,
		1,
		0,
		40
	},
	{
		1,
		2,
		41,
		80
	},
	{
		1,
		3,
		81,
		100
	}
}
local t_lotus_battle_field_match = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_lotus_battle_field_match.dataList = dataList

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

return t_lotus_battle_field_match
