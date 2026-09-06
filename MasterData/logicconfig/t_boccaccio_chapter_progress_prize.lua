-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_boccaccio_chapter_progress_prize.lua

module("logicconfig.config.t_boccaccio_chapter_progress_prize", package.seeall)

local title = {
	progressId = 2,
	progressPlan = 1,
	prize = 4,
	progress = 3
}
local dataList = {
	{
		1,
		1,
		"1",
		"9:1001456:50"
	},
	{
		1,
		2,
		"3",
		"9:1001456:100"
	},
	{
		1,
		3,
		"6",
		"9:1001456:250"
	},
	{
		1,
		4,
		"9",
		"9:1001456:300"
	},
	{
		1,
		5,
		"12",
		"9:1001456:500"
	},
	{
		2,
		1,
		"1",
		"9:1001456:100"
	},
	{
		2,
		2,
		"2",
		"9:1001456:200"
	},
	{
		2,
		3,
		"4",
		"9:1001456:300"
	},
	{
		2,
		4,
		"6",
		"9:1001456:300"
	},
	{
		2,
		5,
		"8",
		"9:1001456:300"
	},
	{
		3,
		1,
		"1",
		"9:1001456:100"
	},
	{
		3,
		2,
		"3",
		"9:1001456:200"
	},
	{
		3,
		3,
		"6",
		"9:1001456:300"
	},
	{
		3,
		4,
		"9",
		"9:1001456:300"
	},
	{
		3,
		5,
		"12",
		"9:1001456:400"
	},
	{
		3,
		6,
		"15",
		"9:1001456:450"
	},
	{
		4,
		1,
		"150000000",
		"9:1001457:100"
	},
	{
		4,
		2,
		"300000000",
		"9:1001457:100"
	},
	{
		4,
		3,
		"450000000",
		"9:1001457:100"
	},
	{
		4,
		4,
		"600000000",
		"9:1001457:150"
	},
	{
		4,
		5,
		"750000000",
		"9:1001457:150"
	},
	{
		4,
		6,
		"900000000",
		"9:1001457:150"
	},
	{
		4,
		7,
		"1050000000",
		"9:1001457:200"
	},
	{
		4,
		8,
		"1200000000",
		"9:1001457:200"
	},
	{
		4,
		9,
		"1350000000",
		"9:1001457:200"
	},
	{
		4,
		10,
		"1500000000",
		"9:1001457:250"
	},
	{
		4,
		11,
		"1650000000",
		"9:1001457:250"
	},
	{
		4,
		12,
		"2000000000",
		"9:1001457:250"
	}
}
local t_boccaccio_chapter_progress_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	},
	{
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
		dataList[28]
	}
}

t_boccaccio_chapter_progress_prize.dataList = dataList

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

return t_boccaccio_chapter_progress_prize
