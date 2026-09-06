-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_canton_opera_road_jigsaw_challenge.lua

module("logicconfig.config.t_canton_opera_road_jigsaw_challenge", package.seeall)

local title = {
	stagId = 2,
	skinId = 4,
	creepsMasterId = 3,
	planId = 1,
	stageName = 5
}
local dataList = {
	{
		1,
		1,
		1001,
		10142,
		"神秘关卡"
	},
	{
		1,
		2,
		1002,
		10143,
		"神秘关卡"
	},
	{
		1,
		3,
		1003,
		10144,
		"神秘关卡"
	},
	{
		1,
		4,
		1004,
		10145,
		"神秘关卡"
	},
	{
		1,
		5,
		1005,
		10146,
		"神秘关卡"
	},
	{
		1,
		6,
		1006,
		10142,
		"神秘关卡"
	},
	{
		1,
		7,
		1007,
		10143,
		"神秘关卡"
	},
	{
		1,
		8,
		1008,
		10144,
		"神秘关卡"
	},
	{
		1,
		9,
		1009,
		10145,
		"神秘关卡"
	},
	{
		1,
		10,
		1010,
		10146,
		"神秘关卡"
	},
	{
		1,
		11,
		1011,
		10142,
		"神秘关卡"
	},
	{
		1,
		12,
		1012,
		10143,
		"神秘关卡"
	},
	{
		1,
		13,
		1013,
		10144,
		"神秘关卡"
	},
	{
		1,
		14,
		1014,
		10145,
		"神秘关卡"
	},
	{
		1,
		15,
		1015,
		10146,
		"神秘关卡"
	}
}
local t_canton_opera_road_jigsaw_challenge = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_canton_opera_road_jigsaw_challenge.dataList = dataList

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

return t_canton_opera_road_jigsaw_challenge
