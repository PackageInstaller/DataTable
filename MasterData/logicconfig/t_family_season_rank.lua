-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_season_rank.lua

module("logicconfig.config.t_family_season_rank", package.seeall)

local title = {
	rankType = 1,
	seasonId = 2,
	endTime = 4,
	scorePrizePlanId = 5,
	startTime = 3
}
local dataList = {
	{
		1,
		1,
		"2022-06-03T05:00:00",
		"2022-08-29T20:00:00",
		1
	},
	{
		1,
		2,
		"2022-08-29T21:00:00",
		"2022-11-21T10:00:00",
		1
	},
	{
		1,
		3,
		"2022-11-21T11:00:00",
		"2023-02-13T10:00:00",
		1
	},
	{
		1,
		4,
		"2023-02-13T11:00:00",
		"2023-05-08T10:00:00",
		1
	},
	{
		1,
		5,
		"2023-05-08T11:00:00",
		"2023-07-31T10:00:00",
		1
	},
	{
		1,
		6,
		"2023-07-31T11:00:00",
		"2023-10-23T10:00:00",
		1
	},
	{
		1,
		7,
		"2023-10-23T11:00:00",
		"2024-01-15T10:00:00",
		1
	},
	{
		2,
		1,
		"2022-06-03T05:00:00",
		"2022-08-29T05:00:00",
		0
	},
	{
		2,
		2,
		"2022-08-29T11:00:00",
		"2022-11-21T05:00:00",
		0
	},
	{
		2,
		3,
		"2022-11-21T11:00:00",
		"2023-02-13T05:00:00",
		0
	},
	{
		2,
		4,
		"2023-02-13T11:00:00",
		"2023-05-08T05:00:00",
		0
	},
	{
		2,
		5,
		"2023-05-08T11:00:00",
		"2023-07-31T05:00:00",
		0
	},
	{
		2,
		6,
		"2023-07-31T11:00:00",
		"2023-10-23T05:00:00",
		0
	},
	{
		2,
		7,
		"2023-10-23T11:00:00",
		"2024-01-15T05:00:00",
		0
	},
	{
		3,
		1,
		"2022-06-03T05:00:00",
		"2022-08-29T05:00:00",
		0
	},
	{
		3,
		2,
		"2022-08-29T11:00:00",
		"2022-11-21T05:00:00",
		0
	},
	{
		3,
		3,
		"2022-11-21T11:00:00",
		"2023-02-13T05:00:00",
		0
	},
	{
		3,
		4,
		"2023-02-13T11:00:00",
		"2023-05-08T05:00:00",
		0
	},
	{
		3,
		5,
		"2023-05-08T11:00:00",
		"2023-07-31T05:00:00",
		0
	},
	{
		3,
		6,
		"2023-07-31T11:00:00",
		"2023-10-23T05:00:00",
		0
	},
	{
		3,
		7,
		"2023-10-23T11:00:00",
		"2024-01-15T05:00:00",
		0
	}
}
local t_family_season_rank = {
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
	},
	{
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21]
	}
}

t_family_season_rank.dataList = dataList

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

return t_family_season_rank
