-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_an_normal_stage.lua

module("logicconfig.config.t_origin_an_normal_stage", package.seeall)

local title = {
	groupId = 2,
	stageId = 3,
	activityId = 1,
	creepsMasterId = 4
}
local dataList = {
	{
		589001,
		1,
		1,
		1007
	},
	{
		589001,
		1,
		2,
		1008
	},
	{
		589001,
		1,
		3,
		1009
	},
	{
		589001,
		2,
		1,
		1010
	},
	{
		589001,
		2,
		2,
		1011
	},
	{
		589001,
		2,
		3,
		1012
	},
	{
		589001,
		3,
		1,
		1013
	},
	{
		589001,
		3,
		2,
		1014
	},
	{
		589001,
		3,
		3,
		1015
	},
	{
		589001,
		4,
		1,
		1016
	},
	{
		589001,
		4,
		2,
		1017
	},
	{
		589001,
		4,
		3,
		1018
	}
}
local t_origin_an_normal_stage = {
	[589001] = {
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
		},
		{
			dataList[10],
			dataList[11],
			dataList[12]
		}
	}
}

t_origin_an_normal_stage.dataList = dataList

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

return t_origin_an_normal_stage
