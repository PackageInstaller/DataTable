-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_ci_yuan_stage.lua

module("logicconfig.config.t_divine_king_ci_yuan_stage", package.seeall)

local title = {
	stageId = 2,
	stagePlanId = 1,
	creepsMasterId = 3,
	targetCount = 4
}
local dataList = {
	{
		1,
		1,
		1001,
		5
	},
	{
		1,
		2,
		1002,
		5
	},
	{
		1,
		3,
		1003,
		5
	},
	{
		1,
		4,
		1004,
		5
	},
	{
		1,
		5,
		1005,
		5
	},
	{
		2,
		1,
		2001,
		10
	},
	{
		2,
		2,
		2002,
		10
	},
	{
		2,
		3,
		2003,
		10
	},
	{
		2,
		4,
		2004,
		10
	},
	{
		2,
		5,
		2005,
		10
	},
	{
		3,
		1,
		3001,
		25
	},
	{
		3,
		2,
		3002,
		25
	},
	{
		3,
		3,
		3003,
		25
	},
	{
		3,
		4,
		3004,
		25
	},
	{
		3,
		5,
		3005,
		25
	}
}
local t_divine_king_ci_yuan_stage = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_divine_king_ci_yuan_stage.dataList = dataList

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

return t_divine_king_ci_yuan_stage
