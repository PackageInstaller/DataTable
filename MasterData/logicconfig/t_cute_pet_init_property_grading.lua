-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cute_pet_init_property_grading.lua

module("logicconfig.config.t_cute_pet_init_property_grading", package.seeall)

local title = {
	genRange = 3,
	color = 5,
	distId = 2,
	grade = 4,
	propertyType = 1
}
local dataList = {
	{
		"生命",
		1,
		{
			1569,
			2092
		},
		"不起眼",
		"1"
	},
	{
		"生命",
		2,
		{
			2092,
			3138
		},
		"一般般",
		"2"
	},
	{
		"生命",
		3,
		{
			3138,
			4184
		},
		"还不错",
		"3"
	},
	{
		"生命",
		4,
		{
			4184,
			5230
		},
		"了不起",
		"4"
	},
	{
		"生命",
		5,
		{
			5230,
			9999
		},
		"很完美",
		"5"
	},
	{
		"攻击",
		1,
		{
			295,
			393
		},
		"不起眼",
		"1"
	},
	{
		"攻击",
		2,
		{
			393,
			590
		},
		"一般般",
		"2"
	},
	{
		"攻击",
		3,
		{
			590,
			787
		},
		"还不错",
		"3"
	},
	{
		"攻击",
		4,
		{
			787,
			984
		},
		"了不起",
		"4"
	},
	{
		"攻击",
		5,
		{
			984,
			9999
		},
		"很完美",
		"5"
	},
	{
		"物防",
		1,
		{
			96,
			129
		},
		"不起眼",
		"1"
	},
	{
		"物防",
		2,
		{
			129,
			193
		},
		"一般般",
		"2"
	},
	{
		"物防",
		3,
		{
			193,
			258
		},
		"还不错",
		"3"
	},
	{
		"物防",
		4,
		{
			258,
			323
		},
		"了不起",
		"4"
	},
	{
		"物防",
		5,
		{
			323,
			9999
		},
		"很完美",
		"5"
	},
	{
		"魔防",
		1,
		{
			96,
			129
		},
		"不起眼",
		"1"
	},
	{
		"魔防",
		2,
		{
			129,
			193
		},
		"一般般",
		"2"
	},
	{
		"魔防",
		3,
		{
			193,
			258
		},
		"还不错",
		"3"
	},
	{
		"魔防",
		4,
		{
			258,
			323
		},
		"了不起",
		"4"
	},
	{
		"魔防",
		5,
		{
			323,
			9999
		},
		"很完美",
		"5"
	},
	{
		"速度",
		1,
		{
			41,
			55
		},
		"不起眼",
		"1"
	},
	{
		"速度",
		2,
		{
			55,
			83
		},
		"一般般",
		"2"
	},
	{
		"速度",
		3,
		{
			83,
			110
		},
		"还不错",
		"3"
	},
	{
		"速度",
		4,
		{
			110,
			138
		},
		"了不起",
		"4"
	},
	{
		"速度",
		5,
		{
			138,
			9999
		},
		"很完美",
		"5"
	}
}
local t_cute_pet_init_property_grading = {
	生命 = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	攻击 = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	物防 = {
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	},
	魔防 = {
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	},
	速度 = {
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25]
	}
}

t_cute_pet_init_property_grading.dataList = dataList

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

return t_cute_pet_init_property_grading
