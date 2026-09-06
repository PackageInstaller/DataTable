-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_zhong_fei_clg_normal_prize.lua

module("logicconfig.config.t_divine_zhong_fei_clg_normal_prize", package.seeall)

local title = {
	prizeId = 2,
	damage = 3,
	activityId = 1,
	prize = 4
}
local dataList = {
	{
		515001,
		1,
		"2500000",
		"8:1:1000000"
	},
	{
		515001,
		2,
		"5000000",
		"4:399:5"
	},
	{
		515001,
		3,
		"7500000",
		"4:90004:1"
	},
	{
		515001,
		4,
		"10000000",
		"4:399:5"
	},
	{
		515001,
		5,
		"12500000",
		"4:30006:40"
	},
	{
		515001,
		6,
		"15000000",
		"4:399:10"
	}
}
local t_divine_zhong_fei_clg_normal_prize = {
	[515001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_zhong_fei_clg_normal_prize.dataList = dataList

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

return t_divine_zhong_fei_clg_normal_prize
