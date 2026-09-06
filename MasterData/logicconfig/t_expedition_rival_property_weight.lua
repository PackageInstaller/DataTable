-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_expedition_rival_property_weight.lua

module("logicconfig.config.t_expedition_rival_property_weight", package.seeall)

local title = {
	weight = 2,
	raceGrade = 1
}
local dataList = {
	{
		0,
		1100
	},
	{
		1,
		1050
	},
	{
		2,
		1000
	},
	{
		3,
		950
	},
	{
		4,
		900
	},
	{
		5,
		850
	}
}
local t_expedition_rival_property_weight = {
	[0] = dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6]
}

t_expedition_rival_property_weight.dataList = dataList

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

return t_expedition_rival_property_weight
