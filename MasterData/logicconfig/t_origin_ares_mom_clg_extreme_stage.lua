-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_ares_mom_clg_extreme_stage.lua

module("logicconfig.config.t_origin_ares_mom_clg_extreme_stage", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		549001,
		1,
		1001
	},
	{
		549001,
		2,
		1002
	},
	{
		549001,
		3,
		1003
	},
	{
		549001,
		4,
		1004
	},
	{
		549001,
		5,
		1005
	},
	{
		549001,
		6,
		1006
	}
}
local t_origin_ares_mom_clg_extreme_stage = {
	[549001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_origin_ares_mom_clg_extreme_stage.dataList = dataList

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

return t_origin_ares_mom_clg_extreme_stage
