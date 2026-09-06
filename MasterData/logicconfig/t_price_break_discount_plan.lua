-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_price_break_discount_plan.lua

module("logicconfig.config.t_price_break_discount_plan", package.seeall)

local title = {
	fullPrice = 2,
	discPlan = 1,
	cutPrice = 3
}
local dataList = {
	{
		1,
		300,
		50
	},
	{
		1,
		600,
		100
	},
	{
		1,
		900,
		150
	},
	{
		1,
		1200,
		200
	},
	{
		1,
		1500,
		250
	},
	{
		1,
		1800,
		300
	},
	{
		1,
		2100,
		350
	},
	{
		1,
		2400,
		400
	},
	{
		1,
		2700,
		450
	},
	{
		1,
		3000,
		500
	},
	{
		1,
		3300,
		550
	},
	{
		1,
		3600,
		600
	},
	{
		1,
		3900,
		650
	},
	{
		1,
		4200,
		700
	},
	{
		1,
		4500,
		750
	},
	{
		1,
		4800,
		800
	},
	{
		1,
		5100,
		850
	},
	{
		1,
		5400,
		900
	},
	{
		1,
		5700,
		950
	},
	{
		1,
		6000,
		1000
	},
	{
		1,
		6300,
		1050
	},
	{
		1,
		6600,
		1100
	},
	{
		1,
		6900,
		1150
	},
	{
		1,
		7200,
		1200
	},
	{
		1,
		7500,
		1250
	},
	{
		1,
		7800,
		1300
	},
	{
		1,
		8100,
		1350
	},
	{
		1,
		8400,
		1400
	},
	{
		1,
		8700,
		1450
	},
	{
		1,
		9000,
		1500
	},
	{
		1,
		9300,
		1550
	},
	{
		1,
		9600,
		1600
	},
	{
		1,
		9900,
		1650
	},
	{
		1,
		10200,
		1700
	},
	{
		1,
		10500,
		1750
	},
	{
		1,
		10800,
		1800
	},
	{
		1,
		11100,
		1850
	},
	{
		1,
		11400,
		1900
	},
	{
		1,
		11700,
		1950
	},
	{
		1,
		12000,
		2000
	},
	{
		1,
		12300,
		2050
	},
	{
		1,
		12600,
		2100
	},
	{
		1,
		12900,
		2150
	},
	{
		1,
		13200,
		2200
	},
	{
		1,
		13500,
		2250
	},
	{
		1,
		13800,
		2300
	},
	{
		1,
		14100,
		2350
	},
	{
		1,
		14400,
		2400
	},
	{
		1,
		14700,
		2450
	},
	{
		1,
		15000,
		2500
	},
	{
		1,
		15300,
		2550
	},
	{
		1,
		15600,
		2600
	},
	{
		1,
		15900,
		2650
	},
	{
		1,
		16200,
		2700
	},
	{
		1,
		16500,
		2750
	},
	{
		1,
		16800,
		2800
	},
	{
		1,
		17100,
		2850
	},
	{
		1,
		17400,
		2900
	},
	{
		1,
		17700,
		2950
	},
	{
		1,
		18000,
		3000
	},
	{
		1,
		18300,
		3050
	},
	{
		1,
		18600,
		3100
	},
	{
		1,
		18900,
		3150
	},
	{
		1,
		19200,
		3200
	},
	{
		1,
		19500,
		3250
	},
	{
		1,
		19800,
		3300
	},
	{
		2,
		0,
		0
	}
}
local t_price_break_discount_plan = {
	{
		[300] = dataList[1],
		[600] = dataList[2],
		[900] = dataList[3],
		[1200] = dataList[4],
		[1500] = dataList[5],
		[1800] = dataList[6],
		[2100] = dataList[7],
		[2400] = dataList[8],
		[2700] = dataList[9],
		[3000] = dataList[10],
		[3300] = dataList[11],
		[3600] = dataList[12],
		[3900] = dataList[13],
		[4200] = dataList[14],
		[4500] = dataList[15],
		[4800] = dataList[16],
		[5100] = dataList[17],
		[5400] = dataList[18],
		[5700] = dataList[19],
		[6000] = dataList[20],
		[6300] = dataList[21],
		[6600] = dataList[22],
		[6900] = dataList[23],
		[7200] = dataList[24],
		[7500] = dataList[25],
		[7800] = dataList[26],
		[8100] = dataList[27],
		[8400] = dataList[28],
		[8700] = dataList[29],
		[9000] = dataList[30],
		[9300] = dataList[31],
		[9600] = dataList[32],
		[9900] = dataList[33],
		[10200] = dataList[34],
		[10500] = dataList[35],
		[10800] = dataList[36],
		[11100] = dataList[37],
		[11400] = dataList[38],
		[11700] = dataList[39],
		[12000] = dataList[40],
		[12300] = dataList[41],
		[12600] = dataList[42],
		[12900] = dataList[43],
		[13200] = dataList[44],
		[13500] = dataList[45],
		[13800] = dataList[46],
		[14100] = dataList[47],
		[14400] = dataList[48],
		[14700] = dataList[49],
		[15000] = dataList[50],
		[15300] = dataList[51],
		[15600] = dataList[52],
		[15900] = dataList[53],
		[16200] = dataList[54],
		[16500] = dataList[55],
		[16800] = dataList[56],
		[17100] = dataList[57],
		[17400] = dataList[58],
		[17700] = dataList[59],
		[18000] = dataList[60],
		[18300] = dataList[61],
		[18600] = dataList[62],
		[18900] = dataList[63],
		[19200] = dataList[64],
		[19500] = dataList[65],
		[19800] = dataList[66]
	},
	{
		[0] = dataList[67]
	}
}

t_price_break_discount_plan.dataList = dataList

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

return t_price_break_discount_plan
