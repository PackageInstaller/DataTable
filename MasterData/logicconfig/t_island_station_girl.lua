-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_island_station_girl.lua

module("logicconfig.config.t_island_station_girl", package.seeall)

local title = {
	maxFetter = 6,
	posAndScale = 8,
	collectSkinId = 5,
	girlName = 4,
	bubblePos = 9,
	girlId = 2,
	shopId = 3,
	dialoguePlanId = 7,
	activityId = 1
}
local dataList = {
	{
		487001,
		1,
		1,
		"海隅风情·音织",
		1603801,
		35,
		1,
		{
			-300,
			0,
			1
		},
		{
			-300,
			0
		}
	},
	{
		487001,
		2,
		1,
		"朗日晴风·龙尊神女",
		1701503,
		35,
		2,
		{
			0,
			0,
			1
		},
		{
			0,
			0
		}
	},
	{
		487001,
		3,
		1,
		"碧浪柔波·空灵神女",
		1603901,
		35,
		3,
		{
			300,
			0,
			1
		},
		{
			300,
			0
		}
	},
	{
		487001,
		4,
		2,
		"汐光海浴·斐妮娅",
		1802103,
		35,
		4,
		{
			-300,
			0,
			1
		},
		{
			-300,
			0
		}
	},
	{
		487001,
		5,
		2,
		"盛夏留影·誓祖神女",
		1203701,
		35,
		5,
		{
			0,
			0,
			1
		},
		{
			0,
			0
		}
	},
	{
		487001,
		6,
		2,
		"日暮海潮·无烬神女",
		1202702,
		35,
		6,
		{
			300,
			0,
			1
		},
		{
			300,
			0
		}
	}
}
local t_island_station_girl = {
	[487001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_island_station_girl.dataList = dataList

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

return t_island_station_girl
