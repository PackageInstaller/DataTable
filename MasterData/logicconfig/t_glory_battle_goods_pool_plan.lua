-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_glory_battle_goods_pool_plan.lua

module("logicconfig.config.t_glory_battle_goods_pool_plan", package.seeall)

local title = {
	goodsPoolPlan = 1,
	goodsId = 2
}
local dataList = {
	{
		1,
		3
	},
	{
		1,
		4
	},
	{
		1,
		5
	},
	{
		1,
		6
	},
	{
		1,
		7
	},
	{
		1,
		8
	},
	{
		1,
		9
	},
	{
		1,
		10
	},
	{
		1,
		17
	},
	{
		1,
		18
	},
	{
		1,
		19
	},
	{
		1,
		20
	},
	{
		1,
		21
	},
	{
		1,
		22
	},
	{
		1,
		23
	},
	{
		1,
		24
	},
	{
		1,
		25
	},
	{
		1,
		26
	},
	{
		1,
		27
	},
	{
		1,
		28
	},
	{
		2,
		3
	},
	{
		2,
		4
	},
	{
		2,
		5
	},
	{
		2,
		6
	},
	{
		2,
		7
	},
	{
		2,
		11
	},
	{
		2,
		12
	},
	{
		2,
		13
	},
	{
		2,
		29
	},
	{
		2,
		30
	},
	{
		2,
		31
	},
	{
		2,
		32
	},
	{
		2,
		33
	},
	{
		2,
		34
	},
	{
		2,
		35
	},
	{
		2,
		36
	},
	{
		2,
		37
	},
	{
		2,
		38
	},
	{
		2,
		39
	},
	{
		2,
		40
	},
	{
		3,
		3
	},
	{
		3,
		4
	},
	{
		3,
		5
	},
	{
		3,
		6
	},
	{
		3,
		7
	},
	{
		3,
		14
	},
	{
		3,
		15
	},
	{
		3,
		16
	},
	{
		3,
		41
	},
	{
		3,
		42
	},
	{
		3,
		43
	},
	{
		3,
		44
	},
	{
		3,
		45
	},
	{
		3,
		46
	},
	{
		3,
		47
	},
	{
		3,
		48
	},
	{
		3,
		49
	},
	{
		3,
		50
	},
	{
		3,
		51
	},
	{
		3,
		52
	}
}
local t_glory_battle_goods_pool_plan = {
	{
		[3] = dataList[1],
		[4] = dataList[2],
		[5] = dataList[3],
		[6] = dataList[4],
		[7] = dataList[5],
		[8] = dataList[6],
		[9] = dataList[7],
		[10] = dataList[8],
		[17] = dataList[9],
		[18] = dataList[10],
		[19] = dataList[11],
		[20] = dataList[12],
		[21] = dataList[13],
		[22] = dataList[14],
		[23] = dataList[15],
		[24] = dataList[16],
		[25] = dataList[17],
		[26] = dataList[18],
		[27] = dataList[19],
		[28] = dataList[20]
	},
	{
		[3] = dataList[21],
		[4] = dataList[22],
		[5] = dataList[23],
		[6] = dataList[24],
		[7] = dataList[25],
		[11] = dataList[26],
		[12] = dataList[27],
		[13] = dataList[28],
		[29] = dataList[29],
		[30] = dataList[30],
		[31] = dataList[31],
		[32] = dataList[32],
		[33] = dataList[33],
		[34] = dataList[34],
		[35] = dataList[35],
		[36] = dataList[36],
		[37] = dataList[37],
		[38] = dataList[38],
		[39] = dataList[39],
		[40] = dataList[40]
	},
	{
		[3] = dataList[41],
		[4] = dataList[42],
		[5] = dataList[43],
		[6] = dataList[44],
		[7] = dataList[45],
		[14] = dataList[46],
		[15] = dataList[47],
		[16] = dataList[48],
		[41] = dataList[49],
		[42] = dataList[50],
		[43] = dataList[51],
		[44] = dataList[52],
		[45] = dataList[53],
		[46] = dataList[54],
		[47] = dataList[55],
		[48] = dataList[56],
		[49] = dataList[57],
		[50] = dataList[58],
		[51] = dataList[59],
		[52] = dataList[60]
	}
}

t_glory_battle_goods_pool_plan.dataList = dataList

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

return t_glory_battle_goods_pool_plan
