-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_pool_progress_prize.lua

module("logicconfig.config.t_dragon_pool_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	actId = 1,
	progress = 3
}
local dataList = {
	{
		300001,
		1,
		1,
		"10:17084:200"
	},
	{
		300001,
		2,
		2,
		"60:1:300"
	},
	{
		300001,
		3,
		3,
		"4:111:5"
	},
	{
		300001,
		4,
		4,
		"10:17084:200"
	},
	{
		300001,
		5,
		5,
		"8:1:1000000"
	},
	{
		300001,
		6,
		6,
		"10:17084:200"
	},
	{
		300001,
		7,
		7,
		"60:1:300"
	},
	{
		300001,
		8,
		8,
		"10:17084:200"
	},
	{
		300001,
		9,
		9,
		"60:1:300"
	},
	{
		300001,
		10,
		10,
		"8:1:1000000"
	},
	{
		300001,
		11,
		11,
		"10:17084:200"
	},
	{
		300001,
		12,
		12,
		"60:1:300"
	},
	{
		300001,
		13,
		13,
		"8:1:1000000"
	},
	{
		300001,
		14,
		14,
		"4:111:5"
	},
	{
		300001,
		15,
		15,
		"60:1:300"
	}
}
local t_dragon_pool_progress_prize = {
	[300001] = {
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

t_dragon_pool_progress_prize.dataList = dataList

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

return t_dragon_pool_progress_prize
