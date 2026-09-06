-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_psychic_ji_normal_stage.lua

module("logicconfig.config.t_origin_psychic_ji_normal_stage", package.seeall)

local title = {
	stageId = 2,
	passNeedEnergy = 6,
	prize = 5,
	originEnergy = 3,
	creepsMasterId = 4,
	settlePlan = 7,
	activityId = 1
}
local dataList = {
	{
		542001,
		1,
		0,
		1006,
		"8:1:1000000",
		40,
		{
			1
		}
	},
	{
		542001,
		2,
		0,
		1007,
		"4:433:10",
		40,
		{
			1
		}
	},
	{
		542001,
		3,
		0,
		1008,
		"4:90004:1",
		40,
		{
			1
		}
	},
	{
		542001,
		4,
		0,
		1009,
		"4:30006:40",
		40,
		{
			1
		}
	},
	{
		542001,
		5,
		0,
		1010,
		"4:433:10",
		40,
		{
			1
		}
	}
}
local t_origin_psychic_ji_normal_stage = {
	[542001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_origin_psychic_ji_normal_stage.dataList = dataList

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

return t_origin_psychic_ji_normal_stage
