-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_ci_yuan_universal_signin.lua

module("logicconfig.config.t_divine_ci_yuan_universal_signin", package.seeall)

local title = {
	days = 3,
	buffId = 4,
	activityId = 1,
	tabId = 2
}
local dataList = {
	{
		302001,
		1,
		1,
		23
	},
	{
		302001,
		1,
		2,
		24
	},
	{
		302001,
		1,
		3,
		25
	},
	{
		302001,
		1,
		4,
		26
	},
	{
		302001,
		1,
		5,
		27
	},
	{
		302001,
		1,
		6,
		28
	},
	{
		302001,
		1,
		7,
		29
	},
	{
		302001,
		2,
		1,
		23
	},
	{
		302001,
		2,
		2,
		24
	},
	{
		302001,
		2,
		3,
		25
	},
	{
		302001,
		2,
		4,
		26
	},
	{
		302001,
		2,
		5,
		27
	},
	{
		302001,
		2,
		6,
		28
	},
	{
		302001,
		2,
		7,
		29
	},
	{
		302002,
		1,
		1,
		23
	},
	{
		302002,
		1,
		2,
		24
	},
	{
		302002,
		1,
		3,
		25
	},
	{
		302002,
		1,
		4,
		26
	},
	{
		302002,
		1,
		5,
		27
	},
	{
		302002,
		1,
		6,
		28
	},
	{
		302002,
		1,
		7,
		29
	},
	{
		302002,
		2,
		1,
		23
	},
	{
		302002,
		2,
		2,
		24
	},
	{
		302002,
		2,
		3,
		25
	},
	{
		302002,
		2,
		4,
		26
	},
	{
		302002,
		2,
		5,
		27
	},
	{
		302002,
		2,
		6,
		28
	},
	{
		302002,
		2,
		7,
		29
	}
}
local t_divine_ci_yuan_universal_signin = {
	[302001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6],
			dataList[7]
		},
		{
			dataList[8],
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12],
			dataList[13],
			dataList[14]
		}
	},
	[302002] = {
		{
			dataList[15],
			dataList[16],
			dataList[17],
			dataList[18],
			dataList[19],
			dataList[20],
			dataList[21]
		},
		{
			dataList[22],
			dataList[23],
			dataList[24],
			dataList[25],
			dataList[26],
			dataList[27],
			dataList[28]
		}
	}
}

t_divine_ci_yuan_universal_signin.dataList = dataList

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

return t_divine_ci_yuan_universal_signin
