-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_number_game_rank.lua

module("logicconfig.config.t_number_game_rank", package.seeall)

local title = {
	rankDes = 3,
	prize = 4,
	planId = 1,
	rightTop = 2
}
local dataList = {
	{
		1,
		1,
		"第1名",
		"104:2:300#8:1:1000000"
	},
	{
		1,
		2,
		"第2名",
		"104:2:250#8:1:800000"
	},
	{
		1,
		3,
		"第3名",
		"104:2:225#8:1:700000"
	},
	{
		1,
		5,
		"4~5名",
		"104:2:200#8:1:600000"
	},
	{
		1,
		10,
		"6~10名",
		"104:2:180#8:1:500000"
	},
	{
		1,
		20,
		"11~20名",
		"104:2:160#8:1:400000"
	},
	{
		1,
		50,
		"21~50名",
		"104:2:140#8:1:300000"
	},
	{
		1,
		100,
		"51~100名",
		"104:2:120#8:1:200000"
	},
	{
		1,
		99999,
		"100~99999名",
		"104:2:100#8:1:100000"
	},
	{
		2,
		1,
		"第1名",
		"8:1:1000"
	},
	{
		2,
		99999,
		"100~99999名",
		"8:1:1000"
	}
}
local t_number_game_rank = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		[5] = dataList[4],
		[10] = dataList[5],
		[20] = dataList[6],
		[50] = dataList[7],
		[100] = dataList[8],
		[99999] = dataList[9]
	},
	{
		dataList[10],
		[99999] = dataList[11]
	}
}

t_number_game_rank.dataList = dataList

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

return t_number_game_rank
