-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_chuang_jing_road_grass_boss.lua

module("logicconfig.config.t_chuang_jing_road_grass_boss", package.seeall)

local title = {
	stageId = 3,
	activityId = 1,
	zoneId = 2,
	creepsMasterId = 4
}
local dataList = {
	{
		396001,
		4,
		1,
		107
	},
	{
		396001,
		4,
		2,
		108
	},
	{
		396001,
		4,
		3,
		109
	},
	{
		396001,
		5,
		1,
		110
	},
	{
		396001,
		5,
		2,
		111
	},
	{
		396001,
		5,
		3,
		112
	}
}
local t_chuang_jing_road_grass_boss = {
	[396001] = {
		[4] = {
			dataList[1],
			dataList[2],
			dataList[3]
		},
		[5] = {
			dataList[4],
			dataList[5],
			dataList[6]
		}
	}
}

t_chuang_jing_road_grass_boss.dataList = dataList

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

return t_chuang_jing_road_grass_boss
