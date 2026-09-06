-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_ext_formation.lua

module("logicconfig.config.t_pet_ext_formation", package.seeall)

local title = {
	p9 = 10,
	p6 = 7,
	p3 = 4,
	p2 = 3,
	p8 = 9,
	p5 = 6,
	id = 1,
	p4 = 5,
	p1 = 2,
	p7 = 8
}
local dataList = {
	{
		"肉盾",
		102,
		103,
		101,
		88,
		87,
		86,
		0,
		0,
		0
	},
	{
		"平衡",
		99,
		100,
		98,
		91,
		90,
		89,
		0,
		0,
		0
	},
	{
		"疾速",
		96,
		97,
		95,
		94,
		93,
		92,
		0,
		0,
		0
	},
	{
		"治疗",
		93,
		94,
		92,
		97,
		96,
		95,
		0,
		0,
		0
	},
	{
		"利爪",
		90,
		91,
		89,
		100,
		99,
		98,
		0,
		0,
		0
	},
	{
		"魔法",
		87,
		88,
		86,
		103,
		102,
		101,
		0,
		0,
		0
	}
}
local t_pet_ext_formation = {
	肉盾 = dataList[1],
	平衡 = dataList[2],
	疾速 = dataList[3],
	治疗 = dataList[4],
	利爪 = dataList[5],
	魔法 = dataList[6]
}

t_pet_ext_formation.dataList = dataList

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

return t_pet_ext_formation
