-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_cash_back_prize.lua

module("logicconfig.config.t_cash_back_prize", package.seeall)

local title = {
	prizeId = 2,
	progressReq = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		193001,
		1,
		60,
		"4:30006:10#4:31:1#8:1:100000"
	},
	{
		193001,
		2,
		120,
		"4:30006:10#4:31:1#8:1:100000"
	},
	{
		193001,
		3,
		300,
		"4:30006:10#4:31:1#8:1:300000"
	},
	{
		193001,
		4,
		680,
		"4:30006:10#1:300029:-1:1#8:1:300000"
	},
	{
		193001,
		5,
		980,
		"4:510023:1#4:31:1#8:1:300000"
	},
	{
		193001,
		6,
		1480,
		"4:30006:10#4:31:5#8:1:300000"
	},
	{
		193001,
		7,
		1980,
		"4:30006:10#4:31:5#8:1:300000"
	},
	{
		193001,
		8,
		2480,
		"4:510023:1#4:31:5#8:1:300000"
	},
	{
		193001,
		9,
		2880,
		"4:30006:10#4:31:5#8:1:300000"
	},
	{
		193001,
		10,
		3280,
		"4:30006:10#4:31:5#8:1:300000"
	},
	{
		193001,
		11,
		3680,
		"4:510023:1#4:31:5#8:1:300000"
	},
	{
		193001,
		12,
		4280,
		"4:30006:10#4:31:5#8:1:300000"
	},
	{
		193001,
		13,
		4880,
		"4:30006:10#4:31:5#8:1:300000"
	},
	{
		193001,
		14,
		5480,
		"4:30006:10#4:31:5#8:1:300000"
	},
	{
		193001,
		15,
		6480,
		"4:510023:1#4:31:5#8:1:300000"
	}
}
local t_cash_back_prize = {
	[193001] = {
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
	}
}

t_cash_back_prize.dataList = dataList

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

return t_cash_back_prize
