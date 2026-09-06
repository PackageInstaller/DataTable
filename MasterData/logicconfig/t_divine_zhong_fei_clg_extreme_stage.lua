-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_zhong_fei_clg_extreme_stage.lua

module("logicconfig.config.t_divine_zhong_fei_clg_extreme_stage", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		515001,
		1,
		1003
	},
	{
		515001,
		2,
		1005
	},
	{
		515001,
		3,
		1006
	},
	{
		515001,
		4,
		1001
	},
	{
		515001,
		5,
		1002
	},
	{
		515001,
		6,
		1004
	}
}
local t_divine_zhong_fei_clg_extreme_stage = {
	[515001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_zhong_fei_clg_extreme_stage.dataList = dataList

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

return t_divine_zhong_fei_clg_extreme_stage
