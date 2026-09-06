-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_task_form_verify.lua

module("logicconfig.config.t_saint_knight_task_form_verify", package.seeall)

local title = {
	zdl = 3,
	formVerityPlanId = 1,
	raceIds = 2,
	tip = 6,
	prize = 4,
	excludePublicStrengthens = 5
}
local dataList = {
	{
		1,
		{
			15016,
			11009,
			13007,
			11010,
			12017,
			14015
		},
		400000,
		"1:300037:-1:1",
		true,
		""
	},
	{
		2,
		{
			14017,
			14018,
			14019,
			14020,
			14021
		},
		350000,
		"2:134:1",
		true,
		""
	},
	{
		3,
		{
			15017,
			15018,
			15019,
			15020,
			15021,
			15022
		},
		400000,
		"2:140:1",
		true,
		""
	},
	{
		4,
		{
			16019,
			16020,
			16021,
			16022,
			16023
		},
		350000,
		"2:156:1",
		true,
		""
	},
	{
		5,
		{
			16025,
			12022,
			14025,
			13019,
			11024,
			15025
		},
		400000,
		"1:300047:-1:1",
		true,
		""
	},
	{
		7,
		{
			17019,
			17020,
			17021,
			17022,
			17023
		},
		350000,
		"2:182:1",
		true,
		""
	},
	{
		8,
		{
			15026,
			15027,
			15028,
			15029,
			15030
		},
		350000,
		"2:189:1",
		true,
		""
	},
	{
		9,
		{
			16028,
			16027,
			16029,
			16030
		},
		280000,
		"2:197:1",
		true,
		""
	},
	{
		10,
		{
			12026,
			12024,
			12025,
			13020,
			12023,
			11025
		},
		400000,
		"2:206:1",
		true,
		""
	},
	{
		11,
		{
			13021,
			12027,
			12028,
			13022,
			11026,
			11027
		},
		420000,
		"2:209:1",
		true,
		"王者无烬需先解除契约才可以上阵验证"
	},
	{
		12,
		{
			14031,
			12029,
			16031,
			15031,
			16032
		},
		350000,
		"2:213:1",
		true,
		""
	},
	{
		13,
		{
			14032,
			14033,
			14034,
			15034,
			16034
		},
		350000,
		"13:402:1",
		true,
		""
	},
	{
		14,
		{
			14035,
			11029,
			12031,
			13024,
			12032,
			15035
		},
		400000,
		"2:234:1",
		true,
		""
	},
	{
		15,
		{
			16035,
			16036,
			16037,
			16038,
			16039
		},
		350000,
		"13:434:1",
		true,
		""
	},
	{
		16,
		{
			11030,
			11032,
			16040,
			11033,
			14036,
			11034
		},
		420000,
		"29:33:1",
		true,
		""
	},
	{
		17,
		{
			12038,
			15036,
			14037,
			14038,
			11035,
			17024
		},
		400000,
		"13:466:1",
		true,
		""
	},
	{
		18,
		{
			15037,
			15038,
			15039,
			15040,
			15041
		},
		350000,
		"2:258:1",
		true,
		""
	},
	{
		19,
		{
			13025,
			13026,
			13027,
			13028,
			13029
		},
		350000,
		"2:273:1",
		true,
		""
	},
	{
		20,
		{
			12040,
			12041,
			12042,
			12043,
			12044,
			12045
		},
		420000,
		"2:284:1",
		true,
		""
	},
	{
		21,
		{
			11036,
			11037,
			11038,
			11039,
			11040
		},
		350000,
		"2:286:1",
		true,
		""
	},
	{
		22,
		{
			11041,
			11042,
			15050,
			13031,
			12046,
			14044
		},
		858000,
		"9:1300059:1",
		true,
		""
	}
}
local t_saint_knight_task_form_verify = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	[7] = dataList[6],
	[8] = dataList[7],
	[9] = dataList[8],
	[10] = dataList[9],
	[11] = dataList[10],
	[12] = dataList[11],
	[13] = dataList[12],
	[14] = dataList[13],
	[15] = dataList[14],
	[16] = dataList[15],
	[17] = dataList[16],
	[18] = dataList[17],
	[19] = dataList[18],
	[20] = dataList[19],
	[21] = dataList[20],
	[22] = dataList[21]
}

t_saint_knight_task_form_verify.dataList = dataList

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

return t_saint_knight_task_form_verify
