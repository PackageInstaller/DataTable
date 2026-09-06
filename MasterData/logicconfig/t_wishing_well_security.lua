-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wishing_well_security.lua

module("logicconfig.config.t_wishing_well_security", package.seeall)

local title = {
	prizeShow = 3,
	planId = 1,
	times = 2
}
local dataList = {
	{
		1,
		10,
		"4:100003:1"
	},
	{
		1,
		20,
		"4:100003:1"
	},
	{
		1,
		30,
		"4:100003:1"
	},
	{
		1,
		40,
		"4:100003:1"
	},
	{
		1,
		50,
		"4:100003:1"
	},
	{
		1,
		60,
		"4:100003:1"
	},
	{
		1,
		70,
		"4:100003:1"
	},
	{
		1,
		80,
		"4:100003:1"
	},
	{
		1,
		90,
		"4:100003:1"
	},
	{
		1,
		100,
		"4:100003:1"
	},
	{
		2,
		10,
		"4:100003:1"
	},
	{
		2,
		20,
		"4:100003:1"
	},
	{
		2,
		30,
		"4:100003:1"
	},
	{
		2,
		40,
		"4:100003:1"
	},
	{
		2,
		50,
		"4:100003:1"
	},
	{
		2,
		60,
		"4:100003:1"
	},
	{
		2,
		70,
		"4:100003:1"
	},
	{
		2,
		80,
		"4:100003:1"
	},
	{
		2,
		90,
		"4:100003:1"
	},
	{
		2,
		100,
		"4:100003:1"
	},
	{
		3,
		10,
		"4:100003:1"
	},
	{
		3,
		20,
		"4:100003:1"
	},
	{
		3,
		30,
		"4:100003:1"
	},
	{
		3,
		40,
		"4:100003:1"
	},
	{
		3,
		50,
		"4:100003:1"
	},
	{
		3,
		60,
		"4:100003:1"
	},
	{
		3,
		70,
		"4:100003:1"
	},
	{
		3,
		80,
		"4:100003:1"
	},
	{
		3,
		90,
		"4:100003:1"
	},
	{
		3,
		100,
		"4:100003:1"
	}
}
local t_wishing_well_security = {
	{
		[10] = dataList[1],
		[20] = dataList[2],
		[30] = dataList[3],
		[40] = dataList[4],
		[50] = dataList[5],
		[60] = dataList[6],
		[70] = dataList[7],
		[80] = dataList[8],
		[90] = dataList[9],
		[100] = dataList[10]
	},
	{
		[10] = dataList[11],
		[20] = dataList[12],
		[30] = dataList[13],
		[40] = dataList[14],
		[50] = dataList[15],
		[60] = dataList[16],
		[70] = dataList[17],
		[80] = dataList[18],
		[90] = dataList[19],
		[100] = dataList[20]
	},
	{
		[10] = dataList[21],
		[20] = dataList[22],
		[30] = dataList[23],
		[40] = dataList[24],
		[50] = dataList[25],
		[60] = dataList[26],
		[70] = dataList[27],
		[80] = dataList[28],
		[90] = dataList[29],
		[100] = dataList[30]
	}
}

t_wishing_well_security.dataList = dataList

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

return t_wishing_well_security
