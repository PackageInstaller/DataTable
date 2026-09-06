-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zoo_animal_gene_plan.lua

module("logicconfig.config.t_zoo_animal_gene_plan", package.seeall)

local title = {
	geneId = 3,
	part = 2,
	planId = 1
}
local dataList = {
	{
		1,
		1,
		10101
	},
	{
		1,
		1,
		10102
	},
	{
		1,
		1,
		10103
	},
	{
		1,
		1,
		10104
	},
	{
		1,
		1,
		10105
	},
	{
		1,
		2,
		10201
	},
	{
		1,
		2,
		10202
	},
	{
		1,
		2,
		10203
	},
	{
		1,
		2,
		10204
	},
	{
		1,
		2,
		10205
	},
	{
		1,
		3,
		10301
	},
	{
		1,
		3,
		10302
	},
	{
		1,
		3,
		10303
	},
	{
		1,
		3,
		10304
	},
	{
		1,
		3,
		10305
	},
	{
		1,
		4,
		10401
	},
	{
		1,
		4,
		10402
	},
	{
		1,
		4,
		10403
	},
	{
		1,
		4,
		10404
	},
	{
		1,
		4,
		10405
	},
	{
		1,
		5,
		10501
	},
	{
		1,
		5,
		10502
	},
	{
		1,
		5,
		10503
	},
	{
		1,
		5,
		10504
	},
	{
		1,
		5,
		10505
	},
	{
		1,
		6,
		10601
	},
	{
		1,
		6,
		10602
	},
	{
		1,
		6,
		10603
	},
	{
		1,
		6,
		10604
	},
	{
		1,
		6,
		10605
	},
	{
		1,
		7,
		10701
	},
	{
		1,
		7,
		10702
	},
	{
		1,
		7,
		10703
	},
	{
		1,
		7,
		10704
	},
	{
		1,
		7,
		10705
	},
	{
		1,
		8,
		10801
	},
	{
		1,
		8,
		10802
	},
	{
		1,
		8,
		10803
	},
	{
		1,
		8,
		10804
	},
	{
		1,
		8,
		10805
	}
}
local t_zoo_animal_gene_plan = {
	{
		{
			[10101] = dataList[1],
			[10102] = dataList[2],
			[10103] = dataList[3],
			[10104] = dataList[4],
			[10105] = dataList[5]
		},
		{
			[10201] = dataList[6],
			[10202] = dataList[7],
			[10203] = dataList[8],
			[10204] = dataList[9],
			[10205] = dataList[10]
		},
		{
			[10301] = dataList[11],
			[10302] = dataList[12],
			[10303] = dataList[13],
			[10304] = dataList[14],
			[10305] = dataList[15]
		},
		{
			[10401] = dataList[16],
			[10402] = dataList[17],
			[10403] = dataList[18],
			[10404] = dataList[19],
			[10405] = dataList[20]
		},
		{
			[10501] = dataList[21],
			[10502] = dataList[22],
			[10503] = dataList[23],
			[10504] = dataList[24],
			[10505] = dataList[25]
		},
		{
			[10601] = dataList[26],
			[10602] = dataList[27],
			[10603] = dataList[28],
			[10604] = dataList[29],
			[10605] = dataList[30]
		},
		{
			[10701] = dataList[31],
			[10702] = dataList[32],
			[10703] = dataList[33],
			[10704] = dataList[34],
			[10705] = dataList[35]
		},
		{
			[10801] = dataList[36],
			[10802] = dataList[37],
			[10803] = dataList[38],
			[10804] = dataList[39],
			[10805] = dataList[40]
		}
	}
}

t_zoo_animal_gene_plan.dataList = dataList

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

return t_zoo_animal_gene_plan
