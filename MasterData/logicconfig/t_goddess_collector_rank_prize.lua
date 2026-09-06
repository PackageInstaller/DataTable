-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_collector_rank_prize.lua

module("logicconfig.config.t_goddess_collector_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		124007,
		{
			1,
			50
		},
		"第1-50名",
		"2:202:1#104:2:1000#8:1:1000000"
	},
	{
		124007,
		{
			50,
			100
		},
		"第51-100名",
		"2:202:1#104:2:800#8:1:1000000"
	},
	{
		124007,
		{
			101,
			1000
		},
		"第101-1000名",
		"2:202:1#104:2:600#8:1:1000000"
	},
	{
		124007,
		{
			1001,
			5000
		},
		"第1001-5000名",
		"2:202:1#104:2:500#8:1:1000000"
	}
}
local t_goddess_collector_rank_prize = {
	[124007] = {
		[{
			1,
			50
		}] = dataList[1],
		[{
			50,
			100
		}] = dataList[2],
		[{
			101,
			1000
		}] = dataList[3],
		[{
			1001,
			5000
		}] = dataList[4]
	}
}

t_goddess_collector_rank_prize.dataList = dataList

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

return t_goddess_collector_rank_prize
