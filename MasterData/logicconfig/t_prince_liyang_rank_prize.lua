-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_prince_liyang_rank_prize.lua

module("logicconfig.config.t_prince_liyang_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		509001,
		{
			1,
			50
		},
		"1-50名",
		"14:425:1#2:249:1#104:2:1000"
	},
	{
		509001,
		{
			51,
			100
		},
		"51-100名",
		"14:425:1#2:249:1#104:2:800"
	},
	{
		509001,
		{
			101,
			500
		},
		"101-500名",
		"14:425:1#2:249:1#104:2:600"
	},
	{
		509001,
		{
			501,
			1000
		},
		"501-1000名",
		"14:425:1#2:249:1#104:2:400"
	},
	{
		509001,
		{
			1001,
			3000
		},
		"1001-3000名",
		"14:425:1#2:249:1#104:2:200"
	}
}
local t_prince_liyang_rank_prize = {
	[509001] = {
		[{
			1,
			50
		}] = dataList[1],
		[{
			51,
			100
		}] = dataList[2],
		[{
			101,
			500
		}] = dataList[3],
		[{
			501,
			1000
		}] = dataList[4],
		[{
			1001,
			3000
		}] = dataList[5]
	}
}

t_prince_liyang_rank_prize.dataList = dataList

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

return t_prince_liyang_rank_prize
