-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miracle_hero_pet_race_type.lua

module("logicconfig.config.t_miracle_hero_pet_race_type", package.seeall)

local title = {
	id = 1,
	name = 2,
	enumRaceId = 3
}
local dataList = {
	{
		1,
		"火",
		3
	},
	{
		2,
		"草",
		1
	},
	{
		3,
		"水",
		2
	},
	{
		4,
		"光",
		4
	},
	{
		5,
		"暗",
		5
	},
	{
		6,
		"空",
		6
	},
	{
		7,
		"创",
		7
	}
}
local t_miracle_hero_pet_race_type = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7]
}

t_miracle_hero_pet_race_type.dataList = dataList

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

return t_miracle_hero_pet_race_type
