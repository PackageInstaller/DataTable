-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_project_ash_progress_prize.lua

module("logicconfig.config.t_project_ash_progress_prize", package.seeall)

local title = {
	prize = 4,
	storyId = 6,
	progress = 3,
	id = 2,
	planId = 1,
	desc = 5
}
local dataList = {
	{
		1,
		1,
		"250000",
		"60:1:360",
		"全服抽奖次数>=250000",
		0
	},
	{
		1,
		2,
		"500000",
		"60:1:360",
		"全服抽奖次数>=500000",
		0
	},
	{
		1,
		3,
		"750000",
		"4:30003:400",
		"全服抽奖次数>=750000",
		0
	},
	{
		1,
		4,
		"1000000",
		"4:111:10",
		"全服抽奖次数>=1000000",
		4450010
	},
	{
		2,
		1,
		"10000",
		"8:1:250000",
		"个人伤害量>=10000",
		0
	},
	{
		2,
		2,
		"100000",
		"8:1:250000",
		"个人伤害量>=100000",
		0
	},
	{
		2,
		3,
		"1000000",
		"4:112:5",
		"个人伤害量>=1000000",
		0
	},
	{
		2,
		4,
		"10000000",
		"4:112:5",
		"个人伤害量>=10000000",
		0
	},
	{
		2,
		5,
		"100000000",
		"4:90316:1",
		"个人伤害量>=100000000",
		4450011
	},
	{
		3,
		1,
		"250000000000",
		"60:1:360",
		"全服伤害量>=250000000000",
		0
	},
	{
		3,
		2,
		"500000000000",
		"60:1:360",
		"全服伤害量>=500000000000",
		0
	},
	{
		3,
		3,
		"1000000000000",
		"4:503:50",
		"全服伤害量>=1000000000000",
		0
	},
	{
		3,
		4,
		"2000000000000",
		"4:400002:50",
		"全服伤害量>=2000000000000",
		0
	},
	{
		3,
		5,
		"3000000000000",
		"4:503:100",
		"全服伤害量>=3000000000000",
		0
	},
	{
		3,
		6,
		"4000000000000",
		"4:503:100",
		"全服伤害量>=4000000000000",
		0
	},
	{
		3,
		7,
		"5000000000000",
		"4:400002:50",
		"全服伤害量>=5000000000000",
		4450012
	}
}
local t_project_ash_progress_prize = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16]
	}
}

t_project_ash_progress_prize.dataList = dataList

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

return t_project_ash_progress_prize
