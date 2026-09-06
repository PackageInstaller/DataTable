-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_season_mode_pve_doppelganger.lua

module("logicconfig.config.t_season_mode_pve_doppelganger", package.seeall)

local title = {
	creepsMasterId = 3,
	seasonId = 1,
	doppelgangerId = 2,
	skinId = 4
}
local dataList = {
	{
		1,
		1,
		5001,
		20019
	},
	{
		1,
		2,
		5002,
		20019
	},
	{
		1,
		3,
		5003,
		20019
	},
	{
		2,
		1,
		5001,
		10019
	},
	{
		2,
		2,
		5002,
		10020
	},
	{
		2,
		3,
		5003,
		10021
	},
	{
		3,
		1,
		35001,
		20020
	},
	{
		3,
		2,
		35002,
		20020
	},
	{
		3,
		3,
		35003,
		20020
	}
}
local t_season_mode_pve_doppelganger = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_season_mode_pve_doppelganger.dataList = dataList

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

return t_season_mode_pve_doppelganger
