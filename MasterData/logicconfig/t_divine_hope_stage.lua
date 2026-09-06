-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_hope_stage.lua

module("logicconfig.config.t_divine_hope_stage", package.seeall)

local title = {
	stageId = 2,
	stagePlanId = 1,
	creepsMasterId = 3
}
local dataList = {
	{
		1,
		1,
		1001
	},
	{
		1,
		2,
		1002
	},
	{
		1,
		3,
		1003
	},
	{
		1,
		4,
		1004
	},
	{
		1,
		5,
		1005
	},
	{
		1,
		6,
		1006
	},
	{
		2,
		1,
		1007
	},
	{
		2,
		2,
		1008
	},
	{
		2,
		3,
		1009
	},
	{
		2,
		4,
		1010
	},
	{
		2,
		5,
		1011
	},
	{
		2,
		6,
		1012
	},
	{
		3,
		1,
		1013
	},
	{
		3,
		2,
		1014
	},
	{
		3,
		3,
		1015
	},
	{
		3,
		4,
		1016
	},
	{
		3,
		5,
		1017
	},
	{
		3,
		6,
		1018
	}
}
local t_divine_hope_stage = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	},
	{
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18]
	}
}

t_divine_hope_stage.dataList = dataList

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

return t_divine_hope_stage
