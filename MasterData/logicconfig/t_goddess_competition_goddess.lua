-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_competition_goddess.lua

module("logicconfig.config.t_goddess_competition_goddess", package.seeall)

local title = {
	sortId = 3,
	activityId = 1,
	goddessFaceId = 2
}
local dataList = {
	{
		453001,
		1401602,
		1
	},
	{
		453001,
		1101103,
		2
	},
	{
		453001,
		1700201,
		3
	},
	{
		453001,
		1402301,
		4
	},
	{
		453001,
		1202103,
		5
	},
	{
		453001,
		1402401,
		6
	},
	{
		453001,
		1402702,
		7
	},
	{
		453001,
		1801101,
		8
	},
	{
		453001,
		1500602,
		9
	},
	{
		453001,
		1202701,
		10
	},
	{
		453001,
		1302202,
		11
	},
	{
		453001,
		1602202,
		12
	},
	{
		453001,
		1502001,
		13
	},
	{
		453001,
		1701402,
		14
	},
	{
		453001,
		1201602,
		15
	},
	{
		453001,
		13015,
		16
	},
	{
		453001,
		12009,
		17
	},
	{
		453001,
		14026,
		18
	},
	{
		453001,
		14020,
		19
	},
	{
		453001,
		12024,
		20
	},
	{
		453001,
		16025,
		21
	},
	{
		453001,
		13014,
		22
	},
	{
		453001,
		17019,
		23
	},
	{
		453001,
		15026,
		24
	},
	{
		453001,
		11019,
		25
	},
	{
		453001,
		16032,
		26
	},
	{
		453001,
		12029,
		27
	},
	{
		453001,
		16031,
		28
	},
	{
		453001,
		12023,
		29
	},
	{
		453001,
		1102002,
		30
	},
	{
		453002,
		1103704,
		1
	},
	{
		453002,
		1102003,
		2
	},
	{
		453002,
		1202105,
		3
	},
	{
		453002,
		1204402,
		4
	},
	{
		453002,
		1204503,
		5
	},
	{
		453002,
		1302803,
		6
	},
	{
		453002,
		1604503,
		7
	},
	{
		453002,
		1401602,
		8
	},
	{
		453002,
		1403803,
		9
	},
	{
		453002,
		1801101,
		10
	},
	{
		453002,
		1503201,
		11
	},
	{
		453002,
		1502703,
		12
	},
	{
		453002,
		1701503,
		13
	},
	{
		453002,
		1403702,
		14
	},
	{
		453002,
		1202702,
		15
	},
	{
		453002,
		1702401,
		16
	},
	{
		453002,
		1603404,
		17
	},
	{
		453002,
		1603901,
		18
	},
	{
		453002,
		1203701,
		19
	},
	{
		453002,
		1102801,
		20
	},
	{
		453002,
		1802103,
		21
	}
}
local t_goddess_competition_goddess = {
	[453001] = {
		[1401602] = dataList[1],
		[1101103] = dataList[2],
		[1700201] = dataList[3],
		[1402301] = dataList[4],
		[1202103] = dataList[5],
		[1402401] = dataList[6],
		[1402702] = dataList[7],
		[1801101] = dataList[8],
		[1500602] = dataList[9],
		[1202701] = dataList[10],
		[1302202] = dataList[11],
		[1602202] = dataList[12],
		[1502001] = dataList[13],
		[1701402] = dataList[14],
		[1201602] = dataList[15],
		[13015] = dataList[16],
		[12009] = dataList[17],
		[14026] = dataList[18],
		[14020] = dataList[19],
		[12024] = dataList[20],
		[16025] = dataList[21],
		[13014] = dataList[22],
		[17019] = dataList[23],
		[15026] = dataList[24],
		[11019] = dataList[25],
		[16032] = dataList[26],
		[12029] = dataList[27],
		[16031] = dataList[28],
		[12023] = dataList[29],
		[1102002] = dataList[30]
	},
	[453002] = {
		[1103704] = dataList[31],
		[1102003] = dataList[32],
		[1202105] = dataList[33],
		[1204402] = dataList[34],
		[1204503] = dataList[35],
		[1302803] = dataList[36],
		[1604503] = dataList[37],
		[1401602] = dataList[38],
		[1403803] = dataList[39],
		[1801101] = dataList[40],
		[1503201] = dataList[41],
		[1502703] = dataList[42],
		[1701503] = dataList[43],
		[1403702] = dataList[44],
		[1202702] = dataList[45],
		[1702401] = dataList[46],
		[1603404] = dataList[47],
		[1603901] = dataList[48],
		[1203701] = dataList[49],
		[1102801] = dataList[50],
		[1802103] = dataList[51]
	}
}

t_goddess_competition_goddess.dataList = dataList

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

return t_goddess_competition_goddess
