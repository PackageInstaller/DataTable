-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_basic_benefits_daily_prize.lua

module("logicconfig.config.t_basic_benefits_daily_prize", package.seeall)

local title = {
	cost = 5,
	prizeRedId = 7,
	pushId = 6,
	endTime = 3,
	index = 1,
	prize = 4,
	startTime = 2
}
local dataList = {
	{
		0,
		"06:00:00",
		"23:59:59",
		"8:1:50000#104:2:50#4:23:5#4:30:5",
		"105:2:100",
		11,
		"c2"
	},
	{
		1,
		"12:00:00",
		"23:59:59",
		"8:1:50000#104:2:50#4:23:2#4:71002:1",
		"105:2:100",
		14,
		"c3"
	},
	{
		2,
		"18:00:00",
		"23:59:59",
		"8:1:50000#104:2:50#4:23:2#4:72003:2",
		"105:2:100",
		15,
		"c4"
	}
}
local t_basic_benefits_daily_prize = {
	[0] = dataList[1],
	dataList[2],
	dataList[3]
}

t_basic_benefits_daily_prize.dataList = dataList

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

return t_basic_benefits_daily_prize
