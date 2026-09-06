-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_jieshen_clg_extreme_stage.lua

module("logicconfig.config.t_divine_jieshen_clg_extreme_stage", package.seeall)

local title = {
	stageId = 3,
	creepsMasterIdLeft = 4,
	creepsMasterIdRight = 6,
	compareMode = 5,
	activityId = 1,
	towerId = 2
}
local dataList = {
	{
		387001,
		1,
		1,
		1001,
		">=",
		1002
	},
	{
		387001,
		1,
		2,
		1003,
		"<=",
		1004
	},
	{
		387001,
		1,
		3,
		1005,
		"=",
		1006
	},
	{
		387001,
		2,
		1,
		1007,
		">",
		1008
	},
	{
		387001,
		2,
		2,
		1009,
		"<",
		1010
	},
	{
		387001,
		2,
		3,
		1011,
		"=",
		1012
	},
	{
		387001,
		3,
		1,
		1013,
		"=",
		1014
	},
	{
		387001,
		3,
		2,
		1015,
		"=",
		1016
	},
	{
		387001,
		3,
		3,
		1017,
		"=",
		1018
	}
}
local t_divine_jieshen_clg_extreme_stage = {
	[387001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8],
			dataList[9]
		}
	}
}

t_divine_jieshen_clg_extreme_stage.dataList = dataList

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

return t_divine_jieshen_clg_extreme_stage
