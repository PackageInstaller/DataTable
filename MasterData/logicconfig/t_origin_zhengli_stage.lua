-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_origin_zhengli_stage.lua

module("logicconfig.config.t_origin_zhengli_stage", package.seeall)

local title = {
	stageId = 2,
	settlePlan = 7,
	canActivateBuff = 6,
	creepsMasterId = 5,
	xPosition = 3,
	yPosition = 4,
	activityId = 1,
	fmtTips = 8
}
local dataList = {
	{
		587001,
		1,
		1,
		1,
		1001,
		{
			1,
			4
		},
		{
			1,
			2,
			3
		},
		"轮回点数：通过存活数，回合数，超杀次数获得"
	},
	{
		587001,
		2,
		1,
		2,
		1004,
		{
			2
		},
		{
			1,
			2,
			3
		},
		"轮回点数：通过存活数，回合数，超杀次数获得"
	},
	{
		587001,
		3,
		1,
		3,
		1007,
		{
			1,
			5
		},
		{
			1,
			2,
			3
		},
		"轮回点数：通过存活数，回合数，超杀次数获得"
	},
	{
		587001,
		4,
		2,
		1,
		1002,
		{
			1,
			7
		},
		{
			1,
			2,
			3
		},
		"轮回点数：通过存活数，回合数，超杀次数获得"
	},
	{
		587001,
		5,
		2,
		2,
		1005,
		{},
		{
			1,
			2,
			3
		},
		"轮回点数：通过存活数，回合数，超杀次数获得"
	},
	{
		587001,
		6,
		2,
		3,
		1008,
		{
			3
		},
		{
			1,
			2,
			3
		},
		"轮回点数：通过存活数，回合数，超杀次数获得"
	},
	{
		587001,
		7,
		3,
		1,
		1003,
		{
			1,
			5
		},
		{
			1,
			2,
			3
		},
		"轮回点数：通过存活数，回合数，超杀次数获得"
	},
	{
		587001,
		8,
		3,
		2,
		1006,
		{
			2
		},
		{
			1,
			2,
			3
		},
		"轮回点数：通过存活数，回合数，超杀次数获得"
	},
	{
		587001,
		9,
		3,
		3,
		1009,
		{
			1,
			6
		},
		{
			1,
			2,
			3
		},
		"轮回点数：通过存活数，回合数，超杀次数获得"
	}
}
local t_origin_zhengli_stage = {
	[587001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_origin_zhengli_stage.dataList = dataList

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

return t_origin_zhengli_stage
