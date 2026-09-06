-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miracle_hero_rank_prize.lua

module("logicconfig.config.t_miracle_hero_rank_prize", package.seeall)

local title = {
	prize = 4,
	title = 3,
	activityId = 1,
	rankRange = 2
}
local dataList = {
	{
		383001,
		{
			1,
			500
		},
		"前500名",
		"2:171:1#13:293:1#14:283:1"
	},
	{
		383001,
		{
			501,
			2000
		},
		"501-2000名",
		"13:293:1#14:283:1"
	},
	{
		383001,
		{
			2001,
			10000
		},
		"2001-10000名",
		"14:283:1"
	}
}
local t_miracle_hero_rank_prize = {
	[383001] = {
		[{
			1,
			500
		}] = dataList[1],
		[{
			501,
			2000
		}] = dataList[2],
		[{
			2001,
			10000
		}] = dataList[3]
	}
}

t_miracle_hero_rank_prize.dataList = dataList

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

return t_miracle_hero_rank_prize
