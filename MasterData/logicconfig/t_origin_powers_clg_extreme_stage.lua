-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_powers_clg_extreme_stage.lua

module("logicconfig.config.t_origin_powers_clg_extreme_stage", package.seeall)

local title = {
	stageId = 2,
	signBuffId = 4,
	buffNum = 5,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		576001,
		1,
		1001,
		20071104,
		3
	},
	{
		576001,
		2,
		1002,
		20071104,
		3
	},
	{
		576001,
		3,
		1003,
		20071104,
		3
	},
	{
		576001,
		4,
		1004,
		20071104,
		3
	},
	{
		576001,
		5,
		1005,
		20071104,
		3
	},
	{
		576001,
		6,
		1006,
		20071104,
		3
	}
}
local t_origin_powers_clg_extreme_stage = {
	[576001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_origin_powers_clg_extreme_stage.dataList = dataList

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

return t_origin_powers_clg_extreme_stage
