-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_map_level.lua

module("logicconfig.config.t_season_mode_pve_map_level", package.seeall)

local title = {
	rankPoint = 3,
	seasonId = 1,
	level = 2
}
local dataList = {
	{
		1,
		1,
		1
	},
	{
		1,
		2,
		2
	},
	{
		1,
		3,
		3
	},
	{
		1,
		4,
		4
	},
	{
		1,
		5,
		5
	},
	{
		1,
		6,
		6
	},
	{
		2,
		1,
		1
	},
	{
		2,
		2,
		2
	},
	{
		2,
		3,
		3
	},
	{
		2,
		4,
		4
	},
	{
		2,
		5,
		5
	},
	{
		2,
		6,
		6
	},
	{
		3,
		1,
		1
	},
	{
		3,
		2,
		2
	},
	{
		3,
		3,
		3
	},
	{
		3,
		4,
		4
	},
	{
		3,
		5,
		5
	},
	{
		3,
		6,
		6
	}
}
local t_season_mode_pve_map_level = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	{
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_season_mode_pve_map_level.dataList = dataList

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

return t_season_mode_pve_map_level
