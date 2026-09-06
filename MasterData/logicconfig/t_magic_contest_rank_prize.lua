-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_magic_contest_rank_prize.lua

module("logicconfig.config.t_magic_contest_rank_prize", package.seeall)

local title = {
	mailTpId = 4,
	prize = 7,
	type = 2,
	index = 3,
	title = 6,
	activityId = 1,
	rankRange = 5
}
local dataList = {
	{
		514001,
		0,
		1,
		354,
		{
			1,
			1
		},
		"1名",
		"1:300081:-1:1#104:2:1500"
	},
	{
		514001,
		0,
		2,
		354,
		{
			2,
			5
		},
		"2~5名",
		"1:300081:-1:1#104:2:1200"
	},
	{
		514001,
		0,
		3,
		354,
		{
			6,
			20
		},
		"6~20名",
		"1:300081:-1:1#104:2:1000"
	},
	{
		514001,
		0,
		4,
		354,
		{
			21,
			50
		},
		"21~50名",
		"1:300081:-1:1#104:2:800"
	},
	{
		514001,
		0,
		5,
		354,
		{
			51,
			100
		},
		"51~100名",
		"1:300081:-1:1#104:2:500"
	},
	{
		514001,
		0,
		6,
		354,
		{
			101,
			500
		},
		"101~500名",
		"1:300081:-1:1#104:2:300"
	},
	{
		514001,
		0,
		7,
		354,
		{
			501,
			1000
		},
		"501~1000名",
		"1:300081:-1:1#104:2:100"
	},
	{
		514001,
		1,
		1,
		355,
		{
			1,
			1
		},
		"1名",
		"1:300081:-1:1#104:2:1500"
	},
	{
		514001,
		1,
		2,
		355,
		{
			2,
			5
		},
		"2~5名",
		"1:300081:-1:1#104:2:1200"
	},
	{
		514001,
		1,
		3,
		355,
		{
			6,
			20
		},
		"6~20名",
		"1:300081:-1:1#104:2:1000"
	},
	{
		514001,
		1,
		4,
		355,
		{
			21,
			50
		},
		"21~50名",
		"1:300081:-1:1#104:2:800"
	},
	{
		514001,
		1,
		5,
		355,
		{
			51,
			100
		},
		"51~100名",
		"1:300081:-1:1#104:2:500"
	},
	{
		514001,
		1,
		6,
		355,
		{
			101,
			500
		},
		"101~500名",
		"1:300081:-1:1#104:2:300"
	},
	{
		514001,
		1,
		7,
		355,
		{
			501,
			1000
		},
		"501~1000名",
		"1:300081:-1:1#104:2:100"
	}
}
local t_magic_contest_rank_prize = {
	[514001] = {
		[0] = {
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
	}
}

t_magic_contest_rank_prize.dataList = dataList

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

return t_magic_contest_rank_prize
