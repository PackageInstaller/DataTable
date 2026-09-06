-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zoo_main_building.lua

module("logicconfig.config.t_zoo_main_building", package.seeall)

local title = {
	maxHappyValue = 3,
	upgradeCost = 4,
	animalNum = 2,
	level = 1
}
local dataList = {
	{
		1,
		2,
		200,
		""
	},
	{
		2,
		4,
		400,
		"8:1:1"
	},
	{
		3,
		5,
		500,
		"8:1:1"
	}
}
local t_zoo_main_building = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_zoo_main_building.dataList = dataList

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

return t_zoo_main_building
