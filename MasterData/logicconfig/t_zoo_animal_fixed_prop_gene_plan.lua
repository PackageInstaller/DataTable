-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zoo_animal_fixed_prop_gene_plan.lua

module("logicconfig.config.t_zoo_animal_fixed_prop_gene_plan", package.seeall)

local title = {
	planId = 1,
	geneId = 2
}
local dataList = {
	{
		1,
		11
	},
	{
		1,
		12
	},
	{
		2,
		13
	},
	{
		2,
		14
	}
}
local t_zoo_animal_fixed_prop_gene_plan = {
	{
		[11] = dataList[1],
		[12] = dataList[2]
	},
	{
		[13] = dataList[3],
		[14] = dataList[4]
	}
}

t_zoo_animal_fixed_prop_gene_plan.dataList = dataList

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

return t_zoo_animal_fixed_prop_gene_plan
