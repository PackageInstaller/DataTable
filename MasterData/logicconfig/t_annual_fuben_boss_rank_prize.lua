-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_annual_fuben_boss_rank_prize.lua

module("logicconfig.config.t_annual_fuben_boss_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		546001,
		{
			1,
			1
		},
		"1名",
		"13:504:1#104:2:1000#8:1:1000000"
	},
	{
		546001,
		{
			2,
			5
		},
		"2~5名",
		"13:504:1#104:2:800#8:1:800000"
	},
	{
		546001,
		{
			6,
			20
		},
		"6~20名",
		"13:504:1#104:2:600#8:1:600000"
	},
	{
		546001,
		{
			21,
			50
		},
		"21~50名",
		"13:504:1#104:2:400#8:1:400000"
	},
	{
		546001,
		{
			51,
			100
		},
		"51~100名",
		"13:504:1#104:2:200#8:1:200000"
	},
	{
		546001,
		{
			101,
			3000
		},
		"101~3000名",
		"13:504:1#104:2:100#8:1:100000"
	}
}
local t_annual_fuben_boss_rank_prize = {
	[546001] = {
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
			3000
		}] = dataList[6]
	}
}

t_annual_fuben_boss_rank_prize.dataList = dataList

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

return t_annual_fuben_boss_rank_prize
