-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summer_treasure_snatch_mirror.lua

module("logicconfig.config.t_summer_treasure_snatch_mirror", package.seeall)

local title = {
	secondCreepsMasterId = 5,
	thirdCreepsMasterId = 6,
	mirrorId = 2,
	firstCreepsMasterId = 4,
	zdlRange = 3,
	activityId = 1
}
local dataList = {
	{
		623001,
		1,
		{
			0,
			5000000
		},
		1001,
		1002,
		1003
	},
	{
		623001,
		2,
		{
			0,
			5000000
		},
		1004,
		1005,
		1006
	},
	{
		623001,
		3,
		{
			0,
			5000000
		},
		1007,
		1008,
		1009
	},
	{
		623001,
		4,
		{
			0,
			5000000
		},
		1010,
		1011,
		1001
	}
}
local t_summer_treasure_snatch_mirror = {
	[623001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	}
}

t_summer_treasure_snatch_mirror.dataList = dataList

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

return t_summer_treasure_snatch_mirror
