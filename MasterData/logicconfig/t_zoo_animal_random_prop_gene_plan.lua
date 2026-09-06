-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zoo_animal_random_prop_gene_plan.lua

module("logicconfig.config.t_zoo_animal_random_prop_gene_plan", package.seeall)

local title = {
	geneId = 3,
	weight = 4,
	planId = 1,
	category = 2
}
local dataList = {
	{
		1,
		1,
		1,
		50
	},
	{
		1,
		1,
		2,
		40
	},
	{
		1,
		1,
		3,
		30
	},
	{
		1,
		2,
		4,
		30
	},
	{
		1,
		2,
		5,
		30
	},
	{
		1,
		2,
		6,
		30
	},
	{
		1,
		2,
		7,
		30
	},
	{
		2,
		1,
		8,
		50
	},
	{
		2,
		1,
		9,
		50
	},
	{
		2,
		1,
		10,
		50
	}
}
local t_zoo_animal_random_prop_gene_plan = {
	{
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			[4] = dataList[4],
			[5] = dataList[5],
			[6] = dataList[6],
			[7] = dataList[7]
		}
	},
	{
		{
			[8] = dataList[8],
			[9] = dataList[9],
			[10] = dataList[10]
		}
	}
}

t_zoo_animal_random_prop_gene_plan.dataList = dataList

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

return t_zoo_animal_random_prop_gene_plan
