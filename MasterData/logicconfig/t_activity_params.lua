-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_activity_params.lua

module("logicconfig.config.t_activity_params", package.seeall)

local title = {
	value = 3,
	actId = 1,
	subKey = 2
}
local dataList = {
	{
		0,
		"reload",
		{
			ids = {
				5,
				6,
				11
			}
		}
	},
	{
		1,
		"totalFightLimit",
		{
			limitNum = 5
		}
	},
	{
		5,
		"showPet",
		{
			faceId = 1100601
		}
	},
	{
		5,
		"0",
		{
			id = 0,
			time = 5,
			material = "8:1:50000"
		}
	},
	{
		5,
		"1",
		{
			id = 1,
			time = 10,
			material = "4:30001:10"
		}
	},
	{
		5,
		"2",
		{
			id = 2,
			time = 20,
			material = "4:23:5"
		}
	},
	{
		5,
		"3",
		{
			id = 3,
			time = 30,
			material = "4:501:25"
		}
	},
	{
		5,
		"4",
		{
			id = 4,
			time = 40,
			material = "4:30:5"
		}
	},
	{
		5,
		"5",
		{
			id = 5,
			time = 50,
			material = "104:2:50"
		}
	},
	{
		6,
		"1",
		{
			lottery = 10,
			day = 1
		}
	},
	{
		6,
		"2",
		{
			lottery = 10,
			material = "4:40005:1",
			day = 2
		}
	},
	{
		6,
		"3",
		{
			lottery = 10,
			material = "4:41003:1",
			day = 3
		}
	},
	{
		6,
		"4",
		{
			lottery = 10,
			day = 4
		}
	},
	{
		6,
		"5",
		{
			lottery = 10,
			day = 5
		}
	},
	{
		6,
		"6",
		{
			lottery = 10,
			day = 6
		}
	},
	{
		6,
		"7",
		{
			lottery = 10,
			material = "100:10206:1:1",
			day = 7
		}
	},
	{
		9,
		"1",
		{
			condition = "4,1004,13",
			mp = "100:10324:1:1"
		}
	},
	{
		9,
		"2",
		{
			condition = "2,20",
			mp = "100:10324:1:1"
		}
	},
	{
		10,
		"cd",
		{
			cd = 24
		}
	},
	{
		11,
		"prize",
		{
			material = "104:2:288#4:36:10#8:1:1000000"
		}
	}
}
local t_activity_params = {
	[0] = {
		reload = dataList[1]
	},
	{
		totalFightLimit = dataList[2]
	},
	[5] = {
		showPet = dataList[3],
		["0"] = dataList[4],
		["1"] = dataList[5],
		["2"] = dataList[6],
		["3"] = dataList[7],
		["4"] = dataList[8],
		["5"] = dataList[9]
	},
	[6] = {
		["1"] = dataList[10],
		["2"] = dataList[11],
		["3"] = dataList[12],
		["4"] = dataList[13],
		["5"] = dataList[14],
		["6"] = dataList[15],
		["7"] = dataList[16]
	},
	[9] = {
		["1"] = dataList[17],
		["2"] = dataList[18]
	},
	[10] = {
		cd = dataList[19]
	},
	[11] = {
		prize = dataList[20]
	}
}

t_activity_params.dataList = dataList

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

return t_activity_params
