-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_weileita_normal_stage.lua

module("logicconfig.config.t_origin_weileita_normal_stage", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		561001,
		1,
		1007
	},
	{
		561001,
		2,
		1008
	},
	{
		561001,
		3,
		1009
	},
	{
		561001,
		4,
		1010
	},
	{
		561001,
		5,
		1011
	},
	{
		561001,
		6,
		1012
	},
	{
		561001,
		7,
		1013
	},
	{
		561001,
		8,
		1014
	},
	{
		561001,
		9,
		1015
	},
	{
		561001,
		10,
		1016
	},
	{
		561001,
		11,
		1017
	},
	{
		561001,
		12,
		1018
	}
}
local t_origin_weileita_normal_stage = {
	[561001] = {
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
		dataList[12]
	}
}

t_origin_weileita_normal_stage.dataList = dataList

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

return t_origin_weileita_normal_stage
