-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_phantom_space_rank_prize.lua

module("logicconfig.config.t_phantom_space_rank_prize", package.seeall)

local title = {
	prize = 5,
	index = 2,
	title = 4,
	activityId = 1,
	rankRange = 3
}
local dataList = {
	{
		516001,
		1,
		{
			1,
			1
		},
		"1名",
		"2:257:1#104:2:1000#8:1:2000000"
	},
	{
		516001,
		2,
		{
			2,
			5
		},
		"2~5名",
		"2:257:1#104:2:800#8:1:1500000"
	},
	{
		516001,
		3,
		{
			6,
			20
		},
		"6~20名",
		"2:257:1#104:2:600#8:1:1000000"
	},
	{
		516001,
		4,
		{
			21,
			50
		},
		"21~50名",
		"2:257:1#104:2:500#8:1:800000"
	},
	{
		516001,
		5,
		{
			51,
			100
		},
		"51~100名",
		"2:257:1#104:2:400#8:1:500000"
	},
	{
		516001,
		6,
		{
			101,
			500
		},
		"101~500名",
		"2:257:1#104:2:300#8:1:300000"
	},
	{
		516001,
		7,
		{
			501,
			1000
		},
		"501~1000名",
		"2:257:1#104:2:100#8:1:100000"
	},
	{
		516002,
		1,
		{
			1,
			1
		},
		"1名",
		"2:257:1#104:2:1000#8:1:2000000"
	},
	{
		516002,
		2,
		{
			2,
			5
		},
		"2~5名",
		"2:257:1#104:2:800#8:1:1500000"
	},
	{
		516002,
		3,
		{
			6,
			20
		},
		"6~20名",
		"2:257:1#104:2:600#8:1:1000000"
	},
	{
		516002,
		4,
		{
			21,
			50
		},
		"21~50名",
		"2:257:1#104:2:500#8:1:800000"
	},
	{
		516002,
		5,
		{
			51,
			100
		},
		"51~100名",
		"2:257:1#104:2:400#8:1:500000"
	},
	{
		516002,
		6,
		{
			101,
			500
		},
		"101~500名",
		"2:257:1#104:2:300#8:1:300000"
	},
	{
		516002,
		7,
		{
			501,
			1000
		},
		"501~1000名",
		"2:257:1#104:2:100#8:1:100000"
	}
}
local t_phantom_space_rank_prize = {
	[516001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	},
	[516002] = {
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14]
	}
}

t_phantom_space_rank_prize.dataList = dataList

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

return t_phantom_space_rank_prize
