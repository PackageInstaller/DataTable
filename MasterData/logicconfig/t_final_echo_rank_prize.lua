-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_final_echo_rank_prize.lua

module("logicconfig.config.t_final_echo_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		495001,
		{
			1,
			1
		},
		"1名",
		"1:300071:-1:1#104:2:1000#8:1:1000000"
	},
	{
		495001,
		{
			2,
			5
		},
		"2~5名",
		"1:300071:-1:1#104:2:800#8:1:800000"
	},
	{
		495001,
		{
			6,
			20
		},
		"6~20名",
		"1:300071:-1:1#104:2:600#8:1:600000"
	},
	{
		495001,
		{
			21,
			50
		},
		"21~50名",
		"1:300071:-1:1#104:2:400#8:1:500000"
	},
	{
		495001,
		{
			51,
			100
		},
		"51~100名",
		"1:300071:-1:1#104:2:300#8:1:400000"
	},
	{
		495001,
		{
			101,
			1000
		},
		"101~1000名",
		"1:300071:-1:1#104:2:200#8:1:300000"
	}
}
local t_final_echo_rank_prize = {
	[495001] = {
		[{
			1,
			1
		}] = dataList[1],
		[{
			2,
			5
		}] = dataList[2],
		[{
			6,
			20
		}] = dataList[3],
		[{
			21,
			50
		}] = dataList[4],
		[{
			51,
			100
		}] = dataList[5],
		[{
			101,
			1000
		}] = dataList[6]
	}
}

t_final_echo_rank_prize.dataList = dataList

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

return t_final_echo_rank_prize
