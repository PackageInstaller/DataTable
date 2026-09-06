-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_angel_investor_stage.lua

module("logicconfig.config.t_angel_investor_stage", package.seeall)

local title = {
	stageId = 2,
	creepsMasterId = 3,
	activityId = 1,
	scoreUnit = 4
}
local dataList = {
	{
		588001,
		1,
		1001,
		10
	},
	{
		588001,
		2,
		1002,
		10
	},
	{
		588001,
		3,
		1003,
		10
	},
	{
		588001,
		4,
		1004,
		10
	},
	{
		588001,
		5,
		1005,
		10
	},
	{
		588001,
		6,
		1006,
		10
	},
	{
		588001,
		7,
		1007,
		10
	},
	{
		588001,
		8,
		1008,
		10
	},
	{
		588001,
		9,
		1009,
		10
	},
	{
		588001,
		10,
		1010,
		10
	},
	{
		588001,
		11,
		1011,
		10
	},
	{
		588001,
		12,
		1012,
		10
	},
	{
		588001,
		13,
		1013,
		10
	},
	{
		588001,
		14,
		1014,
		10
	},
	{
		588001,
		15,
		1015,
		10
	},
	{
		588001,
		16,
		1016,
		10
	},
	{
		588001,
		17,
		1017,
		10
	},
	{
		588001,
		18,
		1018,
		10
	},
	{
		588001,
		19,
		1019,
		10
	},
	{
		588001,
		20,
		1020,
		10
	}
}
local t_angel_investor_stage = {
	[588001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15],
		dataList[16],
		dataList[17],
		dataList[18],
		dataList[19],
		dataList[20]
	}
}

t_angel_investor_stage.dataList = dataList

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

return t_angel_investor_stage
