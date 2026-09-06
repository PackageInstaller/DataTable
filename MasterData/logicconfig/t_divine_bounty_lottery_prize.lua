-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_bounty_lottery_prize.lua

module("logicconfig.config.t_divine_bounty_lottery_prize", package.seeall)

local title = {
	id = 1,
	quality = 3,
	prize = 2
}
local dataList = {
	{
		1,
		"8:43:10000",
		100
	},
	{
		2,
		"8:43:100",
		300
	},
	{
		3,
		"8:43:20",
		500
	},
	{
		4,
		"8:43:7",
		700
	},
	{
		5,
		"8:43:2500",
		200
	},
	{
		6,
		"8:43:50",
		400
	},
	{
		7,
		"8:43:10",
		600
	},
	{
		8,
		"8:43:5",
		800
	}
}
local t_divine_bounty_lottery_prize = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8]
}

t_divine_bounty_lottery_prize.dataList = dataList

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

return t_divine_bounty_lottery_prize
