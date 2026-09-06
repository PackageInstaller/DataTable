-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_canton_opera_road_boss_challenge.lua

module("logicconfig.config.t_canton_opera_road_boss_challenge", package.seeall)

local title = {
	creepsMasterId = 3,
	helpPetIds = 4,
	planId = 1,
	times = 2
}
local dataList = {
	{
		1,
		1,
		2001,
		{
			1000000001
		}
	},
	{
		1,
		2,
		2002,
		{
			1000000002
		}
	},
	{
		1,
		3,
		2003,
		{
			1000000003
		}
	},
	{
		1,
		4,
		2004,
		{
			1000000004
		}
	}
}
local t_canton_opera_road_boss_challenge = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_canton_opera_road_boss_challenge.dataList = dataList

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

return t_canton_opera_road_boss_challenge
