-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zoo_animal_level.lua

module("logicconfig.config.t_zoo_animal_level", package.seeall)

local title = {
	needExp = 2,
	levelRateFactor = 4,
	canMatchTimes = 3,
	level = 1
}
local dataList = {
	{
		1,
		0,
		0,
		1
	},
	{
		2,
		50,
		0,
		1.1
	},
	{
		3,
		100,
		1,
		1.2
	},
	{
		4,
		200,
		2,
		1.3
	},
	{
		5,
		400,
		3,
		1.4
	}
}
local t_zoo_animal_level = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_zoo_animal_level.dataList = dataList

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

return t_zoo_animal_level
