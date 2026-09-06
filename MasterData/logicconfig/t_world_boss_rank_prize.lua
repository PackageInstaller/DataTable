-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_world_boss_rank_prize.lua

module("logicconfig.config.t_world_boss_rank_prize", package.seeall)

local title = {
	startRank = 2,
	id = 1,
	prize = 4,
	endRank = 3
}
local dataList = {
	{
		101,
		1,
		1,
		"9:60004:2#9:60003:3#4:503:3"
	},
	{
		101,
		2,
		3,
		"9:60004:1#9:60003:3#4:503:3"
	},
	{
		101,
		4,
		10,
		"9:60004:1#9:60003:2#4:503:3"
	},
	{
		101,
		11,
		50,
		"9:60003:3#4:503:3"
	},
	{
		101,
		51,
		100,
		"9:60003:2#9:60002:1#4:503:3"
	},
	{
		101,
		101,
		200,
		"9:60003:1#9:60002:2#4:503:3"
	},
	{
		101,
		201,
		500,
		"9:60002:3#4:503:3"
	},
	{
		101,
		501,
		19999,
		"9:60002:2#4:501:3"
	}
}
local t_world_boss_rank_prize = {
	[101] = {
		{
			dataList[1]
		},
		{
			[3] = dataList[2]
		},
		[4] = {
			[10] = dataList[3]
		},
		[11] = {
			[50] = dataList[4]
		},
		[51] = {
			[100] = dataList[5]
		},
		[101] = {
			[200] = dataList[6]
		},
		[201] = {
			[500] = dataList[7]
		},
		[501] = {
			[19999] = dataList[8]
		}
	}
}

t_world_boss_rank_prize.dataList = dataList

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

return t_world_boss_rank_prize
