-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_send_goddess_flower_progress_prize.lua

module("logicconfig.config.t_send_goddess_flower_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	progressPrizePlanId = 1,
	needIntimacy = 3
}
local dataList = {
	{
		1,
		1,
		30,
		"104:2:200"
	},
	{
		1,
		2,
		60,
		"4:14:30"
	},
	{
		1,
		3,
		90,
		"104:2:200"
	},
	{
		1,
		4,
		120,
		"4:14:40"
	},
	{
		1,
		5,
		150,
		"104:2:200"
	},
	{
		1,
		6,
		180,
		"4:14:50"
	},
	{
		1,
		7,
		210,
		"104:2:200"
	},
	{
		1,
		8,
		250,
		"4:14:60"
	},
	{
		1,
		9,
		300,
		"104:2:200"
	},
	{
		1,
		10,
		350,
		"4:14:60"
	},
	{
		1,
		11,
		400,
		"104:2:200"
	},
	{
		1,
		12,
		450,
		"4:14:60"
	},
	{
		1,
		13,
		500,
		"104:2:300"
	},
	{
		1,
		14,
		550,
		"4:14:60"
	},
	{
		1,
		15,
		600,
		"104:2:500"
	}
}
local t_send_goddess_flower_progress_prize = {
	{
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

t_send_goddess_flower_progress_prize.dataList = dataList

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

return t_send_goddess_flower_progress_prize
