-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_peak_tower_circle_score.lua

module("logicconfig.config.t_peak_tower_circle_score", package.seeall)

local title = {
	score = 3,
	circle = 2,
	activityId = 1
}
local dataList = {
	{
		567001,
		{
			1,
			1
		},
		100
	},
	{
		567001,
		{
			2,
			2
		},
		70
	},
	{
		567001,
		{
			3,
			3
		},
		50
	},
	{
		567001,
		{
			4,
			4
		},
		30
	},
	{
		567001,
		{
			5,
			5
		},
		20
	},
	{
		567001,
		{
			6,
			30
		},
		10
	}
}
local t_peak_tower_circle_score = {
	[567001] = {
		[{
			1,
			1
		}] = dataList[1],
		[{
			2,
			2
		}] = dataList[2],
		[{
			3,
			3
		}] = dataList[3],
		[{
			4,
			4
		}] = dataList[4],
		[{
			5,
			5
		}] = dataList[5],
		[{
			6,
			30
		}] = dataList[6]
	}
}

t_peak_tower_circle_score.dataList = dataList

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

return t_peak_tower_circle_score
