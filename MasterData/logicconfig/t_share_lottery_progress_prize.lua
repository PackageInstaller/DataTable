-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_share_lottery_progress_prize.lua

module("logicconfig.config.t_share_lottery_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 3,
	activityId = 1,
	needShareCount = 4
}
local dataList = {
	{
		448001,
		1,
		"4:31:3",
		1000
	},
	{
		448001,
		2,
		"4:31:3",
		3000
	},
	{
		448001,
		3,
		"4:31:3",
		5000
	},
	{
		448001,
		4,
		"4:31:3",
		10000
	},
	{
		448001,
		5,
		"4:31:4",
		20000
	},
	{
		448001,
		6,
		"4:31:4",
		30000
	}
}
local t_share_lottery_progress_prize = {
	[448001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_share_lottery_progress_prize.dataList = dataList

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

return t_share_lottery_progress_prize
