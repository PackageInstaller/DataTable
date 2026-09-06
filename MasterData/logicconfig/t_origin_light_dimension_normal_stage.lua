-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_light_dimension_normal_stage.lua

module("logicconfig.config.t_origin_light_dimension_normal_stage", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		610001,
		1,
		1007
	},
	{
		610001,
		2,
		1008
	},
	{
		610001,
		3,
		1009
	},
	{
		610001,
		4,
		1010
	},
	{
		610001,
		5,
		1011
	},
	{
		610001,
		6,
		1012
	},
	{
		610001,
		7,
		1013
	}
}
local t_origin_light_dimension_normal_stage = {
	[610001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7]
	}
}

t_origin_light_dimension_normal_stage.dataList = dataList

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

return t_origin_light_dimension_normal_stage
