-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_saint_knight_regress_normal_lottery_prize.lua

module("logicconfig.config.t_saint_knight_regress_normal_lottery_prize", package.seeall)

local title = {
	id = 2,
	prize = 3,
	activityId = 1,
	pos = 4
}
local dataList = {
	{
		483001,
		1,
		"8:1:500000",
		{
			-145,
			-81
		}
	},
	{
		483001,
		2,
		"4:31:3",
		{
			-126.1,
			-1.5
		}
	},
	{
		483001,
		3,
		"4:36:3",
		{
			-46,
			-79
		}
	}
}
local t_saint_knight_regress_normal_lottery_prize = {
	[483001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	}
}

t_saint_knight_regress_normal_lottery_prize.dataList = dataList

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

return t_saint_knight_regress_normal_lottery_prize
