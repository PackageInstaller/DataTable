-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_jieshen_vs_jiu_progress_prize.lua

module("logicconfig.config.t_jieshen_vs_jiu_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		390001,
		1,
		30,
		"4:400002:20"
	},
	{
		390001,
		2,
		60,
		"104:2:100"
	},
	{
		390001,
		3,
		90,
		"4:111:2"
	},
	{
		390001,
		4,
		120,
		"60:1:500"
	},
	{
		390001,
		5,
		150,
		"4:400002:20"
	},
	{
		390001,
		6,
		180,
		"104:2:100"
	},
	{
		390001,
		7,
		210,
		"4:111:2"
	},
	{
		390001,
		8,
		240,
		"60:1:500"
	},
	{
		390001,
		9,
		270,
		"4:400002:20"
	},
	{
		390001,
		10,
		300,
		"104:2:100"
	},
	{
		390001,
		11,
		330,
		"4:111:2"
	},
	{
		390001,
		12,
		360,
		"60:1:500"
	},
	{
		390001,
		13,
		390,
		"4:400002:20"
	},
	{
		390001,
		14,
		420,
		"104:2:100"
	},
	{
		390001,
		15,
		450,
		"4:111:2"
	},
	{
		390001,
		16,
		480,
		"60:1:500"
	},
	{
		390001,
		17,
		510,
		"4:400002:20"
	},
	{
		390001,
		18,
		540,
		"104:2:100"
	},
	{
		390001,
		19,
		570,
		"4:111:2"
	},
	{
		390001,
		20,
		600,
		"60:1:500"
	}
}
local t_jieshen_vs_jiu_progress_prize = {
	[390001] = {
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
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_jieshen_vs_jiu_progress_prize.dataList = dataList

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

return t_jieshen_vs_jiu_progress_prize
