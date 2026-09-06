-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_empress_extreme_clg_stage.lua

module("logicconfig.config.t_divine_empress_extreme_clg_stage", package.seeall)

local title = {
	stageId = 2,
	name = 4,
	activityId = 1,
	creepsMasterId = 3
}
local dataList = {
	{
		485001,
		1,
		1001,
		"第1关"
	},
	{
		485001,
		2,
		1002,
		"第2关"
	},
	{
		485001,
		3,
		1003,
		"第3关"
	},
	{
		485001,
		4,
		1004,
		"第4关"
	},
	{
		485001,
		5,
		1005,
		"第5关"
	},
	{
		485001,
		6,
		1006,
		"第6关"
	}
}
local t_divine_empress_extreme_clg_stage = {
	[485001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_empress_extreme_clg_stage.dataList = dataList

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

return t_divine_empress_extreme_clg_stage
