-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pay_strengthen_red_star_god_price.lua

module("logicconfig.config.t_pay_strengthen_red_star_god_price", package.seeall)

local title = {
	raceId = 1,
	pricePlanId = 2
}
local dataList = {
	{
		14039,
		1
	},
	{
		14040,
		2
	},
	{
		15042,
		2
	},
	{
		14041,
		2
	},
	{
		15043,
		2
	},
	{
		14042,
		1
	},
	{
		16041,
		1
	},
	{
		16042,
		2
	},
	{
		16043,
		3
	},
	{
		16044,
		1
	},
	{
		16045,
		1
	},
	{
		13025,
		1
	},
	{
		13026,
		2
	},
	{
		12039,
		3
	},
	{
		13027,
		3
	},
	{
		14043,
		1
	},
	{
		13028,
		1
	},
	{
		13029,
		2
	},
	{
		12040,
		1
	},
	{
		12042,
		2
	},
	{
		12041,
		1
	},
	{
		12043,
		3
	},
	{
		12044,
		2
	},
	{
		12045,
		1
	},
	{
		11036,
		1
	},
	{
		11037,
		1
	},
	{
		11038,
		3
	},
	{
		11039,
		2
	},
	{
		11040,
		1
	},
	{
		17025,
		1
	},
	{
		17026,
		1
	},
	{
		17027,
		1
	},
	{
		17028,
		2
	},
	{
		13030,
		3
	},
	{
		17029,
		1
	},
	{
		15045,
		1
	},
	{
		15044,
		1
	},
	{
		15046,
		2
	},
	{
		15047,
		3
	},
	{
		15048,
		3
	},
	{
		15049,
		2
	},
	{
		11041,
		1
	},
	{
		11042,
		3
	},
	{
		15050,
		1
	},
	{
		13031,
		3
	},
	{
		12046,
		3
	},
	{
		14044,
		3
	},
	{
		14045,
		1
	},
	{
		14046,
		2
	},
	{
		14047,
		3
	},
	{
		14048,
		2
	},
	{
		14049,
		3
	},
	{
		16046,
		1
	},
	{
		15051,
		3
	},
	{
		16047,
		1
	},
	{
		12047,
		2
	},
	{
		16048,
		1
	}
}
local t_pay_strengthen_red_star_god_price = {
	[14039] = dataList[1],
	[14040] = dataList[2],
	[15042] = dataList[3],
	[14041] = dataList[4],
	[15043] = dataList[5],
	[14042] = dataList[6],
	[16041] = dataList[7],
	[16042] = dataList[8],
	[16043] = dataList[9],
	[16044] = dataList[10],
	[16045] = dataList[11],
	[13025] = dataList[12],
	[13026] = dataList[13],
	[12039] = dataList[14],
	[13027] = dataList[15],
	[14043] = dataList[16],
	[13028] = dataList[17],
	[13029] = dataList[18],
	[12040] = dataList[19],
	[12042] = dataList[20],
	[12041] = dataList[21],
	[12043] = dataList[22],
	[12044] = dataList[23],
	[12045] = dataList[24],
	[11036] = dataList[25],
	[11037] = dataList[26],
	[11038] = dataList[27],
	[11039] = dataList[28],
	[11040] = dataList[29],
	[17025] = dataList[30],
	[17026] = dataList[31],
	[17027] = dataList[32],
	[17028] = dataList[33],
	[13030] = dataList[34],
	[17029] = dataList[35],
	[15045] = dataList[36],
	[15044] = dataList[37],
	[15046] = dataList[38],
	[15047] = dataList[39],
	[15048] = dataList[40],
	[15049] = dataList[41],
	[11041] = dataList[42],
	[11042] = dataList[43],
	[15050] = dataList[44],
	[13031] = dataList[45],
	[12046] = dataList[46],
	[14044] = dataList[47],
	[14045] = dataList[48],
	[14046] = dataList[49],
	[14047] = dataList[50],
	[14048] = dataList[51],
	[14049] = dataList[52],
	[16046] = dataList[53],
	[15051] = dataList[54],
	[16047] = dataList[55],
	[12047] = dataList[56],
	[16048] = dataList[57]
}

t_pay_strengthen_red_star_god_price.dataList = dataList

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

return t_pay_strengthen_red_star_god_price
