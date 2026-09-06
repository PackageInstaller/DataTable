-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zoo_animal_gene_mutation.lua

module("logicconfig.config.t_zoo_animal_gene_mutation", package.seeall)

local title = {
	mutatedWeight = 3,
	originGene = 1,
	mutatedGene = 2
}
local dataList = {
	{
		10101,
		10101,
		100
	},
	{
		10101,
		10102,
		100
	},
	{
		10101,
		10103,
		100
	},
	{
		10201,
		10201,
		100
	},
	{
		10201,
		10202,
		100
	},
	{
		10201,
		10203,
		100
	}
}
local t_zoo_animal_gene_mutation = {
	[10101] = {
		[10101] = dataList[1],
		[10102] = dataList[2],
		[10103] = dataList[3]
	},
	[10201] = {
		[10201] = dataList[4],
		[10202] = dataList[5],
		[10203] = dataList[6]
	}
}

t_zoo_animal_gene_mutation.dataList = dataList

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

return t_zoo_animal_gene_mutation
