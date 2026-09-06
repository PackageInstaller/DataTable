-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_xia_yin_progress_prize.lua

module("logicconfig.config.t_xia_yin_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		336001,
		1,
		1,
		"4:225:3"
	},
	{
		336001,
		2,
		2,
		"4:225:3"
	},
	{
		336001,
		3,
		3,
		"4:225:4"
	},
	{
		336001,
		4,
		4,
		"4:225:5"
	},
	{
		336001,
		5,
		5,
		"4:225:5"
	},
	{
		336001,
		6,
		6,
		"4:225:6"
	},
	{
		336001,
		7,
		7,
		"4:225:7"
	},
	{
		336001,
		8,
		8,
		"4:225:8"
	},
	{
		336001,
		9,
		9,
		"4:225:9"
	},
	{
		336001,
		10,
		10,
		"4:225:10"
	},
	{
		336001,
		11,
		11,
		"4:225:10"
	},
	{
		336001,
		12,
		12,
		"4:225:11"
	},
	{
		336001,
		13,
		13,
		"4:225:12"
	},
	{
		336001,
		14,
		14,
		"4:225:13"
	},
	{
		336001,
		15,
		15,
		"4:225:14"
	},
	{
		336002,
		1,
		1,
		"4:285:4"
	},
	{
		336002,
		2,
		2,
		"4:285:4"
	},
	{
		336002,
		3,
		3,
		"4:285:4"
	},
	{
		336002,
		4,
		4,
		"4:285:4"
	},
	{
		336002,
		5,
		5,
		"4:285:4"
	},
	{
		336002,
		6,
		6,
		"4:285:6"
	},
	{
		336002,
		7,
		7,
		"4:285:6"
	},
	{
		336002,
		8,
		8,
		"4:285:6"
	},
	{
		336002,
		9,
		9,
		"4:285:6"
	},
	{
		336002,
		10,
		10,
		"4:285:6"
	},
	{
		336002,
		11,
		11,
		"4:285:10"
	},
	{
		336002,
		12,
		12,
		"4:285:10"
	},
	{
		336002,
		13,
		13,
		"4:285:10"
	},
	{
		336002,
		14,
		14,
		"4:285:10"
	},
	{
		336002,
		15,
		15,
		"4:285:10"
	},
	{
		336003,
		1,
		1,
		"8:1:1"
	}
}
local t_xia_yin_progress_prize = {
	[336001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	},
	[336002] = {
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20],
		dataList[21],
		dataList[22],
		dataList[23],
		dataList[24],
		dataList[25],
		dataList[26],
		dataList[27],
		dataList[28],
		dataList[29],
		dataList[30]
	},
	[336003] = {
		dataList[31]
	}
}

t_xia_yin_progress_prize.dataList = dataList

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

return t_xia_yin_progress_prize
