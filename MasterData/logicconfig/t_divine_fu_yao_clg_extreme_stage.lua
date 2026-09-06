-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_fu_yao_clg_extreme_stage.lua

module("logicconfig.config.t_divine_fu_yao_clg_extreme_stage", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		502001,
		1,
		1001
	},
	{
		502001,
		2,
		1002
	},
	{
		502001,
		3,
		1003
	},
	{
		502001,
		4,
		1004
	},
	{
		502001,
		5,
		1005
	},
	{
		502001,
		6,
		1006
	}
}
local t_divine_fu_yao_clg_extreme_stage = {
	[502001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_divine_fu_yao_clg_extreme_stage.dataList = dataList

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

return t_divine_fu_yao_clg_extreme_stage
