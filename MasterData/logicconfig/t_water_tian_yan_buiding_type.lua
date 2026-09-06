-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_water_tian_yan_buiding_type.lua

module("logicconfig.config.t_water_tian_yan_buiding_type", package.seeall)

local title = {
	formConditionId = 4,
	typeId = 2,
	activityId = 1,
	randomStageNum = 3
}
local dataList = {
	{
		305001,
		1,
		2,
		170
	},
	{
		305001,
		2,
		3,
		171
	},
	{
		305002,
		1,
		2,
		89
	},
	{
		305002,
		2,
		3,
		88
	},
	{
		305003,
		1,
		2,
		69
	},
	{
		305003,
		2,
		3,
		69
	}
}
local t_water_tian_yan_buiding_type = {
	[305001] = {
		dataList[1],
		dataList[2]
	},
	[305002] = {
		dataList[3],
		dataList[4]
	},
	[305003] = {
		dataList[5],
		dataList[6]
	}
}

t_water_tian_yan_buiding_type.dataList = dataList

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

return t_water_tian_yan_buiding_type
