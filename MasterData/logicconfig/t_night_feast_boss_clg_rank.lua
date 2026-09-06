-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_night_feast_boss_clg_rank.lua

module("logicconfig.config.t_night_feast_boss_clg_rank", package.seeall)

local title = {
	rankRange = 3,
	prize = 4,
	rankPrizePlanId = 1,
	subId = 2
}
local dataList = {
	{
		1,
		1,
		{
			1,
			1
		},
		"104:2:2000"
	},
	{
		1,
		2,
		{
			2,
			10
		},
		"104:2:1500"
	},
	{
		1,
		3,
		{
			11,
			50
		},
		"104:2:1000"
	},
	{
		1,
		4,
		{
			51,
			100
		},
		"104:2:500"
	},
	{
		1,
		5,
		{
			101,
			500
		},
		"104:2:300"
	},
	{
		1,
		6,
		{
			501,
			1000
		},
		"104:2:200"
	},
	{
		1,
		7,
		{
			1001,
			5000
		},
		"104:2:100"
	},
	{
		2,
		1,
		{
			1,
			1
		},
		""
	},
	{
		2,
		2,
		{
			2,
			10
		},
		""
	},
	{
		2,
		3,
		{
			11,
			50
		},
		""
	},
	{
		2,
		4,
		{
			51,
			100
		},
		""
	},
	{
		2,
		5,
		{
			101,
			500
		},
		""
	},
	{
		2,
		6,
		{
			501,
			1000
		},
		""
	},
	{
		2,
		7,
		{
			1001,
			5000
		},
		""
	}
}
local t_night_feast_boss_clg_rank = {
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
}

t_night_feast_boss_clg_rank.dataList = dataList

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

return t_night_feast_boss_clg_rank
