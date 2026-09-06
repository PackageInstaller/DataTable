-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_beast_rich_man_total_rank_prize.lua

module("logicconfig.config.t_beast_rich_man_total_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		558001,
		{
			1,
			10
		},
		"1名",
		"1:300100:-1:1#8:1:200000#104:2:1000"
	},
	{
		558001,
		{
			11,
			100
		},
		"11~100名",
		"1:300100:-1:1#8:1:100000#104:2:500"
	},
	{
		558001,
		{
			101,
			1000
		},
		"101~1000名",
		"1:300100:-1:1#8:1:50000#104:2:500"
	},
	{
		558001,
		{
			1001,
			3000
		},
		"1001~3000名",
		"1:300100:-1:1#8:1:50000#104:2:500"
	},
	{
		558001,
		{
			3001,
			10000
		},
		"3001~10000名",
		"8:1:50000#104:2:500"
	}
}
local t_beast_rich_man_total_rank_prize = {
	[558001] = {
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
			1000
		}] = dataList[3],
		[{
			1001,
			3000
		}] = dataList[4],
		[{
			3001,
			10000
		}] = dataList[5]
	}
}

t_beast_rich_man_total_rank_prize.dataList = dataList

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

return t_beast_rich_man_total_rank_prize
