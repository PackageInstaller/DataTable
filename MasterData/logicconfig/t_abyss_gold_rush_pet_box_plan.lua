-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_abyss_gold_rush_pet_box_plan.lua

module("logicconfig.config.t_abyss_gold_rush_pet_box_plan", package.seeall)

local title = {
	creepsId = 2,
	petBoxPlan = 1
}
local dataList = {
	{
		1,
		1
	},
	{
		1,
		2
	},
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
		11
	},
	{
		1,
		12
	},
	{
		1,
		13
	},
	{
		1,
		14
	},
	{
		1,
		15
	},
	{
		1,
		16
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
		2,
		27
	},
	{
		2,
		28
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
		2,
		41
	},
	{
		2,
		42
	},
	{
		2,
		43
	},
	{
		2,
		44
	},
	{
		2,
		45
	},
	{
		2,
		46
	},
	{
		2,
		47
	},
	{
		2,
		48
	},
	{
		2,
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
	},
	{
		3,
		53
	},
	{
		3,
		54
	},
	{
		3,
		55
	},
	{
		3,
		56
	},
	{
		3,
		57
	},
	{
		3,
		58
	},
	{
		3,
		59
	},
	{
		3,
		60
	},
	{
		3,
		61
	},
	{
		3,
		62
	},
	{
		3,
		63
	},
	{
		3,
		64
	},
	{
		3,
		65
	},
	{
		3,
		66
	},
	{
		3,
		67
	},
	{
		3,
		68
	},
	{
		3,
		69
	},
	{
		3,
		70
	},
	{
		3,
		71
	},
	{
		3,
		72
	}
}
local t_abyss_gold_rush_pet_box_plan = {
	{
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
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26]
	},
	{
		[27] = dataList[27],
		[28] = dataList[28],
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
		[40] = dataList[40],
		[41] = dataList[41],
		[42] = dataList[42],
		[43] = dataList[43],
		[44] = dataList[44],
		[45] = dataList[45],
		[46] = dataList[46],
		[47] = dataList[47],
		[48] = dataList[48],
		[49] = dataList[49]
	},
	{
		[50] = dataList[50],
		[51] = dataList[51],
		[52] = dataList[52],
		[53] = dataList[53],
		[54] = dataList[54],
		[55] = dataList[55],
		[56] = dataList[56],
		[57] = dataList[57],
		[58] = dataList[58],
		[59] = dataList[59],
		[60] = dataList[60],
		[61] = dataList[61],
		[62] = dataList[62],
		[63] = dataList[63],
		[64] = dataList[64],
		[65] = dataList[65],
		[66] = dataList[66],
		[67] = dataList[67],
		[68] = dataList[68],
		[69] = dataList[69],
		[70] = dataList[70],
		[71] = dataList[71],
		[72] = dataList[72]
	}
}

t_abyss_gold_rush_pet_box_plan.dataList = dataList

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

return t_abyss_gold_rush_pet_box_plan
