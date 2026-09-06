-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_peak_tower_alive_num_score.lua

module("logicconfig.config.t_peak_tower_alive_num_score", package.seeall)

local title = {
	score = 3,
	activityId = 1,
	aliveNum = 2
}
local dataList = {
	{
		567001,
		{
			6,
			6
		},
		100
	},
	{
		567001,
		{
			5,
			5
		},
		70
	},
	{
		567001,
		{
			4,
			4
		},
		50
	},
	{
		567001,
		{
			3,
			3
		},
		30
	},
	{
		567001,
		{
			2,
			2
		},
		20
	},
	{
		567001,
		{
			1,
			1
		},
		10
	}
}
local t_peak_tower_alive_num_score = {
	[567001] = {
		[{
			6,
			6
		}] = dataList[1],
		[{
			5,
			5
		}] = dataList[2],
		[{
			4,
			4
		}] = dataList[3],
		[{
			3,
			3
		}] = dataList[4],
		[{
			2,
			2
		}] = dataList[5],
		[{
			1,
			1
		}] = dataList[6]
	}
}

t_peak_tower_alive_num_score.dataList = dataList

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

return t_peak_tower_alive_num_score
