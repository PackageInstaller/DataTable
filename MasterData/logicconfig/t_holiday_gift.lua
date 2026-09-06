-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holiday_gift.lua

module("logicconfig.config.t_holiday_gift", package.seeall)

local title = {
	activityId = 1,
	redPointId = 3,
	planId = 2
}
local dataList = {
	{
		186001,
		1,
		324
	},
	{
		186002,
		2,
		324
	},
	{
		186003,
		3,
		324
	},
	{
		186004,
		4,
		324
	},
	{
		186005,
		5,
		324
	},
	{
		186006,
		6,
		324
	},
	{
		186007,
		7,
		324
	},
	{
		186008,
		8,
		324
	},
	{
		186009,
		9,
		324
	},
	{
		186010,
		10,
		324
	},
	{
		186011,
		11,
		324
	},
	{
		186012,
		12,
		324
	},
	{
		186013,
		13,
		324
	},
	{
		186014,
		14,
		324
	},
	{
		186015,
		15,
		324
	},
	{
		186016,
		16,
		324
	},
	{
		186017,
		17,
		324
	},
	{
		186018,
		18,
		324
	},
	{
		186019,
		19,
		324
	},
	{
		186020,
		20,
		324
	},
	{
		186021,
		21,
		324
	},
	{
		186022,
		22,
		324
	},
	{
		186023,
		23,
		324
	},
	{
		186024,
		24,
		324
	},
	{
		186025,
		25,
		324
	},
	{
		186026,
		26,
		324
	},
	{
		186027,
		27,
		324
	},
	{
		186028,
		28,
		324
	},
	{
		186029,
		29,
		324
	},
	{
		186030,
		30,
		324
	},
	{
		186031,
		31,
		324
	},
	{
		186032,
		32,
		324
	},
	{
		186033,
		33,
		324
	},
	{
		186034,
		34,
		324
	},
	{
		186035,
		35,
		324
	},
	{
		186036,
		36,
		324
	},
	{
		186037,
		37,
		324
	},
	{
		186038,
		38,
		324
	},
	{
		186039,
		39,
		324
	},
	{
		186040,
		40,
		324
	},
	{
		186041,
		41,
		324
	},
	{
		186042,
		42,
		324
	},
	{
		186043,
		43,
		324
	},
	{
		186044,
		44,
		324
	},
	{
		186045,
		45,
		324
	},
	{
		186046,
		46,
		324
	},
	{
		186047,
		47,
		324
	},
	{
		186048,
		48,
		324
	},
	{
		186049,
		49,
		324
	},
	{
		186050,
		50,
		324
	}
}
local t_holiday_gift = {
	[186001] = dataList[1],
	[186002] = dataList[2],
	[186003] = dataList[3],
	[186004] = dataList[4],
	[186005] = dataList[5],
	[186006] = dataList[6],
	[186007] = dataList[7],
	[186008] = dataList[8],
	[186009] = dataList[9],
	[186010] = dataList[10],
	[186011] = dataList[11],
	[186012] = dataList[12],
	[186013] = dataList[13],
	[186014] = dataList[14],
	[186015] = dataList[15],
	[186016] = dataList[16],
	[186017] = dataList[17],
	[186018] = dataList[18],
	[186019] = dataList[19],
	[186020] = dataList[20],
	[186021] = dataList[21],
	[186022] = dataList[22],
	[186023] = dataList[23],
	[186024] = dataList[24],
	[186025] = dataList[25],
	[186026] = dataList[26],
	[186027] = dataList[27],
	[186028] = dataList[28],
	[186029] = dataList[29],
	[186030] = dataList[30],
	[186031] = dataList[31],
	[186032] = dataList[32],
	[186033] = dataList[33],
	[186034] = dataList[34],
	[186035] = dataList[35],
	[186036] = dataList[36],
	[186037] = dataList[37],
	[186038] = dataList[38],
	[186039] = dataList[39],
	[186040] = dataList[40],
	[186041] = dataList[41],
	[186042] = dataList[42],
	[186043] = dataList[43],
	[186044] = dataList[44],
	[186045] = dataList[45],
	[186046] = dataList[46],
	[186047] = dataList[47],
	[186048] = dataList[48],
	[186049] = dataList[49],
	[186050] = dataList[50]
}

t_holiday_gift.dataList = dataList

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

return t_holiday_gift
