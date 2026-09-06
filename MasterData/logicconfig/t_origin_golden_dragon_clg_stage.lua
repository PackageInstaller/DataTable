-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_golden_dragon_clg_stage.lua

module("logicconfig.config.t_origin_golden_dragon_clg_stage", package.seeall)

local title = {
	stageId = 2,
	openTime = 3,
	activityId = 1,
	creepsMasterId = 4
}
local dataList = {
	{
		617001,
		1,
		nil,
		1001
	},
	{
		617001,
		2,
		nil,
		1002
	},
	{
		617001,
		3,
		nil,
		1003
	},
	{
		617001,
		4,
		nil,
		1004
	},
	{
		617001,
		5,
		nil,
		1005
	},
	{
		617001,
		6,
		nil,
		1006
	},
	{
		617001,
		7,
		nil,
		1007
	},
	{
		617001,
		8,
		nil,
		1008
	}
}
local t_origin_golden_dragon_clg_stage = {
	[617001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_origin_golden_dragon_clg_stage.dataList = dataList

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

return t_origin_golden_dragon_clg_stage
