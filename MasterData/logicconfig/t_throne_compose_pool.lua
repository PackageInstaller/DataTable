-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_throne_compose_pool.lua

module("logicconfig.config.t_throne_compose_pool", package.seeall)

local title = {
	equipmentId = 2,
	poolId = 1
}
local dataList = {
	{
		2201,
		2001
	},
	{
		2201,
		2002
	},
	{
		2201,
		2003
	},
	{
		2201,
		2004
	},
	{
		2201,
		2005
	},
	{
		2201,
		2006
	},
	{
		2201,
		2007
	},
	{
		2201,
		2008
	},
	{
		2201,
		2009
	},
	{
		2201,
		2010
	},
	{
		2201,
		2011
	},
	{
		2201,
		2012
	},
	{
		2201,
		2013
	},
	{
		2201,
		2014
	},
	{
		2201,
		2015
	},
	{
		2201,
		2016
	},
	{
		2201,
		2017
	},
	{
		2201,
		2018
	},
	{
		2201,
		2019
	},
	{
		2201,
		2020
	},
	{
		2201,
		2021
	},
	{
		2201,
		2022
	},
	{
		2301,
		3001
	},
	{
		2301,
		3002
	},
	{
		2301,
		3003
	},
	{
		2301,
		3004
	},
	{
		2301,
		3005
	},
	{
		2301,
		3006
	},
	{
		2301,
		3007
	},
	{
		2301,
		3008
	},
	{
		2301,
		3009
	},
	{
		2301,
		3010
	},
	{
		2301,
		3011
	},
	{
		2301,
		3012
	},
	{
		2301,
		3013
	},
	{
		2301,
		3014
	},
	{
		2301,
		3015
	},
	{
		2301,
		3016
	},
	{
		2301,
		3017
	},
	{
		2301,
		3018
	},
	{
		2301,
		3019
	},
	{
		2301,
		3020
	},
	{
		2401,
		4001
	},
	{
		2401,
		4002
	},
	{
		2401,
		4003
	},
	{
		2401,
		4004
	},
	{
		2401,
		4005
	},
	{
		2401,
		4006
	},
	{
		2401,
		4007
	},
	{
		2401,
		4008
	},
	{
		2401,
		4009
	},
	{
		2401,
		4010
	},
	{
		2401,
		4011
	},
	{
		2401,
		4012
	},
	{
		2401,
		4013
	},
	{
		2401,
		4014
	},
	{
		2401,
		4015
	},
	{
		2401,
		4016
	},
	{
		2401,
		4017
	},
	{
		2401,
		4018
	},
	{
		2401,
		4019
	},
	{
		2401,
		4020
	}
}
local t_throne_compose_pool = {
	[2201] = {
		[2001] = dataList[1],
		[2002] = dataList[2],
		[2003] = dataList[3],
		[2004] = dataList[4],
		[2005] = dataList[5],
		[2006] = dataList[6],
		[2007] = dataList[7],
		[2008] = dataList[8],
		[2009] = dataList[9],
		[2010] = dataList[10],
		[2011] = dataList[11],
		[2012] = dataList[12],
		[2013] = dataList[13],
		[2014] = dataList[14],
		[2015] = dataList[15],
		[2016] = dataList[16],
		[2017] = dataList[17],
		[2018] = dataList[18],
		[2019] = dataList[19],
		[2020] = dataList[20],
		[2021] = dataList[21],
		[2022] = dataList[22]
	},
	[2301] = {
		[3001] = dataList[23],
		[3002] = dataList[24],
		[3003] = dataList[25],
		[3004] = dataList[26],
		[3005] = dataList[27],
		[3006] = dataList[28],
		[3007] = dataList[29],
		[3008] = dataList[30],
		[3009] = dataList[31],
		[3010] = dataList[32],
		[3011] = dataList[33],
		[3012] = dataList[34],
		[3013] = dataList[35],
		[3014] = dataList[36],
		[3015] = dataList[37],
		[3016] = dataList[38],
		[3017] = dataList[39],
		[3018] = dataList[40],
		[3019] = dataList[41],
		[3020] = dataList[42]
	},
	[2401] = {
		[4001] = dataList[43],
		[4002] = dataList[44],
		[4003] = dataList[45],
		[4004] = dataList[46],
		[4005] = dataList[47],
		[4006] = dataList[48],
		[4007] = dataList[49],
		[4008] = dataList[50],
		[4009] = dataList[51],
		[4010] = dataList[52],
		[4011] = dataList[53],
		[4012] = dataList[54],
		[4013] = dataList[55],
		[4014] = dataList[56],
		[4015] = dataList[57],
		[4016] = dataList[58],
		[4017] = dataList[59],
		[4018] = dataList[60],
		[4019] = dataList[61],
		[4020] = dataList[62]
	}
}

t_throne_compose_pool.dataList = dataList

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

return t_throne_compose_pool
