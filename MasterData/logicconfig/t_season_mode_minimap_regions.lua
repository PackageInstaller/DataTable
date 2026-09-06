-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_minimap_regions.lua

module("logicconfig.config.t_season_mode_minimap_regions", package.seeall)

local title = {
	Id = 2,
	regionParams = 3,
	seasonId = 1
}
local dataList = {
	{
		2,
		1,
		{
			4.84,
			36.38,
			5.06,
			35.26
		}
	},
	{
		2,
		2,
		{
			38.73,
			75.97,
			5.4,
			31.9
		}
	},
	{
		2,
		3,
		{
			78.65,
			109.18,
			16.13,
			39.28
		}
	},
	{
		2,
		4,
		{
			5.59,
			40.11,
			39.65,
			65.34
		}
	},
	{
		2,
		5,
		{
			42.75,
			74.62,
			37.27,
			65.12
		}
	},
	{
		2,
		6,
		{
			75.97,
			110.19,
			39.28,
			65.12
		}
	},
	{
		2,
		7,
		{
			10.13,
			42.42,
			64.98,
			94.58
		}
	},
	{
		2,
		8,
		{
			43.12,
			73.89,
			66.84,
			98.73
		}
	},
	{
		2,
		9,
		{
			75.01,
			109.16,
			64.97,
			92.36
		}
	},
	{
		3,
		1,
		{
			0.04,
			44.34,
			2.77,
			64.42
		}
	}
}
local t_season_mode_minimap_regions = {
	[2] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	},
	[3] = {
		dataList[10]
	}
}

t_season_mode_minimap_regions.dataList = dataList

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

return t_season_mode_minimap_regions
