-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_time_limit_rank_top_prize.lua

module("logicconfig.config.t_time_limit_rank_top_prize", package.seeall)

local title = {
	startRank = 2,
	name = 4,
	id = 1,
	prize = 5,
	endRank = 3
}
local dataList = {
	{
		3,
		1,
		1,
		"第1名",
		"2:23:1#4:40008:4#4:40007:3"
	},
	{
		3,
		2,
		10,
		"第2~10名",
		"4:40008:2#4:40007:3#4:503:10"
	},
	{
		3,
		11,
		50,
		"第11~50名",
		"4:40008:1#4:40007:3#4:503:10"
	},
	{
		3,
		51,
		100,
		"第51~100名",
		"4:40008:1#4:40007:2#4:503:10"
	},
	{
		3,
		101,
		1000,
		"第101~1000名",
		"4:40008:1#4:40007:1#4:503:10"
	},
	{
		4,
		1,
		1,
		"第1名",
		"2:24:1#4:40008:4#4:40007:3"
	},
	{
		4,
		2,
		10,
		"第2~10名",
		"4:40008:2#4:40007:3#4:503:10"
	},
	{
		4,
		11,
		50,
		"第11~50名",
		"4:40008:1#4:40007:3#4:503:10"
	},
	{
		4,
		51,
		100,
		"第51~100名",
		"4:40008:1#4:40007:2#4:503:10"
	},
	{
		4,
		101,
		1000,
		"第101~1000名",
		"4:40008:1#4:40007:1#4:503:10"
	},
	{
		5,
		1,
		1,
		"第1名",
		"2:25:1#4:40008:4#4:40007:3"
	},
	{
		5,
		2,
		10,
		"第2~10名",
		"4:40008:2#4:40007:3#4:503:10"
	},
	{
		5,
		11,
		50,
		"第11~50名",
		"4:40008:1#4:40007:3#4:503:10"
	},
	{
		5,
		51,
		100,
		"第51~100名",
		"4:40008:1#4:40007:2#4:503:10"
	},
	{
		5,
		101,
		1000,
		"第101~1000名",
		"4:40008:1#4:40007:1#4:503:10"
	},
	{
		6,
		1,
		1,
		"第1名",
		"2:26:1#4:40008:4#4:40007:3"
	},
	{
		6,
		2,
		10,
		"第2~10名",
		"4:40008:2#4:40007:3#4:503:10"
	},
	{
		6,
		11,
		50,
		"第11~50名",
		"4:40008:1#4:40007:3#4:503:10"
	},
	{
		6,
		51,
		100,
		"第51~100名",
		"4:40008:1#4:40007:2#4:503:10"
	},
	{
		6,
		101,
		1000,
		"第101~1000名",
		"4:40008:1#4:40007:1#4:503:10"
	}
}
local t_time_limit_rank_top_prize = {
	[3] = {
		dataList[1],
		dataList[2],
		[11] = dataList[3],
		[51] = dataList[4],
		[101] = dataList[5]
	},
	[4] = {
		dataList[6],
		dataList[7],
		[11] = dataList[8],
		[51] = dataList[9],
		[101] = dataList[10]
	},
	[5] = {
		dataList[11],
		dataList[12],
		[11] = dataList[13],
		[51] = dataList[14],
		[101] = dataList[15]
	},
	[6] = {
		dataList[16],
		dataList[17],
		[11] = dataList[18],
		[51] = dataList[19],
		[101] = dataList[20]
	}
}

t_time_limit_rank_top_prize.dataList = dataList

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

return t_time_limit_rank_top_prize
