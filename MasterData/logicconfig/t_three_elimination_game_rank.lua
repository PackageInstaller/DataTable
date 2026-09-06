-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_three_elimination_game_rank.lua

module("logicconfig.config.t_three_elimination_game_rank", package.seeall)

local title = {
	rankRange = 3,
	prize = 4,
	activityId = 1,
	subId = 2
}
local dataList = {
	{
		339001,
		1,
		{
			1,
			1
		},
		"104:2:1000#8:1:10000000"
	},
	{
		339001,
		2,
		{
			2,
			10
		},
		"104:2:800#8:1:8000000"
	},
	{
		339001,
		3,
		{
			11,
			50
		},
		"104:2:500#8:1:5000000"
	},
	{
		339001,
		4,
		{
			51,
			100
		},
		"104:2:200#8:1:2000000"
	},
	{
		339002,
		1,
		{
			1,
			1
		},
		"104:2:1000#8:1:10000000"
	},
	{
		339002,
		2,
		{
			2,
			10
		},
		"104:2:800#8:1:8000000"
	},
	{
		339002,
		3,
		{
			11,
			50
		},
		"104:2:500#8:1:5000000"
	},
	{
		339002,
		4,
		{
			51,
			100
		},
		"104:2:200#8:1:2000000"
	},
	{
		339003,
		1,
		{
			1,
			1
		},
		"104:2:1000#8:1:10000000"
	},
	{
		339003,
		2,
		{
			2,
			10
		},
		"104:2:800#8:1:8000000"
	},
	{
		339003,
		3,
		{
			11,
			50
		},
		"104:2:500#8:1:5000000"
	},
	{
		339003,
		4,
		{
			51,
			100
		},
		"104:2:200#8:1:2000000"
	},
	{
		339004,
		1,
		{
			1,
			1
		},
		"104:2:1000#8:1:10000000"
	},
	{
		339004,
		2,
		{
			2,
			10
		},
		"104:2:800#8:1:8000000"
	},
	{
		339004,
		3,
		{
			11,
			50
		},
		"104:2:500#8:1:5000000"
	},
	{
		339004,
		4,
		{
			51,
			100
		},
		"104:2:200#8:1:2000000"
	}
}
local t_three_elimination_game_rank = {
	[339001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[339002] = {
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	[339003] = {
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[339004] = {
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_three_elimination_game_rank.dataList = dataList

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

return t_three_elimination_game_rank
