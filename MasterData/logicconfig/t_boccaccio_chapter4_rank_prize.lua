-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_boccaccio_chapter4_rank_prize.lua

module("logicconfig.config.t_boccaccio_chapter4_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		580001,
		{
			1,
			10
		},
		"1~10名",
		"1:300104:-1:1#13:548:1#104:2:1000#8:1:1000000"
	},
	{
		580001,
		{
			11,
			100
		},
		"11~100名",
		"1:300104:-1:1#13:548:1#104:2:800#8:1:800000"
	},
	{
		580001,
		{
			101,
			500
		},
		"101~500名",
		"1:300104:-1:1#13:548:1#104:2:600#8:1:600000"
	},
	{
		580001,
		{
			501,
			1500
		},
		"501~1500名",
		"1:300104:-1:1#13:548:1#104:2:200#8:1:300000"
	},
	{
		580001,
		{
			1501,
			3000
		},
		"1501~3000名",
		"13:548:1#104:2:100#8:1:300000"
	}
}
local t_boccaccio_chapter4_rank_prize = {
	[580001] = {
		[{
			1,
			10
		}] = dataList[1],
		[{
			11,
			100
		}] = dataList[2],
		[{
			101,
			500
		}] = dataList[3],
		[{
			501,
			1500
		}] = dataList[4],
		[{
			1501,
			3000
		}] = dataList[5]
	}
}

t_boccaccio_chapter4_rank_prize.dataList = dataList

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

return t_boccaccio_chapter4_rank_prize
