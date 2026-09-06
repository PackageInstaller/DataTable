-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zoo_animal_work_gene_plan.lua

module("logicconfig.config.t_zoo_animal_work_gene_plan", package.seeall)

local title = {
	planId = 1,
	geneId = 2
}
local dataList = {
	{
		1,
		1001
	},
	{
		1,
		1002
	},
	{
		1,
		1003
	},
	{
		1,
		1004
	},
	{
		2,
		1005
	},
	{
		3,
		1006
	},
	{
		4,
		1007
	},
	{
		5,
		1008
	},
	{
		6,
		1009
	},
	{
		7,
		1010
	},
	{
		8,
		1011
	},
	{
		9,
		1012
	},
	{
		10,
		1013
	},
	{
		11,
		1014
	}
}
local t_zoo_animal_work_gene_plan = {
	{
		[1001] = dataList[1],
		[1002] = dataList[2],
		[1003] = dataList[3],
		[1004] = dataList[4]
	},
	{
		[1005] = dataList[5]
	},
	{
		[1006] = dataList[6]
	},
	{
		[1007] = dataList[7]
	},
	{
		[1008] = dataList[8]
	},
	{
		[1009] = dataList[9]
	},
	{
		[1010] = dataList[10]
	},
	{
		[1011] = dataList[11]
	},
	{
		[1012] = dataList[12]
	},
	{
		[1013] = dataList[13]
	},
	{
		[1014] = dataList[14]
	}
}

t_zoo_animal_work_gene_plan.dataList = dataList

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

return t_zoo_animal_work_gene_plan
