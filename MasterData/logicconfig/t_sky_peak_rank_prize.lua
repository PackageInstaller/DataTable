-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sky_peak_rank_prize.lua

module("logicconfig.config.t_sky_peak_rank_prize", package.seeall)

local title = {
	id = 2,
	prize = 4,
	activityId = 1,
	rankRange = 3
}
local dataList = {
	{
		592001,
		1,
		{
			1,
			10
		},
		"1:300109:-1:1#104:2:1000#8:1:1000000"
	},
	{
		592001,
		2,
		{
			11,
			100
		},
		"1:300109:-1:1#104:2:800#8:1:800000"
	},
	{
		592001,
		3,
		{
			101,
			1000
		},
		"1:300109:-1:1#104:2:600#8:1:600000"
	},
	{
		592001,
		4,
		{
			1001,
			5000
		},
		"1:300109:-1:1#104:2:400#8:1:400000"
	},
	{
		592002,
		1,
		{
			1,
			10
		},
		"1:300113:-1:1#104:2:1000#8:1:1000000"
	},
	{
		592002,
		2,
		{
			11,
			100
		},
		"1:300113:-1:1#104:2:800#8:1:800000"
	},
	{
		592002,
		3,
		{
			101,
			1000
		},
		"1:300113:-1:1#104:2:600#8:1:600000"
	},
	{
		592002,
		4,
		{
			1001,
			5000
		},
		"1:300113:-1:1#104:2:400#8:1:400000"
	}
}
local t_sky_peak_rank_prize = {
	[592001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[592002] = {
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_sky_peak_rank_prize.dataList = dataList

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

return t_sky_peak_rank_prize
