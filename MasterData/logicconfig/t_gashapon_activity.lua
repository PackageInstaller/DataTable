-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_gashapon_activity.lua

module("logicconfig.config.t_gashapon_activity", package.seeall)

local title = {
	dailyTimes = 6,
	isShowTimes = 7,
	tenCost = 3,
	oneCost = 2,
	rate = 4,
	talkTab = 8,
	activityId = 1,
	poolId = 5
}
local dataList = {
	{
		32001,
		"8:1:20",
		"8:1:180",
		1000,
		1,
		30,
		true,
		{
			"大奖近在眼前咯~",
			"我有预感，好运就要降临了！再试一次？"
		}
	},
	{
		32002,
		"8:1:20",
		"8:1:180",
		1000,
		2,
		30,
		false,
		{}
	},
	{
		32003,
		"8:1:20",
		"8:1:180",
		1000,
		3,
		30,
		false,
		{}
	}
}
local t_gashapon_activity = {
	[32001] = dataList[1],
	[32002] = dataList[2],
	[32003] = dataList[3]
}

t_gashapon_activity.dataList = dataList

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

return t_gashapon_activity
