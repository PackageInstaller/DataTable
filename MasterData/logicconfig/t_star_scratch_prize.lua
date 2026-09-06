-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_scratch_prize.lua

module("logicconfig.config.t_star_scratch_prize", package.seeall)

local title = {
	prizeId = 3,
	prize = 4,
	isBigPrize = 5,
	cycleId = 2,
	activityId = 1
}
local dataList = {
	{
		364001,
		1,
		1,
		"18:410:1",
		true
	},
	{
		364001,
		1,
		2,
		"4:90037:1",
		false
	},
	{
		364001,
		1,
		3,
		"4:503:340",
		false
	},
	{
		364001,
		1,
		4,
		"4:400002:10",
		false
	},
	{
		364001,
		2,
		1,
		"4:36:30",
		true
	},
	{
		364001,
		2,
		2,
		"4:36:5",
		false
	},
	{
		364001,
		3,
		1,
		"4:12101:10",
		true
	},
	{
		364001,
		3,
		2,
		"4:12102:5",
		false
	},
	{
		364001,
		3,
		3,
		"4:11002:9000",
		false
	},
	{
		364001,
		4,
		1,
		"8:1:33330000",
		true
	},
	{
		364001,
		4,
		2,
		"8:1:6660000",
		false
	},
	{
		364001,
		4,
		3,
		"8:1:2000000",
		false
	}
}
local t_star_scratch_prize = {
	[364001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4]
		},
		{
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8],
			dataList[9]
		},
		{
			dataList[10],
			dataList[11],
			dataList[12]
		}
	}
}

t_star_scratch_prize.dataList = dataList

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

return t_star_scratch_prize
