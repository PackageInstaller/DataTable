-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_formation_pets.lua

module("logicconfig.config.t_formation_pets", package.seeall)

local title = {
	id = 1,
	name = 2,
	career = 6,
	raceId = 3,
	modelId = 5,
	lv = 4
}
local dataList = {
	{
		1,
		"末炎",
		10005,
		100,
		5,
		5
	},
	{
		2,
		"白虎",
		10007,
		100,
		7,
		3
	},
	{
		3,
		"末炎",
		10005,
		100,
		5,
		5
	},
	{
		4,
		"白虎",
		10007,
		100,
		7,
		3
	},
	{
		5,
		"末炎",
		10005,
		100,
		5,
		5
	}
}
local t_formation_pets = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5]
}

t_formation_pets.dataList = dataList

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

return t_formation_pets
