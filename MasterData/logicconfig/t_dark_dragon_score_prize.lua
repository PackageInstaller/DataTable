-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dark_dragon_score_prize.lua

module("logicconfig.config.t_dark_dragon_score_prize", package.seeall)

local title = {
	score = 2,
	prize = 3,
	seasonId = 1
}
local dataList = {
	{
		1,
		3000,
		"104:2:100#4:30:5#4:11:30"
	},
	{
		1,
		6000,
		"104:2:100#4:30:5#4:11:30"
	},
	{
		1,
		9000,
		"104:2:100#4:30:5#4:11:30"
	},
	{
		1,
		12000,
		"104:2:100#4:30:5#4:12:30"
	},
	{
		1,
		15000,
		"104:2:100#4:30:5#4:12:30"
	},
	{
		1,
		18000,
		"104:2:100#4:30:5#4:12:30"
	},
	{
		1,
		21000,
		"104:2:100#4:30:5#4:13:30"
	},
	{
		1,
		24000,
		"104:2:100#4:30:5#4:13:30"
	},
	{
		1,
		27000,
		"104:2:100#4:30:5#4:13:30"
	},
	{
		1,
		30000,
		"104:2:100#4:30:5#4:14:30"
	},
	{
		1,
		33000,
		"104:2:100#4:30:5#4:14:30"
	},
	{
		1,
		36000,
		"104:2:100#4:30:5#4:14:30"
	},
	{
		1,
		39000,
		"104:2:100#4:30:5#4:120001:10"
	},
	{
		1,
		42000,
		"104:2:100#4:30:5#4:120001:10"
	},
	{
		1,
		50000,
		"14:33:1"
	}
}
local t_dark_dragon_score_prize = {
	{
		[3000] = dataList[1],
		[6000] = dataList[2],
		[9000] = dataList[3],
		[12000] = dataList[4],
		[15000] = dataList[5],
		[18000] = dataList[6],
		[21000] = dataList[7],
		[24000] = dataList[8],
		[27000] = dataList[9],
		[30000] = dataList[10],
		[33000] = dataList[11],
		[36000] = dataList[12],
		[39000] = dataList[13],
		[42000] = dataList[14],
		[50000] = dataList[15]
	}
}

t_dark_dragon_score_prize.dataList = dataList

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

return t_dark_dragon_score_prize
