-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_competition_progress_prize.lua

module("logicconfig.config.t_goddess_competition_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		453002,
		1,
		"1000",
		"10:453005:1"
	},
	{
		453002,
		2,
		"2000",
		"10:453003:1000"
	},
	{
		453002,
		3,
		"3000",
		"10:453005:2"
	},
	{
		453002,
		4,
		"5000",
		"10:453003:1000"
	},
	{
		453002,
		5,
		"10000",
		"10:453006:1"
	},
	{
		453002,
		6,
		"15000",
		"10:453003:1000"
	},
	{
		453002,
		7,
		"20000",
		"10:453006:1"
	},
	{
		453002,
		8,
		"30000",
		"10:453003:1500"
	},
	{
		453002,
		9,
		"40000",
		"10:453006:1"
	},
	{
		453002,
		10,
		"50000",
		"10:453003:1500"
	},
	{
		453002,
		11,
		"60000",
		"10:453007:1"
	},
	{
		453002,
		12,
		"70000",
		"10:453003:2000"
	},
	{
		453002,
		13,
		"80000",
		"10:453007:1"
	},
	{
		453002,
		14,
		"90000",
		"10:453003:2000"
	},
	{
		453002,
		15,
		"100000",
		"10:453007:1"
	}
}
local t_goddess_competition_progress_prize = {
	[453002] = {
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

t_goddess_competition_progress_prize.dataList = dataList

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

return t_goddess_competition_progress_prize
