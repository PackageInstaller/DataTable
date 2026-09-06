-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cute_pet_garden_lvl.lua

module("logicconfig.config.t_cute_pet_garden_lvl", package.seeall)

local title = {
	cutePetCapacity = 2,
	lvlUpMaterialCost = 4,
	minPlayerLvl = 3,
	lvl = 1
}
local dataList = {
	{
		1,
		100,
		10,
		""
	},
	{
		2,
		120,
		10,
		"4:11003:480"
	},
	{
		3,
		140,
		10,
		"4:11003:1440"
	},
	{
		4,
		160,
		10,
		"4:11003:2400"
	},
	{
		5,
		180,
		10,
		"4:11003:4000"
	},
	{
		6,
		200,
		10,
		"4:11003:6400"
	},
	{
		7,
		220,
		10,
		"4:11003:9600"
	},
	{
		8,
		240,
		10,
		"4:11003:14400"
	},
	{
		9,
		260,
		10,
		"4:11003:21600"
	},
	{
		10,
		280,
		10,
		"4:11003:32800"
	},
	{
		11,
		320,
		10,
		"4:11003:49600"
	},
	{
		12,
		360,
		10,
		"4:11003:74400"
	},
	{
		13,
		400,
		10,
		"4:11003:112000"
	},
	{
		14,
		450,
		10,
		"4:11003:168000"
	},
	{
		15,
		500,
		10,
		"4:11003:252000"
	},
	{
		16,
		550,
		10,
		"4:11003:378000"
	},
	{
		17,
		600,
		10,
		"4:11003:567000"
	},
	{
		18,
		650,
		10,
		"4:11003:851000"
	},
	{
		19,
		700,
		10,
		"4:11003:1280000"
	},
	{
		20,
		800,
		10,
		"4:11003:2560000"
	}
}
local t_cute_pet_garden_lvl = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15],
	dataList[16],
	dataList[17],
	dataList[18],
	dataList[19],
	dataList[20]
}

t_cute_pet_garden_lvl.dataList = dataList

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

return t_cute_pet_garden_lvl
