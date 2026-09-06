-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fame_hall_vote_progress_prize.lua

module("logicconfig.config.t_fame_hall_vote_progress_prize", package.seeall)

local title = {
	prizeId = 2,
	prize = 4,
	activityId = 1,
	progress = 3
}
local dataList = {
	{
		541001,
		1,
		5,
		"8:1:1000000#4:400004:1"
	},
	{
		541001,
		2,
		10,
		"8:1:1000000#4:400004:1"
	},
	{
		541001,
		3,
		15,
		"8:1:2000000#4:400004:2"
	},
	{
		541001,
		4,
		20,
		"8:1:2000000#4:400004:2"
	},
	{
		541001,
		5,
		25,
		"8:1:2000000#4:400004:2"
	},
	{
		541001,
		6,
		30,
		"8:1:2000000#4:400004:2"
	}
}
local t_fame_hall_vote_progress_prize = {
	[541001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_fame_hall_vote_progress_prize.dataList = dataList

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

return t_fame_hall_vote_progress_prize
