-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scene_tiling_config.lua

module("logicconfig.config.t_scene_tiling_config", package.seeall)

local title = {
	landform = 3,
	tileSizeY = 6,
	id = 1,
	angleRight = 8,
	edgeRight = 10,
	edgeLeft = 9,
	tileSizeX = 5,
	angleLeft = 7,
	airwall = 2,
	bkg = 11,
	tilesNum = 4
}
local dataList = {
	{
		1,
		"tiling_airwall",
		"grass",
		4,
		3.84,
		1.92,
		153.5,
		26.6,
		6.1,
		6.1,
		{
			"tiling_sky_cloud"
		}
	},
	{
		2,
		"tiling_airwall",
		"huodi",
		4,
		3.84,
		1.92,
		153.5,
		26.6,
		6.1,
		6.1,
		{
			"tiling_sky_cloud"
		}
	},
	{
		3,
		"tiling_airwall",
		"shadi",
		4,
		3.84,
		1.92,
		153.5,
		26.6,
		6.2,
		6.2,
		{
			"tiling_sky_cloud"
		}
	},
	{
		4,
		"tiling_airwall",
		"",
		0,
		3.84,
		1.92,
		153.5,
		26.6,
		6.3,
		6.3,
		{
			"tiling_sky_cloud"
		}
	}
}
local t_scene_tiling_config = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4]
}

t_scene_tiling_config.dataList = dataList

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

return t_scene_tiling_config
