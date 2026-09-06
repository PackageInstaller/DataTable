-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hex_lineup_endless_rank_prize.lua

module("logicconfig.config.t_hex_lineup_endless_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		590001,
		{
			1,
			1
		},
		"1名",
		"2:314:1#8:1:200000#104:2:1000"
	},
	{
		590001,
		{
			2,
			10
		},
		"2~10名",
		"2:314:1#8:1:100000#104:2:500"
	},
	{
		590001,
		{
			11,
			100
		},
		"11~100名",
		"2:314:1#8:1:50000#104:2:400"
	},
	{
		590001,
		{
			101,
			1000
		},
		"101~1000名",
		"2:314:1#8:1:40000#104:2:300"
	},
	{
		590001,
		{
			1001,
			3000
		},
		"1001~3000名",
		"2:314:1#8:1:30000#104:2:200"
	}
}
local t_hex_lineup_endless_rank_prize = {
	[590001] = {
		[{
			1,
			1
		}] = dataList[1],
		[{
			2,
			10
		}] = dataList[2],
		[{
			11,
			100
		}] = dataList[3],
		[{
			101,
			1000
		}] = dataList[4],
		[{
			1001,
			3000
		}] = dataList[5]
	}
}

t_hex_lineup_endless_rank_prize.dataList = dataList

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

return t_hex_lineup_endless_rank_prize
