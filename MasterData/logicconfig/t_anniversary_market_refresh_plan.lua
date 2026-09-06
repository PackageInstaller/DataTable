-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_anniversary_market_refresh_plan.lua

module("logicconfig.config.t_anniversary_market_refresh_plan", package.seeall)

local title = {
	weightPlanId = 3,
	refreshPlanId = 1,
	refreshTimes = 2
}
local dataList = {
	{
		1,
		0,
		1
	},
	{
		1,
		20,
		2
	},
	{
		1,
		40,
		3
	},
	{
		1,
		60,
		4
	},
	{
		2,
		0,
		5
	},
	{
		2,
		20,
		6
	},
	{
		2,
		40,
		7
	},
	{
		2,
		60,
		8
	},
	{
		3,
		0,
		9
	},
	{
		3,
		20,
		10
	},
	{
		3,
		40,
		11
	},
	{
		3,
		60,
		12
	},
	{
		4,
		0,
		13
	},
	{
		4,
		20,
		14
	},
	{
		4,
		40,
		15
	},
	{
		4,
		60,
		16
	},
	{
		5,
		0,
		17
	},
	{
		5,
		20,
		18
	},
	{
		5,
		40,
		19
	},
	{
		5,
		60,
		20
	},
	{
		6,
		0,
		21
	},
	{
		6,
		20,
		22
	},
	{
		6,
		40,
		23
	},
	{
		6,
		60,
		24
	},
	{
		7,
		0,
		25
	},
	{
		7,
		20,
		26
	},
	{
		7,
		40,
		27
	},
	{
		7,
		60,
		28
	},
	{
		8,
		0,
		29
	},
	{
		8,
		20,
		30
	},
	{
		8,
		40,
		31
	},
	{
		8,
		60,
		32
	},
	{
		9,
		0,
		33
	},
	{
		9,
		20,
		34
	},
	{
		9,
		40,
		35
	},
	{
		9,
		60,
		36
	},
	{
		10,
		0,
		37
	},
	{
		10,
		20,
		38
	},
	{
		10,
		40,
		39
	},
	{
		10,
		60,
		40
	},
	{
		11,
		0,
		41
	},
	{
		11,
		20,
		42
	},
	{
		11,
		40,
		43
	},
	{
		11,
		60,
		44
	},
	{
		12,
		0,
		45
	},
	{
		12,
		20,
		46
	},
	{
		12,
		40,
		47
	},
	{
		12,
		60,
		48
	},
	{
		13,
		0,
		49
	},
	{
		13,
		20,
		50
	},
	{
		13,
		40,
		51
	},
	{
		13,
		60,
		52
	},
	{
		14,
		0,
		53
	},
	{
		14,
		20,
		54
	},
	{
		14,
		40,
		55
	},
	{
		14,
		60,
		56
	},
	{
		15,
		0,
		57
	},
	{
		15,
		20,
		58
	},
	{
		15,
		40,
		59
	},
	{
		15,
		60,
		60
	}
}
local t_anniversary_market_refresh_plan = {
	{
		[0] = dataList[1],
		[20] = dataList[2],
		[40] = dataList[3],
		[60] = dataList[4]
	},
	{
		[0] = dataList[5],
		[20] = dataList[6],
		[40] = dataList[7],
		[60] = dataList[8]
	},
	{
		[0] = dataList[9],
		[20] = dataList[10],
		[40] = dataList[11],
		[60] = dataList[12]
	},
	{
		[0] = dataList[13],
		[20] = dataList[14],
		[40] = dataList[15],
		[60] = dataList[16]
	},
	{
		[0] = dataList[17],
		[20] = dataList[18],
		[40] = dataList[19],
		[60] = dataList[20]
	},
	{
		[0] = dataList[21],
		[20] = dataList[22],
		[40] = dataList[23],
		[60] = dataList[24]
	},
	{
		[0] = dataList[25],
		[20] = dataList[26],
		[40] = dataList[27],
		[60] = dataList[28]
	},
	{
		[0] = dataList[29],
		[20] = dataList[30],
		[40] = dataList[31],
		[60] = dataList[32]
	},
	{
		[0] = dataList[33],
		[20] = dataList[34],
		[40] = dataList[35],
		[60] = dataList[36]
	},
	{
		[0] = dataList[37],
		[20] = dataList[38],
		[40] = dataList[39],
		[60] = dataList[40]
	},
	{
		[0] = dataList[41],
		[20] = dataList[42],
		[40] = dataList[43],
		[60] = dataList[44]
	},
	{
		[0] = dataList[45],
		[20] = dataList[46],
		[40] = dataList[47],
		[60] = dataList[48]
	},
	{
		[0] = dataList[49],
		[20] = dataList[50],
		[40] = dataList[51],
		[60] = dataList[52]
	},
	{
		[0] = dataList[53],
		[20] = dataList[54],
		[40] = dataList[55],
		[60] = dataList[56]
	},
	{
		[0] = dataList[57],
		[20] = dataList[58],
		[40] = dataList[59],
		[60] = dataList[60]
	}
}

t_anniversary_market_refresh_plan.dataList = dataList

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

return t_anniversary_market_refresh_plan
