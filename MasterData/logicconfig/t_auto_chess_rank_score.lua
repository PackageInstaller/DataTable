-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_auto_chess_rank_score.lua

module("logicconfig.config.t_auto_chess_rank_score", package.seeall)

local title = {
	score = 3,
	activityId = 1,
	rank = 2,
	prize = 4
}
local dataList = {
	{
		286001,
		1,
		6,
		"10:287001:12"
	},
	{
		286001,
		2,
		4,
		"10:287001:8"
	},
	{
		286001,
		3,
		3,
		"10:287001:6"
	},
	{
		286001,
		4,
		2,
		"10:287001:4"
	},
	{
		286001,
		5,
		1,
		"10:287001:2"
	},
	{
		286001,
		6,
		0,
		""
	},
	{
		286002,
		1,
		6,
		"10:287002:12"
	},
	{
		286002,
		2,
		4,
		"10:287002:8"
	},
	{
		286002,
		3,
		3,
		"10:287002:6"
	},
	{
		286002,
		4,
		2,
		"10:287002:4"
	},
	{
		286002,
		5,
		1,
		"10:287002:2"
	},
	{
		286002,
		6,
		0,
		""
	},
	{
		286003,
		1,
		6,
		"10:17087:6#10:310002:6"
	},
	{
		286003,
		2,
		4,
		"10:17087:4#10:310002:4"
	},
	{
		286003,
		3,
		3,
		"10:17087:3#10:310002:3"
	},
	{
		286003,
		4,
		2,
		"10:17087:2#10:310002:2"
	},
	{
		286003,
		5,
		1,
		"10:17087:1#10:310002:1"
	},
	{
		286003,
		6,
		0,
		""
	},
	{
		286004,
		1,
		6,
		"10:286004:20#10:275003:50"
	},
	{
		286004,
		2,
		4,
		"10:286004:16#10:275003:40"
	},
	{
		286004,
		3,
		3,
		"10:286004:12#10:275003:30"
	},
	{
		286004,
		4,
		2,
		"10:286004:8#10:275003:20"
	},
	{
		286004,
		5,
		1,
		"10:286004:4#10:275003:10"
	},
	{
		286004,
		6,
		0,
		"10:275003:5"
	},
	{
		286005,
		1,
		6,
		"10:286005:20#10:275005:50"
	},
	{
		286005,
		2,
		4,
		"10:286005:16#10:275005:40"
	},
	{
		286005,
		3,
		3,
		"10:286005:12#10:275005:30"
	},
	{
		286005,
		4,
		2,
		"10:286005:8#10:275005:20"
	},
	{
		286005,
		5,
		1,
		"10:286005:4#10:275005:10"
	},
	{
		286005,
		6,
		0,
		"10:275005:5"
	}
}
local t_auto_chess_rank_score = {
	[286001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[286002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	[286003] = {
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	},
	[286004] = {
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24]
	},
	[286005] = {
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30]
	}
}

t_auto_chess_rank_score.dataList = dataList

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

return t_auto_chess_rank_score
