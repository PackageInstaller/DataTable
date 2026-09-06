-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_bounty_lottery_progress_prize.lua

module("logicconfig.config.t_divine_bounty_lottery_progress_prize", package.seeall)

local title = {
	prizeId = 1,
	prize = 3,
	times = 2
}
local dataList = {
	{
		1,
		30,
		"8:43:500"
	},
	{
		2,
		60,
		"8:43:1000"
	},
	{
		3,
		90,
		"8:43:1000"
	},
	{
		4,
		120,
		"8:43:2000"
	}
}
local t_divine_bounty_lottery_progress_prize = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_divine_bounty_lottery_progress_prize.dataList = dataList

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

return t_divine_bounty_lottery_progress_prize
