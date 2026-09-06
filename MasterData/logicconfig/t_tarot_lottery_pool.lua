-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_tarot_lottery_pool.lua

module("logicconfig.config.t_tarot_lottery_pool", package.seeall)

local title = {
	prizeId = 2,
	prize = 3,
	activityId = 1,
	hitBigPrize = 4
}
local dataList = {
	{
		345001,
		1,
		"8:1:10000",
		false
	},
	{
		345001,
		2,
		"4:5200:1",
		false
	},
	{
		345001,
		3,
		"4:30002:2",
		false
	},
	{
		345001,
		4,
		"4:2:4",
		false
	},
	{
		345001,
		5,
		"4:502:4",
		false
	},
	{
		345001,
		6,
		"4:901:100",
		false
	},
	{
		345001,
		7,
		"4:30:2",
		false
	},
	{
		345001,
		8,
		"",
		true
	}
}
local t_tarot_lottery_pool = {
	[345001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_tarot_lottery_pool.dataList = dataList

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

return t_tarot_lottery_pool
