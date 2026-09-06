-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_activity_signIn_show.lua

module("logicconfig.config.t_activity_signIn_show", package.seeall)

local title = {
	showPrize = 3,
	showTimes = 4,
	showEffType = 5,
	showTags = 6,
	activityId = 1,
	day = 2
}
local dataList = {
	{
		18007,
		1,
		"4:10:300",
		1,
		1,
		{
			2
		}
	},
	{
		18007,
		2,
		"4:11:300",
		2,
		2,
		{
			5
		}
	},
	{
		18007,
		3,
		"100:10167:1:1",
		1,
		3,
		{
			7
		}
	},
	{
		18007,
		4,
		"8:1:3000000",
		1,
		0
	},
	{
		18007,
		5,
		"4:31:10",
		2,
		0
	},
	{
		18007,
		6,
		"4:31:10",
		1,
		0
	},
	{
		18007,
		7,
		"4:31:10",
		2,
		0
	},
	{
		18008,
		1,
		"4:13:300",
		1,
		1,
		{
			2
		}
	},
	{
		18008,
		2,
		"4:90063:1",
		2,
		2,
		{
			5
		}
	},
	{
		18008,
		3,
		"4:30003:120",
		1,
		3,
		{
			7
		}
	},
	{
		18008,
		4,
		"60:1:1000",
		1,
		0
	},
	{
		18008,
		5,
		"4:503:50",
		2,
		0
	},
	{
		18008,
		6,
		"4:140001:1",
		1,
		0
	},
	{
		18008,
		7,
		"4:3:150",
		2,
		0
	},
	{
		18009,
		1,
		"4:4001:300",
		1,
		1,
		{
			2
		}
	},
	{
		18009,
		2,
		"4:4004:300",
		2,
		2,
		{
			5
		}
	},
	{
		18009,
		3,
		"4:4005:300",
		1,
		0
	},
	{
		18009,
		4,
		"4:4002:300",
		1,
		0
	},
	{
		18009,
		5,
		"4:4003:300",
		2,
		0
	},
	{
		18009,
		6,
		"4:90031:2",
		1,
		0
	},
	{
		18010,
		1,
		"1:11070:-1:1",
		2,
		0
	},
	{
		18010,
		2,
		"1:11069:-1:1",
		2,
		0
	},
	{
		18010,
		3,
		"4:10:240",
		1,
		0
	},
	{
		18010,
		4,
		"4:13:120",
		1,
		0
	},
	{
		18010,
		5,
		"8:1:1000000",
		2,
		0
	},
	{
		18010,
		6,
		"4:14:120",
		1,
		0
	},
	{
		18010,
		7,
		"4:90031:1",
		2,
		0
	}
}
local t_activity_signIn_show = {
	[18007] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	[18008] = {
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	},
	[18009] = {
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	},
	[18010] = {
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27]
	}
}

t_activity_signIn_show.dataList = dataList

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

return t_activity_signIn_show
