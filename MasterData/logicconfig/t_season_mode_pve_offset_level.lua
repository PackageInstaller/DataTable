-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_offset_level.lua

module("logicconfig.config.t_season_mode_pve_offset_level", package.seeall)

local title = {
	upperLimit = 3,
	lowerLimit = 4,
	seasonId = 1,
	level = 2
}
local dataList = {
	{
		1,
		1,
		40,
		0
	},
	{
		1,
		2,
		80,
		40
	},
	{
		1,
		3,
		120,
		80
	},
	{
		1,
		4,
		160,
		120
	},
	{
		2,
		1,
		40,
		0
	},
	{
		2,
		2,
		80,
		40
	},
	{
		2,
		3,
		120,
		80
	},
	{
		2,
		4,
		160,
		120
	},
	{
		3,
		1,
		1000,
		0
	}
}
local t_season_mode_pve_offset_level = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	{
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	},
	{
		dataList[9]
	}
}

t_season_mode_pve_offset_level.dataList = dataList

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

return t_season_mode_pve_offset_level
